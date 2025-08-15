local aes = require("aes")
local config = require("config")

-- 初始化web AES 解密对象
-- aes_256_cbc_web = aes:new(config.CREDENTIAL.web.key, config.CREDENTIAL.web.iv)

-- 初始化web AES 解密对象
aes_256_cbc_web = aes:new(config.CREDENTIAL.web["default"].key, config.CREDENTIAL.web["default"].iv)

-- 初始化默认的 app AES 解密对象
aes_256_cbc_app = aes:new(config.CREDENTIAL.app["default"].key, config.CREDENTIAL.app["default"].iv)

-- 检查初始化是否成功
if not aes_256_cbc_web or not aes_256_cbc_app then
    error("[LUA] Cannot finish init: AES initialization failed", 1)
end