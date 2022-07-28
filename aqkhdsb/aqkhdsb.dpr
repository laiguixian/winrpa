program aqkhdsb;

uses
  Forms,
  aqkhdsbmainUnit in 'aqkhdsbmainUnit.pas' {doForm},
  codeUnit in 'codeUnit.pas' {codeForm},
  funcs in 'funcs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdoForm, doForm);
  Application.CreateForm(TcodeForm, codeForm);
  Application.Run;
end.
