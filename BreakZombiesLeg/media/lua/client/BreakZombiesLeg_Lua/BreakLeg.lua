local ZombieList = {} --For fixing zombie animation glitch

local function f_BreakLeg(character, zombie)
	local breakKey = getCore():getKey("Run")
	local itemonHand = character:getPrimaryHandItem()
	if itemonHand ~= nil and itemonHand:IsWeapon() and not character:isDoShove() and zombie:isZombie() then
		if GameKeyboard.isKeyDown(breakKey) then
			table.insert(ZombieList,zombie)
		end
	end
end
Events.OnWeaponHitCharacter.Add(f_BreakLeg)

local function f_ZombieListProcess()
	for i,v in pairs(ZombieList) do
		if v ~= nil then
			if v:isDead() then --Remove dead
				table.remove(ZombieList,i)
			end

			if not v:isKnockedDown() then
				v:setKnockedDown(true)
			end

			if not v:isOnFloor() then
				v:setOnFloor(true)
			end

			if not v:isBecomeCrawler() then
				v:setCrawlerType(ZombRand(1,2))
				v:setBecomeCrawler(true)
			end

			v:setCanWalk(false)		
			table.remove(ZombieList,i)
		end
	end
end
Events.OnTick.Add(f_ZombieListProcess)