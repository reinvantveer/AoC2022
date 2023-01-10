program AoC2022D1;
        var
                SampleFile: Text;
                Line: string;
                Calories: longint;
                Sum: longint;
                Max1: longint;
                Max2: longint;
                Max3: longint;

        function StringToInteger (s: string): longint;
                var
                        ParsedInteger: longint;
                        digit, index: integer;
        begin
                ParsedInteger := 0;

                for index := 1 to length(s) do
                        begin
                                digit := ord(s[index]) - ord('0');
                                ParsedInteger := (10 * ParsedInteger) + digit;
                        end;
                StringToInteger := ParsedInteger
        end;

        procedure UpdateMax (Cals: longint);
        begin
                if (Cals > Max1) then
                        begin
                                Max3 := Max2;
                                Max2 := Max1;
                                Max1 := Cals;
                                WriteLn('Updated Max1 to:', Max1);
                        end
                else if (Cals > Max2) then
                        begin
                                Max3 := Max2;
                                Max2 := Cals;
                                WriteLn('Updated Max2 to:', Max2);
                        end
                else if (Cals > Max3) then
                        begin
                                WriteLn('Updated Max3 to:', Max3);
                                Max3 := Cals;
                        end;
        end;

begin
        WriteLn('Advent of Code 2022 Day 1 part 1');
        WriteLn('Test:', StringToInteger('12345'));
        open(SampleFile, 'd1p1.txt');

        Sum := 0;
        Max1 := 0;
        Max2 := 0;
        Max3 := 0;

        while not Eof(SampleFile) do
                begin
                        Readln(SampleFile, Line);

                        if length(Line) = 0 then
                                begin
                                        WriteLn('Sum:', Sum);
                                        UpdateMax(Sum);
                                        Sum := 0;
                                end
                        else
                                begin
                                        Calories := StringToInteger(Line);
                                        Sum := Sum + Calories;
                                end
                end;

        WriteLn('Sum:', Sum);
        UpdateMax(Sum);

        WriteLn('Max1:', Max1);
        WriteLn('Max2:', Max2);
        WriteLn('Max3:', Max3);

        WriteLn('Sum of Top 3:', Max3 + Max2 + Max1);
        close(SampleFile);
        readln
end.
