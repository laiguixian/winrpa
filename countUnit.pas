unit countUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,DB, ADODB, Grids, DBGrids, Buttons,math,
  Mask, ExtCtrls, ComCtrls,Tlhelp32,HttpApp,ShlObj,ComObj,ShellApi, WinInet,
  GridsEh, DBGridEh, Menus,Clipbrd,IdHTTP, jpeg,StrUtils, Shell32_TLB,
  OleServer,Registry,IdSMTP,IdMessage,IdAttachmentfile,nb30, OleCtrls,
  SHDocVw,MSHTML,DateUtils, ActnMan, ActnColorMaps;
{uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,DB, ADODB, Grids, DBGrids, Buttons,math,
  Mask, ExtCtrls, ComCtrls,Tlhelp32,HttpApp,ShlObj,ComObj,ShellApi, WinInet,
  GridsEh, DBGridEh, Menus,Clipbrd,IdHTTP, jpeg,StrUtils, Shell32_TLB,
  OleServer,Registry,IdSMTP,IdMessage,IdAttachmentfile,nb30, OleCtrls,
  SHDocVw,MSHTML,DateUtils, ActnMan, ActnColorMaps;}

const                                    //用于禁用启用网卡
connVerb = '启用'; 
discVerb = '停用';
type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  timepass:integer;
  kuandaits:tstringlist;
  apppath:string;
implementation

{$R *.dfm}

