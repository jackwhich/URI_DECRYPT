-- Copyright (C) by Yichun Zhang (agentzh)
-- modify by Demark
local ffi = require "ffi"
local ffi_new = ffi.new
local ffi_gc = ffi.gc
local ffi_str = ffi.string
local ffi_copy = ffi.copy
local C = ffi.C
local setmetatable = setmetatable

local _M = {}

local mt = {
    __index = _M
}

ffi.cdef [[
typedef struct engine_st ENGINE;

typedef struct evp_cipher_st EVP_CIPHER;
typedef struct evp_cipher_ctx_st EVP_CIPHER_CTX;

const EVP_CIPHER *EVP_aes_256_cbc(void);

EVP_CIPHER_CTX *EVP_CIPHER_CTX_new();
void EVP_CIPHER_CTX_free(EVP_CIPHER_CTX *a);

int EVP_CIPHER_CTX_set_padding(EVP_CIPHER_CTX *ctx, int padding);

int EVP_EncryptInit_ex(EVP_CIPHER_CTX *ctx,const EVP_CIPHER *cipher,
        ENGINE *impl, unsigned char *key, const unsigned char *iv);

int EVP_EncryptUpdate(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl,
        const unsigned char *in, int inl);

int EVP_EncryptFinal_ex(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl);

int EVP_DecryptInit_ex(EVP_CIPHER_CTX *ctx,const EVP_CIPHER *cipher,
        ENGINE *impl, unsigned char *key, const unsigned char *iv);

int EVP_DecryptUpdate(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl,
        const unsigned char *in, int inl);

int EVP_DecryptFinal_ex(EVP_CIPHER_CTX *ctx, unsigned char *outm, int *outl);
]]

function _M.new(self, key, iv)
    local encrypt_ctx = C.EVP_CIPHER_CTX_new()
    if encrypt_ctx == nil then
        return nil, "no memory"
    end

    ffi_gc(encrypt_ctx, C.EVP_CIPHER_CTX_free)

    local decrypt_ctx = C.EVP_CIPHER_CTX_new()
    if decrypt_ctx == nil then
        return nil, "no memory"
    end

    ffi_gc(decrypt_ctx, C.EVP_CIPHER_CTX_free)

    local gen_key = ffi_new("unsigned char[?]", 32)
    local gen_iv = ffi_new("unsigned char[?]", 32)

    local iv_len = #iv

    ffi_copy(gen_key, key, 32)

    ffi_copy(gen_iv, iv, iv_len)

    if C.EVP_EncryptInit_ex(encrypt_ctx, C.EVP_aes_256_cbc(), nil, nil, nil) == 0 or
        C.EVP_DecryptInit_ex(decrypt_ctx, C.EVP_aes_256_cbc(), nil, nil, nil) == 0 then
        return nil, "failed to init ctx"
    end

    if C.EVP_CIPHER_CTX_set_padding(encrypt_ctx, 1) == 0 then
        return nil, "failed to set padding for encrypt context"
    end

    if C.EVP_CIPHER_CTX_set_padding(decrypt_ctx, 1) == 0 then
        return nil, "failed to set padding for decrypt context"
    end

    return setmetatable({
        _encrypt_ctx = encrypt_ctx,
        _decrypt_ctx = decrypt_ctx,
        _key = gen_key,
        _iv = gen_iv
    }, mt)
end

function _M.encrypt(self, s)
    local s_len = #s
    local max_len = s_len + 2 * 32
    local buf = ffi_new("unsigned char[?]", max_len)
    local out_len = ffi_new("int[1]")
    local tmp_len = ffi_new("int[1]")
    local ctx = self._encrypt_ctx

    if C.EVP_EncryptInit_ex(ctx, nil, nil, self._key, self._iv) == 0 then
        return nil, "EVP_EncryptInit_ex failed"
    end

    if C.EVP_EncryptUpdate(ctx, buf, out_len, s, s_len) == 0 then
        return nil, "EVP_EncryptUpdate failed"
    end

    if C.EVP_EncryptFinal_ex(ctx, buf + out_len[0], tmp_len) == 0 then
        return nil, "EVP_EncryptFinal_ex failed"
    end

    return ffi_str(buf, out_len[0] + tmp_len[0])
end

function _M.decrypt(self, s)
    local s_len = #s
    local max_len = s_len + 2 * 32
    local buf = ffi_new("unsigned char[?]", max_len)
    local out_len = ffi_new("int[1]")
    local tmp_len = ffi_new("int[1]")
    local ctx = self._decrypt_ctx

    if C.EVP_DecryptInit_ex(ctx, nil, nil, self._key, self._iv) == 0 then
        return nil, "EVP_DecryptInit_ex failed"
    end

    if C.EVP_DecryptUpdate(ctx, buf, out_len, s, s_len) == 0 then
        return nil, "EVP_DecryptUpdate failed"
    end

    if C.EVP_DecryptFinal_ex(ctx, buf + out_len[0], tmp_len) == 0 then
        return nil, "EVP_DecryptFinal_ex failed"
    end

    return ffi_str(buf, out_len[0] + tmp_len[0])
end

return _M
