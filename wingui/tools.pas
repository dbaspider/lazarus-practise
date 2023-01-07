unit tools;

{$mode delphi}
{$H+}

interface

uses
  Classes, SysUtils, dynlibs, imagehlp, Windows, Forms, Dialogs;

type
  TIsWow64Process = function(hProcess: THandle; var Wow64Process: BOOL): BOOL; stdcall;
  TIsWow64Process2 = function(hProcess: THandle; var ProcessMachine: USHORT; var NativeMachine: USHORT): BOOL; stdcall;

  function IsWow64Process: BOOL;
  function IsWow64Process2(var pm: USHORT; var nm: USHORT): BOOL;

const
  IMAGE_FILE_MACHINE_UNKNOWN = 0;
  IMAGE_FILE_MACHINE_I386 = $014c;
  IMAGE_FILE_MACHINE_AMD64 = $8664;
implementation

const
  Called: Boolean = False;
  IsWow64: BOOL = False;

{$J+}
function IsWow64Process: BOOL;
var
  DLLHandle: THandle;
  pIsWow64Process: TIsWow64Process;
  ret: BOOL;
begin
  if (Not Called) then // only check once
  begin
    DLLHandle := LoadLibrary('kernel32.dll');
    if (DLLHandle <> 0) then
    begin
      @pIsWow64Process := GetProcAddress(DLLHandle, 'IsWow64Process');
      if (Assigned(pIsWow64Process)) then
      begin
        ret := pIsWow64Process(GetCurrentProcess(), IsWow64);
        if (not ret) then
        begin
          showmessage(inttostr(getlasterror));
        end;
      end;
      Called := True; // avoid unnecessary loadlibrary
      FreeLibrary(DLLHandle);
    end;
  end;
  Result := IsWow64;
end;
{$J-}

function IsWow64Process2(var pm: USHORT; var nm: USHORT): BOOL;
var
  DLLHandle: THandle;
  pIsWow64Process2: TIsWow64Process2;
  ret: BOOL;
begin
  pm := 0;
  nm := 0;
  DLLHandle := LoadLibrary('kernel32.dll');
  if (DLLHandle <> 0) then
  begin
    @pIsWow64Process2 := GetProcAddress(DLLHandle, 'IsWow64Process2');
    if (Assigned(pIsWow64Process2)) then
    begin
      ret := pIsWow64Process2(GetCurrentProcess(), pm, nm);
      if (not ret) then
      begin
        showmessage(inttostr(getlasterror));
      end;
    end;
    FreeLibrary(DLLHandle);
  end;
  Result := ret;
end;

end.

