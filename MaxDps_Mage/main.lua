
if not MaxDps then
	return;
end

local Mage = MaxDps:NewModule('Mage');
-- Spells
	local _RuneofPower = 116011;	
	local _RuneofPowerAura = 116014;
	local _arcaneMissiles = 5143;
	local _clearCasting = 263725;
	local _arcaneBlast = 30451;
	local _arcaneBarrage = 44425;
	local _ruleOfThrees = 264774;
	local _superNova = 157980;
	local _evocation = 12051;
	local _arcanePower = 12042;
	local _pyroblast = 11366;
	
	
-- General

function Mage:Enable()
	MaxDps:Print(MaxDps.Colors.Info .. 'Mage [Arcane, Fire, Frost]');	
	
	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Mage.Arcane;
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Mage.Fire;
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Mage.Frost;
	end;	
	return true;
end

function Mage:Arcane(timeShift, currentSpell, gcd, talents)

	local arcaneCharges = UnitPower('player', Enum.PowerType.ArcaneCharges);
	local mana = UnitPower('player', Enum.PowerType.Mana);
	local maxMana = UnitPowerMax("player");
	
	if not MaxDps:SpellAvailable(_evocation, timeShift) and not MaxDps:SpellAvailable(_arcanePower, timeShift) then
	
		if MaxDps:SpellAvailable(_RuneofPower, timeShift) and not MaxDps:Aura(_RuneofPowerAura) then
			return _RuneofPower;
		end
	
		if MaxDps:Aura(_ruleOfThrees) and MaxDps:SpellAvailable(_arcaneBlast, timeShift) then
			return _arcaneBlast;
		end
	
		if MaxDps:SpellAvailable(_arcaneMissiles, timeShift) and (mana / maxMana) <=0.95 and MaxDps:Aura(_clearCasting) then
			return _arcaneMissiles;
		end
	
		if MaxDps:SpellAvailable(_arcaneBarrage, timeShift) and (mana / maxMana) <= 0.50 then
			return _arcaneBarrage;
		end
	
		if talents[_superNova] and MaxDps:SpellAvailable(_superNova,timeShift) then
			return _superNova;
		end
		
		if MaxDps:SpellAvailable(_arcaneBlast, timeShift) then
			return _arcaneBlast;
		end
	else
	
		if MaxDps:SpellAvailable(_RuneofPower, timeShift) and not MaxDps:Aura(_RuneofPowerAura) then
			return _RuneofPower;
		end
		
		if MaxDps:SpellAvailable(_arcanePower, timeShift) then
			return _arcanePower;
		end
		
		if MaxDps:SpellAvailable(_arcaneMissiles, timeShift) and (mana / maxMana) <=0.95 and MaxDps:Aura(_clearCasting) then
			return _arcaneMissiles;
		end
		
		if MaxDps:SpellAvailable(_evocation, timeShift) and (mana / maxMana) <= 0.20 then
			return _evocation;
		end
		
		if MaxDps:SpellAvailable(_arcaneBlast, timeShift) then
			return _arcaneBlast;
		end
	end
	
	
end

function Mage:Fire(timeShift, currentSpell, gcd, talents)

		if MaxDps:SpellAvailable(_RuneofPower, timeShift) and not MaxDps:Aura(_RuneofPowerAura) then
			return _RuneofPower;
		end
		
			if MaxDps:SpellAvailable(_pyroblast, timeShift) then
			return _pyroblast;
		end
		
		
end

function Mage:Frost(timeShift, currentSpell, gcd, talents)
end