function KillTask(ExeFileName: string): integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := 0;

  FSnapshotHandle := CreateToolhelp32Snapshot
    (TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,
    FProcessEntry32);

  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName))
      or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(OpenProcess(
        PROCESS_TERMINATE, BOOL(0),
        FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle,
      FProcessEntry32);
  end;
end;

procedure CheckResult(b: Boolean);
begin
if not b then
Raise Exception.Create(SysErrorMessage(GetLastError));
end;

function RunDOS(const CommandLine: String): String;
var
HRead,HWrite:THandle;
StartInfo:TStartupInfo;
ProceInfo:TProcessInformation;
b:Boolean;
sa:TSecurityAttributes;
inS:THandleStream;
sRet:TStrings;
begin
Result := '';
FillChar(sa,sizeof(sa),0); 
//设置允许继承，否则在NT和2000下无法取得输出结果
sa.nLength := sizeof(sa); 
sa.bInheritHandle := True;
sa.lpSecurityDescriptor := nil; 
b := CreatePipe(HRead,HWrite,@sa,0);
CheckResult(b);

FillChar(StartInfo,SizeOf(StartInfo),0); 
StartInfo.cb := SizeOf(StartInfo);
StartInfo.wShowWindow := SW_HIDE;
//使用指定的句柄作为标准输入输出的文件句柄,使用指定的显示方式
StartInfo.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
StartInfo.hStdError := HWrite;
StartInfo.hStdInput := GetStdHandle(STD_INPUT_HANDLE);//HRead;
StartInfo.hStdOutput := HWrite;

b := CreateProcess(nil,//lpApplicationName: PChar
PChar(CommandLine), //lpCommandLine: PChar
nil, //lpProcessAttributes: PSecurityAttributes 
nil, //lpThreadAttributes: PSecurityAttributes
True, //bInheritHandles: BOOL
CREATE_NEW_CONSOLE,
nil,
nil,
StartInfo, 
ProceInfo );

CheckResult(b);
WaitForSingleObject(ProceInfo.hProcess,INFINITE);

inS := THandleStream.Create(HRead);
if inS.Size>0 then
begin
    sRet := TStringList.Create;
    sRet.LoadFromStream(inS);
    Result := sRet.Text;
    sRet.Free;
end;
inS.Free;

CloseHandle(HRead);
CloseHandle(HWrite); 
end;

function ControlEthernet(const EthName,
FolderItemVerbsName: string): Boolean;
var cpFolder, nwFolder: Folder; //一个外壳文件夹对象
nVerbs: FolderItemVerbs; //获得上下文相关的菜单信息
i, j, k: integer;
Shell1: TShell;
begin 
  Result := false;
  Shell1 := TShell.Create(Application);
  cpFolder := Shell1.NameSpace(3); //选择控件面板
  if cpFolder <> nil then
  begin
    for i := 0 to cpFolder.items.Count - 1 do //返回它所包含的外壳对象的集合(文件) 28
    begin
      if cpFolder.Items.Item(i).Name = '网络连接' then //返回的集合的名称
      begin
        nwFolder := cpFolder.items.item(i).GetFolder as Folder; //取得该cpFolder下面的外壳对象
        if nwFolder <> nil then //内容不为空
        begin
          for j := 0 to nwFolder.items.Count - 1 do //历遍cpFolder下面的外壳对象
          begin
            if nwFolder.Items.Item(j).Name = EthName then //若果为'本地连接'
            begin
              nVerbs := nwFolder.Items.Item(j).Verbs; //取得该对象的上下文菜单信息
              for k := 0 to nVerbs.Count - 1 do //历遍所有菜单信息
              begin
                if Pos(FolderItemVerbsName, nVerbs.Item(k).Name) > 0 then //如果菜单名称为 '禁用&' 时,
                                                               // 则执行该菜单命令
                begin
                  nVerbs.Item(k).DoIt; //执行该菜单命令
                  //nwFolder.Items.Item(j).InvokeVerb(nwFolder.Items.Item(j).Verbs.Item(k).Name);
                  Result := true; //效果一致
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  Shell1.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
i,Types:integer;
XmlHttp: OleVariant;
backstr,datetxt:string;
begin
    //if (timepass mod 3600=0)and(timepass<>0) then
    Label2.Caption:='现在时间：'+formatdatetime('hh:nn:ss',now);
    if (timepass mod 3600=0)and(timepass<>0) then
    begin
      //application.Terminate;
      for i:=1 to paramcount do
        if ExtractFilename(ParamStr(i))='安居网络传媒（赢赢网络）.exe' then
        //if ExtractFilename(ParamStr(i))='addqqcontrol.exe' then
        begin
          KillTask(ExtractFilename(ParamStr(i)));
          sleep(3000);
          {datetxt := '';
          backstr := '';
          try
            XmlHttp := CreateOleObject('Microsoft.XMLHTTP');
            XmlHttp.Open('GET', 'http://open.baidu.com/special/time/', False);
            XmlHttp.Send;//Mon, 05 May 2014 13:21:59 GMT
                         //True, 05 May 2014 13:21:59 GMT
            datetxt := XmlHttp.GetResponseHeader('Date');
            xmlHttp := Unassigned;
          except
          end;}
          if not InternetCheckConnection('http://open.baidu.com/special/time/',1,0) then
          //if (length(datetxt)=0) then
          begin
            //RunDOS('rasdial /disconnect');
            Types:=INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY;
            if not internetGetConnectedState(@types,0) then
            begin
              ControlEthernet('本地连接', connVerb); //启用本地连接 '启用&'
              Types:=INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY;
              while not internetGetConnectedState(@types,0) do
              begin
                Types:=INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY;
              end;
            end;
            while (pos('已连接',backstr)=0) do
            begin
              backstr:=RunDOS('rasdial 宽带连接 '+kuandaits.Strings[0]+' '+kuandaits.Strings[1]);
              sleep(1000);
            end;
          end;
          sleep(5000);
          ShellExecute(handle, 'open',pchar(ParamStr(i)),pchar(application.exename),nil, SW_SHOWNORMAL);
          self.Close;
        end;
    end;
  timepass:=timepass+1;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
i:integer;
begin
  apppath:=ExtractFilePath(Application.ExeName);
  Label1.Caption:='开始时间：'+formatdatetime('hh:nn:ss',now);
  self.Left:=10;
  self.Top:=screen.Height-self.Height-30;
  kuandaits:=tstringlist.Create;
  if fileexists(apppath+'宽带账号.txt') then
    kuandaits.LoadFromFile(apppath+'宽带账号.txt');
  {for i:=1 to paramcount do
        showmessage(ParamStr(i));}
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  kuandaits.Free;
end;

end.
