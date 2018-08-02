
if not MaxDps then
	return;
end

local Mage=MaxDps:NewModule('Mage');
-- Spells
		
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

function Mage.Arcane(timeShift, currentSpell, gcd, talents)
end

function Mage.Fire(timeShift, currentSpell, gcd, talents)
end

function Mage.Frost(timeShift, currentSpell, gcd, talents)
end

end
