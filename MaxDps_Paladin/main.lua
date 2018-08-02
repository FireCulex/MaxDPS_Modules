
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

	local j, jCD = MaxDps:SpellAvailable(_JudgementHoly, timeShift);
	local crus, crusCD = MaxDps:SpellAvailable(_CrusaderStrike, timeShift);
	local hshock, hshockCD = MaxDps:SpellAvailable(_HolyShock, timeShift);
    local hcons, hconsCD = MaxDps:SpellAvailable(_HolyConsecration, timeShift); 


   if j then
        return _JudgementHoly;
    end
	
	if crus then
		return _CrusaderStrike;
	end

	if hshock then
		return _HolyShock;
		end
		
			if hcons and not MaxDps:TargetAura(_HolyConsecrationAura, timeShift) then
		return _HolyConsecration;
		end
end

function Paladin:Protection(timeShift, currentSpell, gcd, talents)
end

function Paladin:Retribution(timeShift, currentSpell, gcd, talents)
  
    local crusStrike = _CrusaderStrike;
    if talents[_Zeal] then
        crusStrike = _Zeal;
    end
 
    local tgtPctHp = MaxDps:TargetPercentHealth();
	local execPct = 0.2;
    local holyPower = UnitPower('player', Enum.PowerType.HolyPower);
    local jAura, jAuraCD = MaxDps:TargetAura(_Judgment, timeShift + 0.5);
    local j, jCD = MaxDps:SpellAvailable(_Judgment, timeShift);
    local _, crusadeCD = MaxDps:SpellAvailable(_Crusade, timeShift);
    local crus, crusCD = MaxDps:SpellAvailable(crusStrike, timeShift);
    local boj, bojCD = MaxDps:SpellAvailable(_BladeofJustice, timeShift);
	local ham, hamCD = MaxDps:SpellAvailable(_HammerofWrath, timeShift);

 
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
	
 if  ham and holyPower <=4 and tgtPctHp < execPct then
		return _HammerofWrath;
	end
		
    if boj and holyPower <= 3 then
        return _BladeofJustice;
    end
 
    if j and holyPower <= 4 then
        return _Judgment;
    end
 
    if talents[_Consecration] and MaxDps:SpellAvailable(_Consecration, timeShift) and holyPower <=4 then
        return _Consecration;
    end

    if crus and holyPower <= 4 then
        return crusStrike;
    end

end

	