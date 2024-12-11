function init()
  self.recoil = 0
  self.recoilRate = 0
  updateAim()
end

function update(dt, fireMode, shiftHeld)
  updateAim()

  if not storage.firing then return end

  self.recoilRate = math.max(self.recoilRate + (10 * dt), 1)
  self.recoil = math.max(self.recoil - dt * self.recoilRate, 0)

  if storage.firing and animator.animationState("firing") == "off" then
    storage.firing = false
    item.consume(1)

    if player then
      giveTreasure()
      giveRandomToy()
    end
  end
end

function activate(fireMode, shiftHeld)
  if not storage.firing then
    storage.firing = true

    self.recoilRate = 0
    self.recoil = math.pi / 2 - self.aimAngle
    activeItem.setArmAngle(math.pi / 2)

    if animator.animationState("firing") == "off" then
      animator.setAnimationState("firing", "fire")
    end
  end
end

function updateAim()
  self.aimAngle, self.aimDirection = activeItem.aimAngleAndDirection(0, activeItem.ownerAimPosition())
  self.aimAngle = self.aimAngle + self.recoil
  activeItem.setArmAngle(self.aimAngle)
  activeItem.setFacingDirection(self.aimDirection)
end

function giveTreasure()
  local treasure = config.getParameter("treasure")
  local items = root.createTreasure(treasure.pool, treasure.level, treasure.seed)
  for _, item in pairs(items) do
    player.giveItem(item)
  end
end

function giveRandomToy()
  local list = {}
  local actionFigures = root.assetJson("/collections/actionfigures.collection:collectables")
  for _, v in pairs(actionFigures) do
    list[#list + 1] = v.item
  end

  local item = list[math.random(1, #list)]
  if item then
    player.giveItem(item)
  end
end
