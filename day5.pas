
program AoCd5;
	uses
		SharedAoC; { For StringToInteger function }
	type
	{ We can parse a maximum of 10 lines of initial stack state }
		StackLinesType = array[1..10] of string;
	{ We can store a maximum of 9 stack columns }
		StackType = array[1..9] of string[127];
	var
		InputFile: text;
		InputLine: string;
		InputRowCounter: longint;
		StackLines: StackLinesType;
		Stack: StackType;
		StackColumnIdx: integer;
		StackRowIdx: integer;
		StackValue: char;
		TotalScorePart1: string;
		TotalScorePart2: string;

	function ParseStack (StackLines: StackLinesType): StackType;
		var
			Stack: StackType;
			StackColumnIdx: integer;
			StackLine: string;
			LineCounter: integer;
			ColumnHeader: string;
			OpenBracketPos: integer;
			NextOpenBracketPos: integer;
			CloseBracketPos: integer;
			StackValue: char;
			StackColumnChar: char;
			StackColumnAsInteger: integer;
	begin
	{ Initialize the stack as an array of columns with empty strings }
		for StackColumnIdx := 1 to 9 do
			Stack[StackColumnIdx] := '';

	{ Initialize the column header of the stack as empty string }
		ColumnHeader := '';

		for LineCounter := 10 downto 1 do
		{ Parse each line in the initial stack lines }
			begin
				StackLine := StackLines[LineCounter];

				if length(StackLine) = 0 then
					Cycle;

				WriteLn('StackLine: ', StackLine);

				if length(ColumnHeader) = 0 then
		{ Set the column header to the last non-empty line in the stack lines }
					begin
						ColumnHeader := StackLine;
						WriteLn('Column header: ', ColumnHeader);
						Cycle;
					end;

				OpenBracketPos := Pos('[', StackLine);

				while true do
		{ Loop over all the opening bracket positions in the stack line and extract the values }
					begin
			{ Take the value after the first opening bracket: it contains the value for the stack}
						StackValue := StackLine[OpenBracketPos + 1];

			{ Get the column id from the header }
						StackColumnChar := ColumnHeader[OpenBracketPos + 1];
						StackColumnAsInteger := StringToInteger(StackColumnChar);

			{ Add the StackValue to the StackColumn }
			{ Note that you CANNOT extract the stack indexed string as a variable: it will create a copy }
						Stack[StackColumnAsInteger] := Concat(Stack[StackColumnAsInteger], StackValue);

			{ Look for the next StackValue in the StackLine, if any }
						NextOpenBracketPos := Pos('[', Copy(StackLine, OpenBracketPos + 1, Length(StackLine)));

						if NextOpenBracketPos > 0 then
							OpenBracketPos := NextOpenBracketPos + OpenBracketPos
						else
							leave;

					end;

			end;

		ParseStack := Stack
	end;

	function MoveStackValues (Stack: StackType; Line: string; IsReverse: boolean): StackType;
		var
			StartIdx: integer;
			Count: integer;
			MovesAmount: integer;
			MoveIdx: integer;
			ValueToMove: char;
			FromColumnIdx: integer;
			ToColumnIdx: integer;
			StackColumnIdx: integer;
			ExtractionIdx: integer;
	begin
	{ Start by parsing the amount of moves }
		StartIdx := Pos(' ', Line) + 1;
		Count := Pos(' ', Copy(Line, StartIdx, Length(Line))) - 1;
		MovesAmount := StringToInteger(Copy(Line, StartIdx, Count));

	{ Next, we parse the 'from' column }
		StartIdx := Pos('from ', Line) + 5;
		Count := Pos(' ', Copy(Line, StartIdx, Length(Line))) - 1;
		FromColumnIdx := StringToInteger(Copy(Line, StartIdx, Count));

	{ We parse the 'to' column }
		StartIdx := Pos('to ', Line) + 3;
		Count := Length(Line) - StartIdx + 1;
		ToColumnIdx := StringToInteger(Copy(Line, StartIdx, Count));

		for MoveIdx := (MovesAmount - 1) downto 0 do
	{ Add the at the MoveIdx from source column to the target column }
			begin
				if IsReverse then
					ExtractionIdx := length(Stack[FromColumnIdx])
				else
					ExtractionIdx := length(Stack[FromColumnIdx]) - MoveIdx;

				ValueToMove := Copy(Stack[FromColumnIdx], ExtractionIdx, 1);
				Stack[ToColumnIdx] := Concat(Stack[ToColumnIdx], ValueToMove);

	{ Drop the source column value once added the target column }
				Delete(Stack[FromColumnIdx], ExtractionIdx, 1);

			end;


		MoveStackValues := Stack;
	end;

	function GetScorePart1 (var Stack: StackType): string;
		var
			ColumnIdx: integer;
			Column: string;
			TopValues: string;
	begin
		TopValues := '';

		for ColumnIdx := 1 to 9 do
			begin
				Column := Stack[ColumnIdx];
				if length(Column) > 0 then
					TopValues := Concat(TopValues, Column[length(Stack[ColumnIdx])]);
			end;

		GetScorePart1 := TopValues;
	end;

	function GetScorePart2 (var Stack: StackType): string;
	begin
	end;

begin
	WriteLn('Advent of Code 2022 Day 5');
	Reset(InputFile, 'd5.txt');
	InputRowCounter := 0;

	while not Eof(InputFile) do
		begin
			InputRowCounter := InputRowCounter + 1;
			ReadLn(InputFile, InputLine);

	{ Create, modify the stack or add lines to the stacklines to build the stack state from }
			if length(InputLine) = 0 then  { This is the separator line between the initial stack and the move ops }
				begin
					Stack := ParseStack(StackLines);

		{ Debug: show the contents of the parsed stack }
					for StackColumnIdx := 1 to 9 do
						if length(Stack[StackColumnIdx]) > 0 then
							WriteLn('Initial stack state column ', StackColumnIdx, ':', Stack[StackColumnIdx]);
				end

			else if InputLine[1] = 'm' then  { "m" for "move" }
		{ Part 1: do stack placements in reverse }
		{ Stack := MoveStackValues(Stack, InputLine, true) }
		{ Part 2: do stack placements in-order }
				Stack := MoveStackValues(Stack, InputLine, false)

			else  { Otherwise: a part of the initial stack state }
				begin
					WriteLn('Stack add', InputLine);
					StackLines[InputRowCounter] := InputLine;
				end;

		end;

	TotalScorePart1 := GetScorePart1(Stack);

	close(InputFile);
	WriteLn('Total score part 1:', TotalScorePart1);
	WriteLn('Total score part 2:', TotalScorePart2);
	ReadLn;
end.