
if not MaxDps then
	return;
end

local Priest = MaxDps:NewModule('Priest');
-- Spells
	local _Shield = 17;
	local _Penance = 47540;
	local _Solace = 129250;
	local _Smite = 585;
	local _Schism = 214621;
	local _Pain = 589;
	local _VoidEruption = 228260;
	local _VampiricTouch = 34914;
	local _MindBlast = 8092;
	local _WordVoid = 205351;
	local _DarkVoid = 263346;
	local _HolyFire = 14914;
	local _HolyNova = 132157;
	local _HolyChastise = 88625;
	
	
-- General

function Priest:Enable()
	MaxDps:Print(MaxDps.Colors.Info .. 'Priest [Discipline, Holy, Shadow]');	
	
	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Priest.Discipline;
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Priest.Holy;
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Priest.Shadow;
	end;	
	return true;
end

function Priest:Discipline(timeShift, currentSpell, gcd, talents)

--	if not MaxDps:Aura(_Shield, timeShift) then
--		return _Shield;
--	end
	
	if not MaxDps:TargetAura(_Pain, timeShift) then
		return _Pain;
	end
	
	if talents[_Schism] and MaxDps:SpellAvailable(_Schism, timeShift) then
	return _Schism;
	end


	if MaxDps:SpellAvailable(_Penance, timeShift) then
	return _Penance;
	end

	if talents[_Solace] and MaxDps:SpellAvailable(_Solace, timeShift) then
		return _Solace;
	end

	if MaxDps:SpellAvailable(_Smite, timeShift) then
		return _Smite;
	end
	
	
end

function Priest:Holy(timeShift, currentSpell, gcd, talents)

	if MaxDps:SpellAvailable(_HolyFire, timeShift) then
		return _HolyFire;
	end

--	if MaxDps:SpellAvailable(_HolyNova, timeShift) then
--		return _HolyNova;
--	end
	
	if MaxDps:SpellAvailable(_HolyChastise, timeShift) then
		return _HolyChastise;
	end

	if MaxDps:SpellAvailable(_Smite, timeShift) then
		return _Smite;
	end

	
end

function Priest:Shadow(timeShift, currentSpell, gcd, talents)

	local insanity = UnitPower('player', Enum.PowerType.Insanity);
	
	if insanity == 100 and MaxDps:SpellAvailable(_VoidEruption, timeShift) then
		return _VoidEruption;
	end
	
	if not MaxDps:TargetAura(_Pain, timeShift) then
		return _Pain;
	end
	
	if not MaxDps:TargetAura(_VampiricTouch, timeShift) then
		return _VampiricTouch;
	end
	
	if not talents[_WordVoid] and MaxDps:SpellAvailable(_MindBlast, timeShift) then
		return _MindBlast;
	end
	
	if talents[_WordVoid] and MaxDps:SpellAvailable(_WordVoid, timeShift) then
		return _WordVoid;
	end
	
	if talents[_DarkVoid] and MaxDps:SpellAvailable(_DarkVoid, timeShift) then
		return _DarkVoid;
	end
	
	
end


