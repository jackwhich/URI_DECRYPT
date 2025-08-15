local config = require("config")
local error = require("error")
local aes = require("aes")

local tonumber = tonumber
-- local uri = ngx.var.uri -- set merge_slashes off
-- 未完全切换前暂时使用ngx.var.request_uri

local uri = ngx.var.request_uri

local offset, _ = uri:find("?")
if offset then
    uri = uri:sub(1, offset - 1)
end

-- 长度判断
if (#uri < config.URI_LENGTH_MINIMUM or #uri > config.URI_LENGTH_MAXIMUM) then
    -- 无效URI
    ngx.exit(error.invalidURI())
end

-- 获取headers
local headers, err = ngx.req.get_headers()
if err == "truncated" then
    ngx.exit(error.truncatedHeader())
end

-- 根据请求头选择解码密钥（仅用于app）
local version = headers["eb-version"]

-- 根据请求头选择解码密钥（仅用于app）
if version and config.CREDENTIAL.app[version] then
    aes_256_cbc = aes:new(config.CREDENTIAL.app[version].key, config.CREDENTIAL.app[version].iv)
else
    -- 如果没有找到版本，则使用默认的解密密钥
    aes_256_cbc = aes_256_cbc_app
end


-- 根据请求头选择解码密钥（仅用于web）
local web_version = headers["url-version"]

-- 通过header选择web解码密钥（仅用于web）
if headers["skktw"] then
    if headers["skktw"] == "h5" or headers["skktw"] == "web" then
        -- 通过header选择解码密钥（仅用于web）
        if web_version and config.CREDENTIAL.web[web_version] then
            aes_256_cbc = aes:new(config.CREDENTIAL.web[web_version].key, config.CREDENTIAL.web[web_version].iv)
        else
            aes_256_cbc = aes_256_cbc_web
        end
    end
end

if headers["tb-client-type"] then
    if headers["tb-client-type"] == "h5" or headers["tb-client-type"] == "web" then
        aes_256_cbc = aes_256_cbc_web
    end
end

-- 获取加密串可视化解码方法
-- 默认为base64 with padding
local decode_base64 = ngx.decode_base64

local visible_type = tonumber(headers[config.VISIBLE_FIELD])

if visible_type then
    local visible_func = config.VISIBLE_TYPES[visible_type]
    if not visible_func then
        ngx.exit(error.invaidVisibleType(visible_type))
    end
    decode_base64 = visible_func
end

local ciphertext = decode_base64(uri:sub(config.SKIP_PREFIX_OFFSET))
if not ciphertext then
    -- 无效的Base64编码或解码失败
    ngx.exit(error.badBase64())
end

-- 解密密文
local plaintext, err = aes_256_cbc:decrypt(ciphertext)
if not plaintext then
    ngx.exit(error.badCipher())
end

-- 获取时间戳并判断
if config.USE_REAL_TIME then
    ngx.update_time() -- 更新nginx时间缓存
end

local stamp_str = plaintext:sub(1, 13)
local remote_stamp = tonumber(stamp_str)

if not remote_stamp then
    ngx.exit(error.badTimestamp(stamp_str))
end
local elapsed_ms = (ngx.now() * 1000) - remote_stamp

if elapsed_ms < config.ELAPSED_MS_MINIMUM or elapsed_ms > config.ELAPSED_MS_MAXIMUM then
    ngx.exit(error.badElapsed(elapsed_ms)) -- 超时
end

-- 获取plainuri
uri = plaintext:sub(14)

ngx.header.Security_Gateway_Status = "Done"

ngx.exec(uri, ngx.var.args)