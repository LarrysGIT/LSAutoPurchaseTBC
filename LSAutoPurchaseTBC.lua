
SLASH_LSAutoPurchaseTBC1 = "/LSAutoPurchaseTBC"

-- https://stackoverflow.com/a/7615129/5471097
local function mysplit (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

local function trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

local function help(m)
    print(m)
    print("Format: /LSAutoPurchaseTBC ItemName1:/3;ItemName2:*2;ItemName3:*3")
end

local function Give_Me_N_Value(n, str)
    if str == nil then
        return n
    end
    operator, number = string.match(str, "^(.)(.*)$")
    if string.find("/+-*", operator) then
        if tonumber(number) then
            if operator == "/" then
                n = math.floor(n / tonumber(number))
            end
            if operator == "+" then
                n = n + tonumber(number)
            end
            if operator == "-" then
                n = n - tonumber(number)
            end
            if operator == "*" then
                n = n * tonumber(number)
            end
            return n
        else
            help("Not a number: " .. number)
        end
    else
        help("Bad operator: " .. operator)
    end
    return nil
end

local LastRunDateTime = 0

local function LSAutoPurchaseTBC(inputstr)
    LastRunDateTime_ = GetTime()
    if LastRunDateTime ~= 0 then
        seconds_diff = LastRunDateTime_ - LastRunDateTime
        if seconds_diff < 1.5 then
            print("You clicked too fast!")
            return
        end
    end
    LastRunDateTime = LastRunDateTime_
    items = mysplit(inputstr, ";")
    if table.getn(items) == 0 then
        help("No argument is received")
        return
    end
    if table.getn(items) == 1 then
        help("Received 1 argument, that's not enough.")
        return
    end
    item_1 = mysplit(items[1], ":")
    N1 = 0
    N2 = 0
    N1 = GetItemCount(item_1[1])
    N2 = Give_Me_N_Value(N1, item_1[2])
    print("The item based on: " .. item_1[1] .. "; Count in bag: " .. N1 .. "; N set to value: " .. N2)
    if N2 < 0 then
        print("N is a negative number, it has to be positive.")
        return
    end
    for i = 2, table.getn(items) do
        item = mysplit(items[i], ":")
        n_InBag = GetItemCount(item[1])
        n_ShouldBe = Give_Me_N_Value(N2, item[2])
        n_Missing = n_ShouldBe - n_InBag
        print("The item: " .. item[1] .. "; Count in bag: " .. n_InBag .. "; Should be: " .. n_ShouldBe .. "; Missing: " .. n_Missing)
        for itemIndex = 1, GetMerchantNumItems() do
            tmp = GetMerchantItemInfo(itemIndex)
            if tmp == item[1] then
                -- The item is found in merchant's inventory
                itemLink = GetMerchantItemLink(itemIndex)
                _, _, _, _, _, _, _, itemStackCount = GetItemInfo(itemLink)
                itemStackCount = tonumber(itemStackCount)
                while n_Missing > 0 do
                    if n_Missing >= itemStackCount then
                        BuyMerchantItem(itemIndex, itemStackCount)
                    else
                        BuyMerchantItem(itemIndex, n_Missing)
                    end
                    n_Missing = n_Missing - itemStackCount
                end
                break
            end
        end
    end
end

SlashCmdList["LSAutoPurchaseTBC"] = LSAutoPurchaseTBC;
