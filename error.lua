return {
    invalidURI = function()
        return 540
    end,
    badBase64 = function()
        return 541
    end,
    badCipher = function()
        return 542
    end,
    truncatedHeader = function()
        return 400
    end,
    badElapsed = function(msec)
        return 543
    end,
    badTimestamp = function(str)
        return 544
    end,
    invaidVisibleType = function(type)
        return 545
    end
}