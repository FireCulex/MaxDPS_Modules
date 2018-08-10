
if not MaxDps then
	return;
end

local Druid = MaxDps:NewModule('Druid');
-- Spells
	local _Moonfire = 8921;
	local _MoonfireTarget = 164812;
	local _Wrath = 5176;
	local _Sunfire = 93402;
	local _SunfireTarget = 164815;
	local _StarSurge = 78674;
	local _BalanceWrath = 190984;
	local _LunarStrike = 194153;
	local _LunarEmpowerment = 164547;
	local _SolarEmpowerment = 164545;
	local _Mangle = 33917;
	local _Thrash = 77758;
	local _GalacticGuard = 213708;
	local _Swipe = 213771;
	local _Maul = 6807;
	local _Lunar_Insp = 155580;
	local _Feral_Moonfire = 155625;
	local _Rake = 1822;
	local _Rake_Dot = 155722;
	local _Shred = 5221;
	local _Bite = 22568;
	local _Rip = 1079;
	local _BearForm = 5487;
	
-- General

function Druid:Enable()
	MaxDps:Print(MaxDps.Colors.Info .. 'Druid [Balance, Feral, Guardian, Restoration]');	
	
	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Druid.Balance;
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Druid.Feral;
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Druid.Guardian;
	elseif MaxDps.Spec == 4 then
		MaxDps.NextSpell = Druid.Restoration;
	end;	
	return true;
end

function Druid:Balance(timeShift, currentSpell, gcd, talents)

local astralPower = UnitPower('player', Enum.PowerType.LunarPower);

	if not MaxDps:TargetAura(_MoonfireTarget, timeShift) then
		return _Moonfire;
	end
	
	if not MaxDps:TargetAura(_SunfireTarget, timeShift) then
		return _Sunfire;
	end

	if astralPower >40 and MaxDps:SpellAvailable(_StarSurge, timeShift) then
		return _StarSurge;
	end
	
	
	if MaxDps:Aura(_SolarEmpowerment, timeShift) then
		return _BalanceWrath;
	end
	
	
	if MaxDps:Aura(_LunarEmpowerment, timeShift) then
		return _LunarStrike;
	end
	
	if MaxDps:SpellAvailable(_BalanceWrath, timeShift) then
		return _BalanceWrath;
	end
	
end

function Druid:Feral(timeShift, currentSpell, gcd, talents)

	local energy = UnitPower('player', Enum.PowerType.Energy);
	local cp = UnitPower('player', Enum.PowerType.ComboPoints);
	
	if energy >= 30 and talents[_Lunar_Insp] and not MaxDps:TargetAura(_Feral_Moonfire, timeShift) then
		return _Feral_Moonfire;
	end
	
	if energy >=35 and not MaxDps:TargetAura(_Rake_Dot, timeShift) then
		return _Rake;
	end
	
	if energy >=25 and cp == 5 and MaxDps:SpellAvailable(_Bite, timeShift) and MaxDps:TargetPercentHealth() <= 0.25 then
		return _Bite;
	end
	
	if energy >=30 and cp == 5 and not MaxDps:TargetAura(_Rip, timeShift) and MaxDps:TargetPercentHealth() > 0.25 then
		return _Rip;
	end
	
	if energy >=25 and cp == 5 and MaxDps:SpellAvailable(_Bite, timeShift) then
		return _Bite;
	end
	
	if energy >=40 and MaxDps:SpellAvailable(_Shred, timeShift) then
		return _Shred;
	end

end


function Druid:Guardian(timeShift, currentSpell, gcd, talents)

	local rage = UnitPower('player', Enum.PowerType.Rage);
	
	if MaxDps:Aura(_BearForm) then
	
		if MaxDps:Aura(_GalacticGuard, timeShift) then
			return _Moonfire;
		end 

		if MaxDps:SpellAvailable(_Mangle, timeShift) then
			return _Mangle;
		end
	
		if MaxDps:SpellAvailable(_Thrash, timeShift) then
			return _Thrash;
		end
	
		if not MaxDps:TargetAura(_MoonfireTarget, timeShift) then
			return _Moonfire;
		end
	
		if rage >= 45 and MaxDps:SpellAvailable(_Maul, timeShift) then
			return _Maul;
		end
	
		if MaxDps:SpellAvailable(_Swipe, timeShift) then
			return _Swipe;
		end
	end
	
end

function Druid:Restoration(timeShift, currentSpell, gcd, talents)

	if not MaxDps:TargetAura(_MoonfireTarget, timeShift) then
		return _Moonfire;
	end
	
	if not MaxDps:TargetAura(_SunfireTarget, timeShift) then
		return _Sunfire;
	end


	if MaxDps:SpellAvailable(_Wrath, timeShift) then
		return _Wrath;
	end
	
	
end


