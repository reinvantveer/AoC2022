program AoCd2;
        var
                InputFile: text;
                Round: string;
                Score: integer;
                TotalScorePart1: longint;
                TotalScorePart2: longint;

        function GetScorePart1 (Round: string): integer;
        begin
                if Round = 'A X' then
                        GetScorePart1 := (1 + 3);
                if Round = 'A Y' then
                        GetScorePart1 := (2 + 6);
                if Round = 'A Z' then
                        GetScorePart1 := (3 + 0);
                if Round = 'B X' then
                        GetScorePart1 := (1 + 0);
                if Round = 'B Y' then
                        GetScorePart1 := (2 + 3);
                if Round = 'B Z' then
                        GetScorePart1 := (3 + 6);
                if Round = 'C X' then
                        GetScorePart1 := (1 + 6);
                if Round = 'C Y' then
                        GetScorePart1 := (2 + 0);
                if Round = 'C Z' then
                        GetScorePart1 := (3 + 3);
        end;

        function GetScorePart2 (Round: string): integer;
        begin
                if Round = 'A X' then
           {Rock; We need to lose so we play scissors}
                        GetScorePart2 := (3 + 0);
                if Round = 'A Y' then
           {Rock; We need to draw so we play rock}
                        GetScorePart2 := (1 + 3);
                if Round = 'A Z' then
           {Rock; We need to win so we play paper}
                        GetScorePart2 := (2 + 6);
                if Round = 'B X' then
           {Paper; we need to lose so we play rock}
                        GetScorePart2 := (1 + 0);
                if Round = 'B Y' then
           {Paper; we need to draw so we play paper}
                        GetScorePart2 := (2 + 3);
                if Round = 'B Z' then
           {Paper; we need to win so we play scissors}
                        GetScorePart2 := (3 + 6);
                if Round = 'C X' then
           {Scissors; we need to lose so we play paper}
                        GetScorePart2 := (2 + 0);
                if Round = 'C Y' then
           {Scissors; we need to draw so we play scissors}
                        GetScorePart2 := (3 + 3);
                if Round = 'C Z' then
           {Scissors; we need to win so we play rock}
                        GetScorePart2 := (1 + 6);
        end;

begin
        WriteLn('Advent of Code 2022 Day 2');
        open(InputFile, 'd2p1.txt');
        WriteLn('Opened input file');

        TotalScorePart1 := 0;
        TotalScorePart2 := 0;

        while not Eof(InputFile) do
                begin
                        ReadLn(InputFile, Round);
                        TotalScorePart1 := TotalScorePart1 + GetScorePart1(Round);
                        TotalScorePart2 := TotalScorePart2 + GetScorePart2(Round);
                end;

        close(InputFile);
        WriteLn('Total score part 1:', TotalScorePart1);
        WriteLn('Total score part 2:', TotalScorePart2);
        ReadLn;

end.
