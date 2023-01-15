program AoCd3;
        type
                BadgeGroup = array[0..2] of string;
                                          
        const                             
                Priorities = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
                                          
        var                               
                InputFile: text;          
                Line: string;
                RowCounter: integer;
                IsGroupOfThree: boolean;
                Group: BadgeGroup;
                TotalScorePart1: longint;
                TotalScorePart2: longint;

        function GetScorePart1 (var Line: string): integer;
                var
                        FirstHalf: string;
                        LastHalf: string;
                        CharPos: integer;
                        PriorityForMatch: integer;
        begin
{Split the line half way}
                FirstHalf := Copy(Line, 1, Trunc(Length(Line) / 2));
                LastHalf := Copy(Line, Trunc(length(Line) / 2) + 1, Length(Line));

                for CharPos := 1 to Length(FirstHalf) do
                        begin
                                if pos(FirstHalf[CharPos], LastHalf) > 0 then
                                        begin
                                                PriorityForMatch := Pos(FirstHalf[CharPos], Priorities);
                                                GetScorePart1 := PriorityForMatch;
                                                Leave;
                                        end;
                        end;
        end;

        function GetScorePart2 (var group: BadgeGroup): integer;
                var
                        GroupIdx: integer;
                        CharPos: integer;
                        ItemToLookFor: char;
        begin

                for CharPos := 1 to Length(group[0]) do
                        begin
                                ItemToLookFor := group[0][CharPos];

                                if pos(ItemToLookFor, group[1]) > 0 then
                                        if pos(ItemToLookFor, group[2]) > 0 then
                                                begin
                                                        GetScorePart2 := Pos(ItemToLookFor, Priorities);
                                                end
                        end;
        end;

begin
        WriteLn('Advent of Code 2022 Day 3');
        Reset(InputFile, 'd3p1.txt');

        TotalScorePart1 := 0;
        TotalScorePart2 := 0;
        RowCounter := 0;

        while not Eof(InputFile) do
                begin
                        RowCounter := RowCounter + 1;
                        ReadLn(InputFile, Line);

                        TotalScorePart1 := TotalScorePart1 + GetScorePart1(Line);
                        IsGroupOfThree := RowCounter mod 3 = 0;

                        Group[RowCounter mod 3] := Line;

                        if IsGroupOfThree then
                                TotalScorePart2 := TotalScorePart2 + GetScorePart2(Group)
                end;

        close(InputFile);
        WriteLn('Total score part 1:', TotalScorePart1);
        WriteLn('Total score part 2:', TotalScorePart2);
        ReadLn;
end.
