local plateConfig = {
    plateStarts = { 
        "AA","AB","AC","AD","AE","AF","AG","AH","AJ","AK","AL","AM","AN","AO","AP","AR","AS","AT","AU","AV","AW","AX","AY",
        "BA","BB","BC","BD","BE","BF","BG","BH","BJ","BK","BL","BM","BN","BO","BP","BR","BS","BT","BU","BV","BW","BX","BY",
        "CA","CB","CC","CD","CE","CF","CG","CH","CJ","CK","CL","CM","CN","CO","CP","CR","CS","CT","CU","CV","CW","CX","CY",
        "DA","DB","DC","DD","DE","DF","DG","DH","DJ","DK","DL","DM","DN","DO","DP","DR","DS","DT","DU","DV","DW","DX","DY",
        "EA","EB","EC","ED","EE","EF","EG","EH","EJ","EK","EL","EM","EN","EO","EP","ER","ES","ET","EU","EV","EW","EX","EY",
        "FA","FB","FC","FD","FE","FF","FG","FH","FJ","FK","FL","FM","FN","FO","FP","FR","FS","FT","FU","FV","FW","FX","FY",
        "GA","GB","GC","GD","GE","GF","GG","GH","GJ","GK","GL","GM","GN","GO","GP","GR","GS","GT","GU","GV","GW","GX","GY",
        "HA","HB","HC","HD","HE","HF","HG","HH","HJ","HK","HL","HM","HN","HO","HP","HR","HS","HT","HU","HV","HW","HX","HY",
        "KA","KB","KC","KD","KE","KF","KG","KH","KJ","KK","KL","KM","KN","KO","KP","KR","KS","KT","KU","KV","KW","KX","KY",
        "LA","LB","LC","LD","LE","LF","LG","LH","LJ","LK","LL","LM","LN","LO","LP","LR","LS","LT","LU","LV","LW","LX","LY",
        "MA","MB","MC","MD","ME","MF","MG","MH","MJ","MK","ML","MM","MN","MO","MP","MR","MS","MT","MU","MV","MW","MX","MY"
    },
    plateLetters = {"A","B","C","D","E","F","G","H","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
}

local function GetDVLAYearCode()
    local yearCodes = {
        "01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25",
		"51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74"
    }

    local month = tonumber(os.date("%m"))
    local year = tonumber(os.date("%Y")) % 100

    local currentCode
    if month >= 3 and month < 9 then
        currentCode = string.format("%02d", year)
    else
        currentCode = tostring(year + 50)
    end

    if math.random() < 0.5 then
        return currentCode
    else
        return yearCodes[math.random(#yearCodes)]
    end
end

local function GeneratePlate()
    local prefix = plateConfig.plateStarts[math.random(#plateConfig.plateStarts)]
    local year = GetDVLAYearCode()
    local letters = plateConfig.plateLetters[math.random(#plateConfig.plateLetters)]
                  .. plateConfig.plateLetters[math.random(#plateConfig.plateLetters)]
                  .. plateConfig.plateLetters[math.random(#plateConfig.plateLetters)]
    return string.format("%s%s %s", prefix, year, letters)
end

Citizen.CreateThread(function()
    while true do
        for _, vehicle in ipairs(GetGamePool('CVehicle')) do
            local currentPlate = GetVehicleNumberPlateText(vehicle)
            if currentPlate and not currentPlate:find("%s") then
                SetVehicleNumberPlateText(vehicle, GeneratePlate())
            end
        end
        Citizen.Wait(500)
    end
end)
