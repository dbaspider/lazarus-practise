program Console;
uses SysUtils;
var
  i, j: integer;
begin
  writeln('This is a simple console program.');
  for i := 1 to 9 do
  begin
    for j := 1 to 9 do
    begin
      write(format('%2d', [i*j]), ' ');
    end;
    writeln;
  end;
  readln;
end.

