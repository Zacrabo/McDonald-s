require "/zcrab/mcdonalds/items/treasurebag.lua"

local _giveTreasure = giveTreasure
function giveTreasure(...)
  giveRandomToy()
  _giveTreasure(...)
end

function giveRandomToy()
  local actionFigures = root.assetJson("/collections/actionfigures.collection:collectables")

  local list = {}
  for _, v in pairs(actionFigures) do
    list[#list + 1] = v.item
  end

  local item = list[math.random(#list)]
  if item then
    player.giveItem(item)
  end
end
