unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons, Windows, tools;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnHello: TBitBtn;
    btnBrowser: TButton;
    btnCheck: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    procedure btnBrowserClick(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnHelloClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  { form init }
  Edit1.Clear;
  Memo1.Clear;
end;

procedure TForm1.btnBrowserClick(Sender: TObject);
begin
  // browse for file
  if (OpenDialog1.Execute) then
  begin
    Edit1.Text:= OpenDialog1.FileName;
  end;
end;

procedure TForm1.btnCheckClick(Sender: TObject);
var
  pmTag, nmTag: USHORT;
  mode: String;
begin
  // check process wow64 info
  Memo1.Lines.Add('IsWow64Process = ' + BoolToStr(IsWow64Process(), true));
  Memo1.Lines.Add('IsWow64Process2 = ' + BoolToStr(IsWow64Process2(pmTag, nmTag), true));
  Memo1.Lines.Add('pmTag = ' + inttohex(pmTag) + ' / nmTag = ' + inttohex(nmTag));
  mode := 'N/A';
  if (pmTag = IMAGE_FILE_MACHINE_I386) then
  begin
    mode := 'Process run in 32-bit mode';
  end;
  Memo1.Lines.Add(mode);
  Memo1.Lines.Add('------------------------------------------');
end;

procedure TForm1.btnHelloClick(Sender: TObject);
begin
  (* hello click *)
  ShowMessage('foo bar');
end;

end.

