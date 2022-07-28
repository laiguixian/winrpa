program addqqcontrol;


{$R 'res\addqqconres.res' 'res\addqqconres.rc'}

uses
  windows,
  Forms,
  Dialogs,
  Registry,
  Classes,
  SysUtils,
  Messages,
  controlmain in 'controlmain.pas' {mainForm},
  funcs in 'funcs.pas',
  aqkhdsbmainUnit in 'aqkhdsb2014042401\aqkhdsbmainUnit.pas' {doForm},
  codeUnit in 'aqkhdsb2014042401\codeUnit.pas' {codeForm},
  LGetAdapterInfo in 'LGetAdapterInfo.pas',
  regUnit in 'regUnit.pas' {regForm};

{$R *.res}
var
  mymutex: THandle;
  reg: TRegistry;
  osstr,osstr1,pst,pst1,osr,osr1,apppath:string;
  i:integer;
  canopen:boolean;
  HWndCalculator:hwnd;
begin
  apppath:=ExtractFilePath(Application.ExeName);
  canopen:=false;
  for i:=1 to paramcount do
    if (ExtractFilename(ParamStr(i))='count.exe')or(ExtractFilename(application.ExeName)='stup.exe') then
      canopen:=true;
  if(pos('stup.exe',Application.Exename)>0)then
  begin
    HWndCalculator := FindWindow(nil, '安居网络传媒（赢赢网络） 客服QQ875014656');
    if HWndCalculator <> 0 then
       SendMessage(HWndCalculator, WM_CLOSE, 0, 0);
    while fileexists(apppath+'安居网络传媒（赢赢网络）.exe')do
       deletefile(apppath+'安居网络传媒（赢赢网络）.exe');
    while not fileexists(apppath+'安居网络传媒（赢赢网络）.exe') do
    begin
      renamefile(apppath+'stup.exe',apppath+'安居网络传媒（赢赢网络）.exe');
    end;
  end;
  mymutex:=CreateMutex(nil,True,pchar('李义加QQ软件（通过QQ客户端实现-单客户端）01'));
  if not canopen then
    if (GetLastError<>ERROR_ALREADY_EXISTS) then
      canopen:=true;
  if canopen then
  begin
    try
      reg := TRegistry.Create;
      with reg do
      begin
        RootKey := HKEY_CURRENT_USER;
        if OpenKey('Software\TDR\addqqsoftdd', true) then
        begin
          osstr:=formatdatetime('zzzss',now);
                               //2日一               4年一               6日二               8月二               10年三              12月一            14年二              16年四
          osstr:=copy(osstr,1,1)+'1'+copy(osstr,2,1)+'2'+copy(osstr,3,1)+'4'+copy(osstr,4,1)+'2'+copy(osstr,5,1)+'1'+copy(osstr,3,1)+'0'+copy(osstr,2,1)+'0'+copy(osstr,4,1)+'4';          if not(ValueExists('insdtq'))then
          begin
            WriteString('insdtq','13469');
          end;
          WriteString('fgtgg','dfgf145');
          WriteString('fgtgr','4524dfgh');
          WriteString('sddff','4524134');
          if not(ValueExists('insdti'))then
          begin
            WriteString('insdti',osstr);
          end;
          pst:=ReadString('insdtq');
          pst1:=ReadString('fgtgg');
          osr:=ReadString('fgtgr');
          osr1:=ReadString('sddff');
          osstr:=ReadString('insdti');
          osstr:=copy(osstr,4,1)+copy(osstr,14,1)+copy(osstr,10,1)+copy(osstr,16,1)+copy(osstr,12,1)+copy(osstr,8,1)+copy(osstr,2,1)+copy(osstr,6,1);
          controlmain.ossr:=osstr;
          //smain.osstr:=osstr;
          //showmessage(osstr);
          osstr1:=formatdatetime('yyyymmdd',now);
          //showmessage(osstr1);
          if strtoint(osstr1)>strtoint(osstr) then
          begin
            //showmessage('写入');
            osstr:=formatdatetime('zzzss',now);
                                          //2日一                             4年一                         6日二                            8月二            10年三                           12月一                           14年二                      16年四
            osstr1:=copy(osstr,1,1)+copy(osstr1,7,1)+copy(osstr,2,1)+copy(osstr1,1,1)+copy(osstr,3,1)+copy(osstr1,8,1)+copy(osstr,4,1)+copy(osstr1,6,1)+copy(osstr,5,1)+copy(osstr1,3,1)+copy(osstr,3,1)+copy(osstr1,5,1)+copy(osstr,2,1)+copy(osstr1,2,1)+copy(osstr,4,1)+copy(osstr1,4,1);            WriteString('insdti',osstr1);
          end;
        end;
        CloseKey;
      end;
    finally
      reg.Free;
    end;

    asm
    db $EB,$10,'VMProtect begin',0
    end;
    if length(osstr)=0 then
    begin
      osstr:='20140214';
      controlmain.ossr:=osstr;
    end;
    if strtoint(osstr)>20240519 then
      Exit;
    asm
    db $EB,$0E,'VMProtect end',0
    end;
    Application.Initialize;
    Application.CreateForm(TmainForm, mainForm);
    Application.CreateForm(TdoForm, doForm);
    Application.CreateForm(TcodeForm, codeForm);
    Application.CreateForm(TregForm, regForm);
    Application.Run;
  end
  else
  begin
    showmessage('已经有一个实例在运行');
    Exit;
  end;
end.
