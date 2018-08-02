
if not MaxDps then
	return;
end

local Druid = MaxDps:NewModule('Druid');
-- Spells
		
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

function Druid.Balance(timeShift, currentSpell, gcd, talents)

end

function Druid.Feral(timeShift, currentSpell, gcd, talents)

end

function Druid.Guardian(timeShift, currentSpell, gcd, talents)

end

function Druid.Restoration(timeShift, currentSpell, gcd, talents)

end


