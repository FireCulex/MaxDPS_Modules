
if not MaxDps then
	return;
end

local Priest = MaxDps:NewModule('Priest');
-- Spells
		
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

function Priest.Discipline(timeShift, currentSpell, gcd, talents)

end

function Priest.Holy(timeShift, currentSpell, gcd, talents)

end

function Priest.Shadow(timeShift, currentSpell, gcd, talents)

end


