unit codeUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TcodeForm = class(TForm)
    Image1: TImage;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  codeForm: TcodeForm;

implementation

{$R *.dfm}

procedure TcodeForm.BitBtn1Click(Sender: TObject);
begin
  self.Close;
end;

end.
