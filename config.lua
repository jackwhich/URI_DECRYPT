local base64c = require("lib.base64c")

local credentials = {
    develop = {
        web = {
            ["default"] = { key = "QLgQS0Ap6spkk7y9ES8xP4EojDCbdhac", iv = "Xhw0CK7s8F3JVEE0" },
            ["v1"] = { key = "HyQGLfpHOCDYxyGdnsZ4qWbmVfbYWvvD", iv = "YK0tNpSynxI42K9F" },
            ["v2"] = { key = "kGcYmVsMxkRH05JltbGxToqa2oqQ4giq", iv = "yTLQfku5NXCgo1EL" },
            ["v3"] = { key = "NK1VV8eD6PNxLZstMUOkxTg0oQYwGCmT", iv = "ZwRWJHUJz4K2HNng" },
            ["v4"] = { key = "iG6lpQR4x5GR7HiGTCyJdpGWR9SFy2Wh", iv = "mUEpAEvGXtzTLWpQ" },
            ["v5"] = { key = "4D3YsCx13v6RBknaAQyB84uC9LqKKCUC", iv = "saCAnAMGtpkeVOoL" }
        },
        app = {
            ["default"] = { key = "noQkdQQwvm51c4wfA7b85y1PU1NPcMnr", iv = "l0MTJOmgP5TkTzBB" },
            ["v22"] = { key = "6pmJEl993bVpdvL2MR7Ek3wA5Tcax61i", iv = "8rGRLAelqMN2RxGs" },
            ["v23"] = { key = "Hb1fLDFw6Q4MWAx74MgWA4yfpLhJDRwP", iv = "0yF5vLvJoXGfsqpz" },
            ["v24"] = { key = "V9zVsk8DFdNY4Qm6iDThnvWZCZzs5bxp", iv = "3svCPzbkC6Ruqjzp" },
            ["v25"] = { key = "gAQE2Wgh4LyAqUAz0wxwRKzD0pKAzkc9", iv = "g48sZnuf84taaQo2" },
            ["v26"] = { key = "toqUP8J56wi9Fwkhuek4y7D0ia2vsmt5", iv = "mV5NeJiG46VD16YC" }
        }
    },
    product = {
        web = {
            key = "xBaZL9OEWjn8eTYolazycpNi5PHZh749",
            iv = "ZVeTgve2qtnGJChO"
        },
        app = {
            ["default"] = { key = "ijKM6P37qVUUpMQSGFhiA5C1caWOg5iS", iv = "Bj4NJWXN9f7fRxNn" },
            ["v20"] = { key = "QLgQS0Ap6spkk7y9ES8xP4EojDCbdhac", iv = "Xhw0CK7s8F3JVEE0" },
            ["v23"] = { key = "KE6MFdjJ1wRaa49C6snnWHpKyNHN4VaP", iv = "d6rrksPqkpP5CDNx" },
            ["v24"] = { key = "V9zVsk8DFdNY4Qm6iDThnvWZCZzs5bxp", iv = "3svCPzbkC6Ruqjzp" },
            ["v25"] = { key = "gAQE2Wgh4LyAqUAz0wxwRKzD0pKAzkc9", iv = "g48sZnuf84taaQo2" },
            ["v26"] = { key = "toqUP8J56wi9Fwkhuek4y7D0ia2vsmt5", iv = "mV5NeJiG46VD16YC" }
        }
    }
}

local visible_types = {
    [0] = ngx.decode_base64,
    [1] = base64c.decode
}

return {
    VISIBLE_FIELD = "QHUJK",
    VISIBLE_TYPES = visible_types,
    CREDENTIAL = credentials.develop, -- 使用完整的环境、app和web配置
    SKIP_PREFIX_OFFSET = 10, -- "/RoaVGWBm"
    URI_LENGTH_MINIMUM = 45, -- 最短URI，低于视为攻击
    URI_LENGTH_MAXIMUM = 200, -- 最长URI, 高于视为攻击
    -- 单位毫秒，正负五分钟
    ELAPSED_MS_MINIMUM = -300000, -- 最小间隔，低于视为攻击
    ELAPSED_MS_MAXIMUM = 300000, -- 最大间隔，高于视为攻击
    USE_REAL_TIME = false -- 使用实时时间，除精确统计外无必要
}