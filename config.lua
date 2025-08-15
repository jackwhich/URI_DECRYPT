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
        },
        WalletH5 = {
            ["4cde6e53264f9390472795f8b5d5e345"] = { key = "QLgQS0Ap6spkk7y9ES8xP4EojDCbdhac", iv = "Xhw0CK7s8F3JVEE0" },
            ["Tu608ffNKYqoq8Rj5GhJetKbN7i1TVh2"] = { key = "EE5LPMdh0cbizV689TXaLJg1eJcuf9qj", iv = "9GfGf8y7cR9s2cEj" }
        },
        OWPC = {
            ["TCfRavb7xuKDeqD0njoCAx20pt8eu8PX"] = { key = "zr8AnJGqXjRLxf3s1e8xW6resCN0WPWb", iv = "BakYaL0xyLrnktWm" },
            ["GafJ05YaiVbAzMeDqLof1oXvXo3rRcvB"] = { key = "DMEZNc22NCdBhRxayQFW1fUAzZbtXjda", iv = "NpFBu5JcoDcZrLXs" }
        },
        OWH5 = {
            ["gwcLTb5edyU3qD1Pw2G30WyAEbbFm2FN"] = { key = "CJe00ghbwuX9F0E4m0khCN5a8pVH11P4", iv = "TTFwymfZUJzWYAG4" },
            ["LbzZcBsDM6nmxB9gt2PJF8khLYkF5Mn3"] = { key = "iu3jL18FoKZU8XEnqLJiaCCGBpzzgt82", iv = "rB3qdg2093nQcWuH" }
        },
        PayPagePC = {
            ["1Pxms4y8gRqkPFPoPYwZAnCuLjGQ13ax"] = { key = "hjPZe7HXgNv6kXC8FgmUs1HdDu17tpVp", iv = "LDXkHKnEJmbzGu0P" },
            ["pTKK1s40yPo3uN9Ye5ji9Eq2RBYxBNKZ"] = { key = "7empYJYBXv6LcPHQ98v3h9uLyQURwryz", iv = "fgsLg5JKxrZXBVPE" }
        },
        PayPageH5 = {
            ["Aydv1cksjqd3nkDFFQJCMQastf7YBzJG"] = { key = "aDWmpKhdQ3QP8vo28AiqTbLTnddEqKkq", iv = "fMpfNhzxGpAqJEd4" },
            ["rzAERRsvbYXfrxAE0zTBz49qqNL8bhrm"] = { key = "CJ6VAbpYkZzFn4MuUjbVvq6ihnrN32gw", iv = "EBAqeN2388UMjUFP" }
        },
        CSLH5 = {
            ["wUeLPaZV9BDPpoUfj8PwYvswsY37QRUD"] = { key = "wVv1zBBreutvYoRdjsaM5cQsM41V1GMu", iv = "YmUMdfJja6HaM0Zg" },
            ["C3YTNHdMWqufCPGiAtfX75vg5FQnXqQB"] = { key = "wT1WELQyBFmasQqYW7WbnK6F3WLri2yv", iv = "djsUMVQQtzc3ALMo" }
        },
        KoiPayPC = {
            ["ya5w2JUmjRPCmpwURATG2DZ8PVG8uMQB"] = { key = "yqmjWz43eMk1D0M1id5Z1qh8Y5Rk9hei", iv = "FGTMGe8tVUDU1Xuo" },
            ["Y5EQGc6ZV3Lt8DwjugwQMLFk85Mx0Ac6"] = { key = "4WZ6XPfdTejN6YAnXKiKKik9MwW1C90f", iv = "g2a6tfDNtGGYZ3t9" }
        },
        KoiPayH5 = {
            ["kk9scr5uDVZAEfLWPCdXcZE93QQBAaVp"] = { key = "weiP88opdurhVvcn76xKTioVXAzM6Xf2", iv = "GQh1nevqK7mC3TRz" },
            ["sNtrm7M38NtXNfPsL3QzDsFw8Rpe9QVr"] = { key = "5XiDgaRhToRjpeRXtgkpUUQkP86AcMe1", iv = "qPqkuV8MsrCzEqgh" }
        }
    },
    product = {
        web = {
            ["default"] = { key = "QLgQS0Ap6spkk7y9ES8xP4EojDCbdhac", iv = "Xhw0CK7s8F3JVEE0" },
            ["v1"] = { key = "HyQGLfpHOCDYxyGdnsZ4qWbmVfbYWvvD", iv = "YK0tNpSynxI42K9F" },
            ["v2"] = { key = "kGcYmVsMxkRH05JltbGxToqa2oqQ4giq", iv = "yTLQfku5NXCgo1EL" },
            ["v3"] = { key = "NK1VV8eD6PNxLZstMUOkxTg0oQYwGCmT", iv = "ZwRWJHUJz4K2HNng" },
            ["v4"] = { key = "iG6lpQR4x5GR7HiGTCyJdpGWR9SFy2Wh", iv = "mUEpAEvGXtzTLWpQ" },
            ["v5"] = { key = "4D3YsCx13v6RBknaAQyB84uC9LqKKCUC", iv = "saCAnAMGtpkeVOoL" }
        },
        app = {
            ["default"] = { key = "ijKM6P37qVUUpMQSGFhiA5C1caWOg5iS", iv = "Bj4NJWXN9f7fRxNn" },
            ["v20"] = { key = "QLgQS0Ap6spkk7y9ES8xP4EojDCbdhac", iv = "Xhw0CK7s8F3JVEE0" },
            ["v23"] = { key = "KE6MFdjJ1wRaa49C6snnWHpKyNHN4VaP", iv = "d6rrksPqkpP5CDNx" },
            ["v24"] = { key = "V9zVsk8DFdNY4Qm6iDThnvWZCZzs5bxp", iv = "3svCPzbkC6Ruqjzp" },
            ["v25"] = { key = "gAQE2Wgh4LyAqUAz0wxwRKzD0pKAzkc9", iv = "g48sZnuf84taaQo2" },
            ["v26"] = { key = "toqUP8J56wi9Fwkhuek4y7D0ia2vsmt5", iv = "mV5NeJiG46VD16YC" }
        },
        WalletH5 = {
            ["ZTMXwobyzdA94ucvkysNfeVjkcB95doH"] = { key = "NKjpH6RBtwa56dH2YBCPefWCpZUbL8MY", iv = "Xhw0CK7s8F3JVEE0" },
            ["fGWufn2LEWaMBnthjo7sHjmAR9mcTqNG"] = { key = "P66pyYQeFNjstL2JnDFcQvNneLV5oG3j", iv = "u05HKt7P86xXRQ81" }
        },
        OWPC = {
            ["MHjTqADXrXipFZo3ChyixVxTHe5tdjo5"] = { key = "1udZCH4a2boo4Ui6J149PrTVc2CGRq03", iv = "ZM5MuyXbt98LQgPD" },
            ["reCsRZadKzVRon3V09Me4GH2UC9zjbv9"] = { key = "67wFRfLwC1iPqyxsQmTWXDXyXzvRoTWw", iv = "x7CdQ9HzAA0yynuE" }
        },
        OWH5 = {
            ["paqN6qzPnXkTV3w2Pv08byqYHtaPTJHH"] = { key = "54Q83n23qLKTBus117EaEv7sZwBFPDXF", iv = "zJetGB1nytbMbmT4" },
            ["Kfmd36awynhNj420a8nsrnLXNFh6mxXe"] = { key = "74Rj7a4FsHtWWCZD245vqakZtW53tTdc", iv = "KZaUnNgcRm5ZNXrt" }
        },
        PayPagePC = {
            ["h9msa71BwWaHFyntbFbTmbtx8xird09i"] = { key = "Djg5zGqnUfLV5gCTJjKkUt8H1HYLgGhL", iv = "xABN5M42AAy9UqsB" },
            ["fDgiVwHGPCQ5CTw5xycQ79uUMLAAh5xp"] = { key = "XBK255CsPXeLGr1tEniMjNi3mYaYcn2W", iv = "bmr9H5aNEGYQBPxK" }
        },
        PayPageH5 = {
            ["HKFLwcshJkq6PDp9ndEB8NUb11GPU5Wu"] = { key = "XFkqtYJ9nj03a2NtrQ4xFKEEiiepjLKP", iv = "EmCgLK2cbvT5Jtes" },
            ["RnTHMh8Y11qgohRrCfQZbzW0Y7BwA6FC"] = { key = "E8UgJG932eYuJ5KAmapx7b6bp2LBiPib", iv = "8xJ51nTcmq3vmHZ6" }
        },
        CSLH5 = {
            ["U8Yd6e929ifyWPDQ56rfPVk7uAtQRcow"] = { key = "Ba9i7oDscqjxqb6fMcjiYcDiQVWwQEje", iv = "3a6UyR0FJ9s2UZCf" },
            ["qp4D2RxFXkaytNHDbnj01DtfqHqjaFeh"] = { key = "wEuGqgsmFU32GUsiHBE4wGb7oBHbJZKf", iv = "LEUBhNPkW5byks42" }
        },
        KoiPayPC = {
            ["n2YVCQbnwFF88eGsMWvV96nb5KLQeqvV"] = { key = "fJ527FUWWxPpb48JMbfw5kYdDcBAJ7co", iv = "9aZDEVt0TaMMYaFC" },
            ["JXVCH1nBPrvxWiFdqCcjcWmDsRFUvf4r"] = { key = "oP1u9xn1BAQBqryrfdij5rM7666s5UAC", iv = "ecyVH2DFka5XYAum" }
        },
        KoiPayH5 = {
            ["6APMmhMRWHCyhgqkcUiNDeJDyzxKCL66"] = { key = "Dj9pia10QdT4chNL7FuJXKkgjGYyAbt5", iv = "r1kpyHX6UnA6vRTJ" },
            ["BTibCNV8y37qJ9fPk32R41TzGtXrnXoQ"] = { key = "8dfT6wCJ3UcTFJGBqRTnGAmqcc14z39k", iv = "pb3vYeeoAd6dEKw4" }
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