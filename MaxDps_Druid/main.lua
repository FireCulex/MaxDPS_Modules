
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

end

function Druid:Guardian(timeShift, currentSpell, gcd, talents)

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


