unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    MenuItem2: TMenuItem;
    miQuit: TMenuItem;
    miBackgroundColor: TMenuItem;
    miFont: TMenuItem;
    mMain: TMainMenu;
    MenuItem1: TMenuItem;
    pmMain: TPopupMenu;
    Separator1: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure miBackgroundColorClick(Sender: TObject);
    procedure miFontClick(Sender: TObject);
    procedure miQuitClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.MenuItem2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  fMain.Font := FontDialog1.Font;
  fMain.Font.Color := FontDialog1.Font.Color;
  fMain.Color := ColorDialog1.Color;
end;

procedure TfMain.miBackgroundColorClick(Sender: TObject);
begin
  if ColorDialog1.Execute then
    fMain.Color := ColorDialog1.Color;
end;

procedure TfMain.miFontClick(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    fMain.Font := FontDialog1.Font;
    fMain.Font.Color := FontDialog1.Font.Color;
  end;
end;

procedure TfMain.miQuitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfMain.Timer1Timer(Sender: TObject);
var
  boolFindFontSize: boolean = False;
  CurrentTime: TDateTime;
  strSecond, strTime: string;
  intSecond, intStep, TextWidth, TextHeight, FontSize: integer;
begin
  FontSize := 100;
  intStep := 10;
  Canvas.Font.Size := FontSize;
  //Canvas.Font.Color := clGray;
  //Canvas.Font.Name := 'Lucida Console';
  Canvas.Font.Style := [fsBold];
  CurrentTime := Now();

  strSecond := FormatDateTime('ss', CurrentTime);
  intSecond := StrToInt(strSecond);
  if intSecond mod 2 = 0 then
    strTime := FormatDateTime('hh nn', CurrentTime)
  else
    strTime := FormatDateTime('hh:nn', CurrentTime);

  TextWidth := Canvas.TextWidth(strTime);
  TextHeight := Canvas.TextHeight(strTime);

  //memo1.Lines.add(format('C.width x T.width = %d x %d', [Canvas.Width, TextWidth]));
  //memo1.Lines.add(format('C.height x T.height = %d x %d', [Canvas.Height, TextHeight]));

  boolFindFontSize := False;
  repeat
    if (TextWidth >= Canvas.Width - intStep) or (TextHeight >=
      Canvas.Height - intStep) then
      boolFindFontSize := True
    else
    begin
      Canvas.Font.Size := Canvas.Font.Size + intStep;
      TextWidth := Canvas.TextWidth(strTime);
      TextHeight := Canvas.TextHeight(strTime);
    end;
  until boolFindFontSize;

  {while (TextWidth < Canvas.Width) or (TextHeight < Canvas.Height) do
  begin
    if TextWidth > TextHeight then
      FontSize := Round(FontSize * Canvas.Width / TextWidth)
    else
      FontSize := Round(FontSize * Canvas.Height / TextHeight);
    Canvas.Font.Size := FontSize;
  end;}

  TextWidth := Canvas.TextWidth(strTime);
  TextHeight := Canvas.TextHeight(strTime);

  Canvas.TextOut((Canvas.Width - TextWidth) div 2,
    (Canvas.Height - TextHeight) div 2, strTime);
end;

end.
