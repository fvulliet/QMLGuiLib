function roundAndMakeItEven(number) {
    var res = Math.round(number)
    if ((res % 2) != 0)
        return res + 1
    return res
}

function bound(number, min, max) {
    return Math.max(Math.min(number, max), min)
}

function limitMax(number, limit) {
    return (number > limit) ? limit : number
}

function toHex(number, padding) {
    var ret = Number(number).toString(16)
    if (padding) {
        if (padding < 10) {
            return ('0000000000' + ret).slice(-padding)
        }
        else {
            return (Array(padding).join(0) + ret).slice(-padding)
        }
    }
    else
        return ret
}

