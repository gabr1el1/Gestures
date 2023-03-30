unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Objects, FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation,
  FMX.Gestures, FMX.Edit;

type
  TfrmMain = class(TForm)
    GestureManager1: TGestureManager;
    Panel1: TPanel;
    memLog: TMemo;
    pnlMain: TPanel;
    edtMin: TEdit;
    edtMax: TEdit;
    Label1: TLabel;
    Image1: TImage;
    Circle1: TCircle;
    btnClear: TButton;
    procedure pnlMainGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
    count:Integer;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}

procedure TfrmMain.btnClearClick(Sender: TObject);
begin
  memLog.Lines.Clear;
end;

procedure TfrmMain.pnlMainGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
  var S: String;
begin
  if GestureToIdent(EventInfo.GestureID, S)
  then Handled := true;
  memLog.Lines.Add(
  Format('GestureID%d,<%s>',[EventInfo.GestureID,S]));
  case EventInfo.GestureID of
    sgiLeft: Dec(count);
    sgiRight: Inc(count);
    sgiChevronLeft: count:=Integer.Parse(edtMin.Text);
    sgiChevronRight: count:=Integer.Parse(edtMax.Text);
  end;
  if count<Integer.Parse(edtMin.Text) then
  count:=Integer.Parse(edtMax.Text)
  else if count>Integer.Parse(edtMax.Text) then
  count:=Integer.Parse(edtMin.Text);

  Label1.Text:=count.ToString;
end;

end.
