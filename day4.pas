program AoCd3;
	uses
		SharedAoC; { For StringToInteger function }
	var
		InputFile: text;
		Line: string;
		RowCounter: integer;
		TotalScorePart1: longint;
		TotalScorePart2: longint;

	function GetScorePart1 (var Line: string): integer;
		var
			FirstPart: string;
			LastPart: string;
			StartFirstPart: longint;
			EndFirstPart: longint;
			StartLastPart: longint;
			EndLastPart: longint;
			SepPos: integer;

	begin
{ Split the line into two pairs of ranges }
		SepPos := Pos(',', Line);
		FirstPart := Copy(Line, 1, SepPos - 1);
		LastPart := Copy(Line, SepPos + 1, Length(Line));

		SepPos := Pos('-', Firstpart);
		StartFirstPart := StringToInteger(Copy(FirstPart, 1, SepPos - 1));
		EndFirstPart := StringToInteger(Copy(FirstPart, SepPos + 1, Length(FirstPart)));

		SepPos := Pos('-', LastPart);
		StartLastPart := StringToInteger(Copy(LastPart, 1, SepPos - 1));
		EndLastPart := StringToInteger(Copy(LastPart, SepPos + 1, Length(LastPart)));

		if (StartFirstPart >= StartLastPart) and (EndFirstPart <= EndLastPart) then
			begin
{WriteLn(StartFirstPart, '>=', StartLastPart, 'and', EndFirstPart, '<=', EndLastPart);}
				GetScorePart1 := 1;
			end
		else if (StartLastPart >= StartFirstPart) and (EndLastPart <= EndFirstPart) then
			begin
{WriteLn(StartLastPart, '>=', StartFirstPart, 'and', EndLastPart, '<=', EndFirstPart);}
				GetScorePart1 := 1;
			end
		else
			GetScorePart1 := 0;

	end;

	function GetScorePart2 (var Line: string): integer;
		var
			FirstPart: string;
			LastPart: string;
			StartFirstPart: longint;
			EndFirstPart: longint;
			StartLastPart: longint;
			EndLastPart: longint;
			SepPos: integer;

	begin
{ Split the line into two pairs of ranges }
		SepPos := Pos(',', Line);
		FirstPart := Copy(Line, 1, SepPos - 1);
		LastPart := Copy(Line, SepPos + 1, Length(Line));

		SepPos := Pos('-', Firstpart);
		StartFirstPart := StringToInteger(Copy(FirstPart, 1, SepPos - 1));
		EndFirstPart := StringToInteger(Copy(FirstPart, SepPos + 1, Length(FirstPart)));

		SepPos := Pos('-', LastPart);
		StartLastPart := StringToInteger(Copy(LastPart, 1, SepPos - 1));
		EndLastPart := StringToInteger(Copy(LastPart, SepPos + 1, Length(LastPart)));

{ Either: the end part of the first half is within the last half range }
		if (EndFirstPart >= StartLastPart) and (EndFirstPart <= EndLastPart) then
			GetScorePart2 := 1
{ Or: the end part of the last half is within the first half range }
		else if (EndLastPart >= StartFirstPart) and (EndLastPart <= EndFirstPart) then
			GetScorePart2 := 1
		else
			GetScorePart2 := 0;

	end;

begin
	WriteLn('Advent of Code 2022 Day 4');
	Reset(InputFile, 'd4.txt');

	TotalScorePart1 := 0;
	TotalScorePart2 := 0;
	RowCounter := 0;

	while not Eof(InputFile) do
		begin
			RowCounter := RowCounter + 1;
			ReadLn(InputFile, Line);

			TotalScorePart1 := TotalScorePart1 + GetScorePart1(Line);
			TotalScorePart2 := TotalScorePart2 + GetScorePart2(Line);
		end;

	close(InputFile);
	WriteLn('Total score part 1:', TotalScorePart1);
	WriteLn('Total score part 2:', TotalScorePart2);
	ReadLn;
end.