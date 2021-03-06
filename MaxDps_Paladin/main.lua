
if not MaxDps then
	return;
end

local Paladin = MaxDps:NewModule('Paladin');
-- Spells
	local _TemplarsVerdict = 85256;
	local _Judgment = 20271;
	local _CrusaderStrike = 35395;
	local _BladeofJustice = 184575;
	local _Crusade = 231895;
	local _ShieldofVengeance = 184662;
	local _Zeal = 217020;
	local _Consecration = 205228;
	local _HammerofWrath = 24275;
	local _Inquisition = 84963;
	local _ExecutionSentence = 267798;
	local _WakeofAshes = 255937;
	local _JudgementHoly = 275773;
	local _HolyShock = 20473;
	local _HolyConsecration = 26573;
	local _HolyConsecrationAura = 204242;
	local _ProtJudgement = 275779;
	local _AvengersShield = 31935;
	local _HammerRight = 53595;
	local _BlessedHammer = 204019;
	local _ShieldRightous = 53600;
	local _ConsecrationProtAura = 188370;
	
-- General

function Paladin:Enable()
	MaxDps:Print(MaxDps.Colors.Info .. 'Paladin [Holy, Protection, Retribution]');	
	
	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Paladin.Holy;
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Paladin.Protection;
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Paladin.Retribution;
	end;	
	return true;
end

function Paladin:Holy(timeShift, currentSpell, gcd, talents)

	if MaxDps:SpellAvailable(_JudgementHoly, timeShift) then
		return _JudgementHoly;
	end
	
	if MaxDps:SpellAvailable(_CrusaderStrike, timeShift) then
		return _CrusaderStrike;
	end

	if MaxDps:SpellAvailable(_HolyShock, timeShift) then
		return _HolyShock;
	end
		
	if MaxDps:SpellAvailable(_HolyConsecration, timeShift) and not MaxDps:TargetAura(_HolyConsecrationAura, timeShift) then
		return _HolyConsecration;
	end
end

function Paladin:Protection(timeShift, currentSpell, gcd, talents)

	if MaxDps:SpellAvailable(_ShieldRightous, timeShift) then
		return _ShieldRightous;
	end


	if MaxDps:SpellAvailable(_HolyConsecration, timeShift) and not MaxDps:TargetAura(_HolyConsecrationAura, timeShift) and not MaxDps:Aura(_ConsecrationProtAura) then
		return _HolyConsecration;
	end
	
	if MaxDps:SpellAvailable(_ProtJudgement, timeShift) then
		return _ProtJudgement;
	end
	
	if MaxDps:SpellAvailable(_AvengersShield, timeShift) then
		return _AvengersShield;
	end

	if not talents[_BlessedHammer] and MaxDps:SpellAvailable(_HammerRight, timeShift) then
		return _HammerRight;
	end
	
	if talents[_BlessedHammer] and MaxDps:SpellAvailable(_BlessedHammer, timeShift) then
		return _BlessedHammer;
	end
	
end

function Paladin:Retribution(timeShift, currentSpell, gcd, talents)
  
	local crusStrike = _CrusaderStrike;
	if talents[_Zeal] then
		crusStrike = _Zeal;
	end

	local holyPower = UnitPower('player', Enum.PowerType.HolyPower);
		    
	MaxDps:GlowCooldown(_ShieldofVengeance, MaxDps:SpellAvailable(_ShieldofVengeance, timeShift));
 
	if talents[_Crusade] then
		MaxDps:GlowCooldown(_Crusade, MaxDps:SpellAvailable(_Crusade, timeShift));
	end
 
	if talents[_WakeofAshes] and holyPower<=1 and MaxDps:SpellAvailable(_WakeofAshes, timeShift) then
		return _WakeofAshes;
	end
 
	if talents[_Inquisition] and holyPower>1 and not MaxDps:Aura(_Inquisition, timeShift) then
		return _Inquisition;
	end
 
	if talents[_ExecutionSentence] and MaxDps:SpellAvailable(_ExecutionSentence, timeShift) and holyPower >= 3 then
		return _ExecutionSentence;
	end
		
	if holyPower >= 5 then
		return _TemplarsVerdict;
	end
	
	if MaxDps:SpellAvailable(_HammerofWrath, timeShift) and holyPower <=4 and MaxDps:TargetPercentHealth() < 0.2 and MaxDps:TargetPercentHealth() > 0  then
		return _HammerofWrath;
	end
		
	if MaxDps:SpellAvailable(_BladeofJustice, timeShift) and holyPower <= 3 then
		return _BladeofJustice;
	end
 
	if MaxDps:SpellAvailable(_Judgment, timeShift) and holyPower <= 4 then
		return _Judgment;
	end
 
	if talents[_Consecration] and MaxDps:SpellAvailable(_Consecration, timeShift) and holyPower <=4 then
		return _Consecration;
	end

	if MaxDps:SpellAvailable(crusStrike, timeShift) and holyPower <= 4 then
		return crusStrike;
	end

end
