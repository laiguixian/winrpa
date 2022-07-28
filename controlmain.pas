unit controlmain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,DB, ADODB, Grids, DBGrids, Buttons,math,
  Mask, ExtCtrls, ComCtrls,Tlhelp32,HttpApp,ShlObj,ComObj,ShellApi, WinInet,
  GridsEh, DBGridEh, Menus,Clipbrd,IdHTTP, jpeg,StrUtils, Shell32_TLB,
  OleServer,Registry,IdSMTP,IdMessage,IdAttachmentfile,nb30, OleCtrls,
  SHDocVw,MSHTML,DateUtils, ActnMan, ActnColorMaps,urlmon;
function deletetempcookie:boolean;
function deletetempfile:boolean;
const                                    //���ڽ�����������
connVerb = '����'; 
discVerb = 'ͣ��';
//���ڻ�ȡ����IP��ʼ
MAX_HOSTNAME_LEN               = 128;
MAX_DOMAIN_NAME_LEN            = 128;
MAX_SCOPE_ID_LEN               = 256;
MAX_ADAPTER_NAME_LENGTH        = 256;
MAX_ADAPTER_DESCRIPTION_LENGTH = 128;
MAX_ADAPTER_ADDRESS_LENGTH     = 8;
//������ؽṹ
Type
TIPAddressString = Array[0..4*4-1] of Char;

PIPAddrString = ^TIPAddrString;
TIPAddrString = Record
    Next      : PIPAddrString;
    IPAddress : TIPAddressString;
    IPMask    : TIPAddressString;
    Context   : Integer;
End;

PFixedInfo = ^TFixedInfo;
TFixedInfo = Record { FIXED_INFO }
    HostName         : Array[0..MAX_HOSTNAME_LEN+3] of Char;
    DomainName       : Array[0..MAX_DOMAIN_NAME_LEN+3] of Char;
    CurrentDNSServer : PIPAddrString;
    DNSServerList    : TIPAddrString;
    NodeType         : Integer;
    ScopeId          : Array[0..MAX_SCOPE_ID_LEN+3] of Char;
    EnableRouting    : Integer;
    EnableProxy      : Integer;
    EnableDNS        : Integer;
End;

PIPAdapterInfo = ^TIPAdapterInfo;
TIPAdapterInfo = Record { IP_ADAPTER_INFO }
    Next                : PIPAdapterInfo;
    ComboIndex          : Integer;
    AdapterName         : Array[0..MAX_ADAPTER_NAME_LENGTH+3] of Char;
    Description         : Array[0..MAX_ADAPTER_DESCRIPTION_LENGTH+3] of Char;
    AddressLength       : Integer;
    Address             : Array[1..MAX_ADAPTER_ADDRESS_LENGTH] of Byte;
    Index               : Integer;
    _Type               : Integer;
    DHCPEnabled         : Integer;
    CurrentIPAddress    : PIPAddrString;
    IPAddressList       : TIPAddrString;
    GatewayList         : TIPAddrString;
    DHCPServer          : TIPAddrString;
    HaveWINS            : Bool;
    PrimaryWINSServer   : TIPAddrString;
    SecondaryWINSServer : TIPAddrString;
    LeaseObtained       : Integer;
    LeaseExpires        : Integer;
End;
type
TGetAdaptersInfo=function(AI : PIPAdapterInfo; Var BufLen : Integer) : Integer;StdCall;
//���ڻ�ȡ����IP����

type
    TOSVersion = (osUnknown, os95, os98, osME, osNT3, osNT4, os2K, osXP, os2K3);    //����Զ������ͣ������ж�ϵͳ����

type
  TmainForm = class(TForm)
    OpenDialog1: TOpenDialog;
    ADOConnection1: TADOConnection;
    openmainqqADOQuery: TADOQuery;
    DataSource1: TDataSource;
    openlistqqADOQuery: TADOQuery;
    DataSource2: TDataSource;
    editmainqqADOQuery: TADOQuery;
    editlistqqADOQuery: TADOQuery;
    openevenADOQuery: TADOQuery;
    editevenADOQuery: TADOQuery;
    DataSource3: TDataSource;
    openmainqqtestADOQuery: TADOQuery;
    openlistqqtestADOQuery: TADOQuery;
    opentongjiADOQuery: TADOQuery;
    edittongjiADOQuery: TADOQuery;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    SaveDialog1: TSaveDialog;
    opendamaADOQuery: TADOQuery;
    editdamaADOQuery: TADOQuery;
    opencodeADOQuery: TADOQuery;
    editcodeADOQuery: TADOQuery;
    xmlcodeADOQuery: TADOQuery;
    Image2: TImage;
    opencodetestADOQuery: TADOQuery;
    Timer2: TTimer;
    OpenDialog2: TOpenDialog;
    SearchCommand1: TSearchCommand;
    Shell1: TShell;
    ShellFolderItem1: TShellFolderItem;
    ShellFolderView1: TShellFolderView;
    ShellLinkObject1: TShellLinkObject;
    openkdADOQuery: TADOQuery;
    editkdADOQuery: TADOQuery;
    openkdtestADOQuery: TADOQuery;
    DataSource4: TDataSource;
    Panel4: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    MaskEdit1: TMaskEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Edit3: TEdit;
    BitBtn5: TBitBtn;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    DBGridEh2: TDBGridEh;
    Panel2: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label34: TLabel;
    Label37: TLabel;
    BitBtn4: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn1: TBitBtn;
    Edit7: TEdit;
    BitBtn9: TBitBtn;
    ListBox1: TListBox;
    ListBox2: TListBox;
    TabSheet3: TTabSheet;
    Label26: TLabel;
    Label8: TLabel;
    Label15: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label7: TLabel;
    Label27: TLabel;
    Label31: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    BitBtn7: TBitBtn;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label20: TLabel;
    Edit2: TEdit;
    MaskEdit2: TMaskEdit;
    Button6: TButton;
    ComboBox3: TComboBox;
    Memo1: TMemo;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit8: TEdit;
    ComboBox1: TComboBox;
    BitBtn13: TBitBtn;
    CheckBox1: TCheckBox;
    Edit14: TEdit;
    QQpathEdit: TComboBox;
    QQpathEdit2: TComboBox;
    Edit15: TEdit;
    Edit16: TEdit;
    TabSheet4: TTabSheet;
    Panel3: TPanel;
    Label28: TLabel;
    Label29: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label30: TLabel;
    BitBtn10: TBitBtn;
    Edit9: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    Edit10: TEdit;
    DBGridEh4: TDBGridEh;
    DBGridEh3: TDBGridEh;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    SpeedButton1: TSpeedButton;
    Label38: TLabel;
    Image1: TImage;
    Image3: TImage;
    Label39: TLabel;
    WebBrowser1: TWebBrowser;
    WebBrowser2: TWebBrowser;
    Timer3: TTimer;
    Label40: TLabel;
    Label41: TLabel;
    ListBox3: TListBox;
    opensetADOQuery: TADOQuery;
    editsetADOQuery: TADOQuery;
    openverADOQuery: TADOQuery;
    editverADOQuery: TADOQuery;
    BitBtn14: TBitBtn;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    CheckBox2: TCheckBox;
    N7: TMenuItem;
    Label5: TLabel;
    Label42: TLabel;
    Edit13: TEdit;
    Label43: TLabel;
    verLbl: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Edit17: TEdit;
    Timer1: TTimer;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    Label46: TLabel;
    ComboBox2: TComboBox;
    BitBtn17: TBitBtn;
    QQpath2Edit: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure DBGridEh2TitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure BitBtn7Click(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    function huoquzhuangtai:boolean;             //��ȡ���״̬
    function jianchacwyzm:boolean;               //��������֤��
    function getdata(var fromado,toado:Tadoquery):boolean;  //ȡ�ñ�����
    //function deletetempcookie:boolean;
    procedure BitBtn8Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure QQpathEditChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Label39Click(Sender: TObject);
    procedure WebBrowser1DocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure Timer3Timer(Sender: TObject);
    procedure WebBrowser2DocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label38MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label39MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label40MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure N3Click(Sender: TObject);                      //ɾ����ʱ�ļ���cookie
    function outputmainqqlist(con: string):boolean;
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);                   //�������˺�       con�ǵ�������
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mainForm: TmainForm;
  regedyn:boolean;
  clistr:string;
  ossyspath:string;
  raqyn:boolean;
  zrcyn:boolean;
  iebyn:boolean;
  mattas:string;
  apppath:string;
  {webts:Tstringlist;          //�����б�
  conformsetts:Tstringlist;}
  timer1done:boolean;
  timer2done:boolean;
  allnumgiven:boolean;
  endcount,lsendcount:integer;
  endstr,lsendstr:string;
  ossr,pstt,pstt1,osrr,osrr1:string;
  timer1count:integer;
  jjghy,jgjc,jlhsc,ddjl:integer;
  kaishi:boolean;             //�Ѿ���ʼ�Ӻ�����
  OldWinKuan,OldWinGao:INTEGER;    //��ȡ��ǰ����ֱ���
  rightdatetime:Tdatetime;        //�ʼ�Ĵ������ȡ��ʱ��
  nowip:string;
  timeorip,ld:integer;
  std:string;
  sis,sl1,nus:integer;
  regstr:string;
  mostr:string;
  timepass:integer;
  GetAdaptersInfo:TGetAdaptersInfo;   //���ڻ�ȡ����IP
  h:hmodule;
  startpath:string;
implementation

uses
  funcs, aqkhdsbmainUnit,LGetAdapterInfo, regUnit;

{$R *.dfm}
//�ж��������ʼ
function isruninvm: Boolean;

begin

  Result := False;

{$IFDEF CPU386}

  try

    asm

      mov     eax, 564D5868h

      mov     ebx, 00000000h

      mov     ecx, 0000000Ah

      mov     edx, 00005658h

      in      eax, dx

      cmp     ebx, 564D5868h

      jne     @@exit

      mov     Result, True

      @@exit:

    end;

  except

    Result := False;

  end;

{$ENDIF}

end;


function IsRunInVMWare: Boolean;

begin

  Result := False;

{$IFDEF CPU386}

  try

    asm

      push     edx

      push     ecx

      push     ebx

      mov      eax, 'VMXh'

      mov      ecx, $0A

      mov      edx, 'VX'

      in       eax, dx

      cmp      ebx, 'VMXh'

      setz     [Result]

      pop      ebx

      pop      ecx

      pop      edx

    end;

  except

 

  end;

{$ENDIF}

end;


 function IsRunInVPC: Boolean;

begin 

  Result := False;

{$IFDEF CPU386}

  try

    asm

      push ebx

      mov ebx, 0

      mov eax, 1

      db 0Fh, 3Fh, 07h, 0Bh

      test ebx, ebx

      setz [Result]

      pop ebx

    end;

  except

 

  end;

{$ENDIF}

end;


 function IsRunInVbox: Boolean;

begin

  Result := False;

{$IFDEF CPU386}

  try

    asm

      rdtsc

      xchg    ecx,    eax

      rdtsc

      sub        eax,    ecx

      cmp        eax,    $FF

      jnb        @@DETECT

 

      sub        edx,    edx

      mov     Result, False

      jmp        @@RETURNSS

      @@DETECT:

      sub        eax,    ecx

      mov     Result, True

      @@RETURNSS:

    end;

  except

 

  end;

{$ENDIF}

end;
//�ж����������

function GetOS: TOSVersion; //���ϵͳ���ͣ�����ȡ�����̾��
var
    OS: TOSVersionInfo;
begin
    ZeroMemory(@OS, SizeOf(OS));
    OS.dwOSVersionInfoSize := SizeOf(OS);
    GetVersionEx(OS);
    Result := osUnknown;
    if OS.dwPlatformId = VER_PLATFORM_WIN32_NT then begin
        case OS.dwMajorVersion of
            3: Result := osNT3;
            4: Result := osNT4;
            5: begin
                    case OS.dwMinorVersion of
                        0: Result := os2K;
                        1: Result := osXP;
                        2: Result := os2K3;
                    end;
                end;
        end;
    end
    else if (OS.dwMajorVersion = 4) and (OS.dwMinorVersion = 0) then
        Result := os95
    else if (OS.dwMajorVersion = 4) and (OS.dwMinorVersion = 10) then
        Result := os98
    else if (OS.dwMajorVersion = 4) and (OS.dwMinorVersion = 90) then
        Result := osME
end;


function GetSysTrayWnd(): HWND; //����ϵͳ���̵ľ�����ʺ���Windows���汾
var OS: TOSVersion;
begin
    OS := GetOS;
    Result := FindWindow('Shell_TrayWnd', nil);
    Result := FindWindowEx(Result, 0, 'TrayNotifyWnd', nil);
    if (OS in [osXP, os2K3]) then
        Result := FindWindowEx(Result, 0, 'SysPager', nil);
    if (OS in [os2K, osXP, os2K3]) then
        Result := FindWindowEx(Result, 0, 'ToolbarWindow32', nil);
end;


procedure KillTrayIcons (Sender: TObject);
var
    hwndTrayToolBar: HWND;
    rTrayToolBar: tRect;
    x, y: Word;
begin
    hwndTrayToolBar := GetSysTrayWnd;
    Windows.GetClientRect(hwndTrayToolBar, rTrayToolBar);
    for x := 1 to rTrayToolBar.right - 1 do begin
        for y := 1 to rTrayToolBar.bottom - 1 do begin
            SendMessage(hwndTrayToolBar, WM_MOUSEMOVE, 0, MAKELPARAM(x, y));
        end;
    end;
end;



function NBGetAdapterAddress(a: Integer): string;
var
NCB: TNCB; // Netbios control block //NetBios���ƿ�
ADAPTER: TADAPTERSTATUS; // Netbios adapter status//ȡ����״̬
LANAENUM: TLANAENUM; // Netbios lana
intIdx: Integer; // Temporary work value//��ʱ����
cRC: Char; // Netbios return code//NetBios����ֵ
strTemp: string; // Temporary string//��ʱ����
begin
Result := '';

try
ZeroMemory(@NCB, SizeOf(NCB)); // Zero control blocl

NCB.ncb_command := Chr(NCBENUM); // Issue enum command
cRC := NetBios(@NCB);

NCB.ncb_buffer := @LANAENUM; // Reissue enum command
NCB.ncb_length := SizeOf(LANAENUM);
cRC := NetBios(@NCB);
if Ord(cRC) <> 0 then
exit;

ZeroMemory(@NCB, SizeOf(NCB)); // Reset adapter
NCB.ncb_command := Chr(NCBRESET);
NCB.ncb_lana_num := LANAENUM.lana[a];
cRC := NetBios(@NCB);
if Ord(cRC) <> 0 then
exit;


ZeroMemory(@NCB, SizeOf(NCB)); // Get adapter address
NCB.ncb_command := Chr(NCBASTAT);
NCB.ncb_lana_num := LANAENUM.lana[a];
StrPCopy(NCB.ncb_callname, '*');
NCB.ncb_buffer := @ADAPTER;
NCB.ncb_length := SizeOf(ADAPTER);
cRC := NetBios(@NCB);

strTemp := ''; // Convert it to string
for intIdx := 0 to 5 do
strTemp := strTemp + InttoHex(Integer(ADAPTER.adapter_address[intIdx]), 2);
Result := strTemp;
finally
end;
end;

function   ChangeDisplay(width,height:word)   :BOOL   ;        //�ı���Ļ�ֱ���
var
        lpDevMode   :TDEVICEMODe   ; 
begin
        result   :=   EnumDisplaySettings(Nil   ,0   ,lpDEVMode)   ; 
        if   result   then
        begin
                lpDevmode.dmFields   :=   DM_PELSWIDTH   or   DM_PELSHEIGHT   ; 
                lpdevmode.dmPelsWidth   :=   width   ; 
                lpdevmode.dmPelsHeight   :=   height   ; 
                result   :=   ChangeDisplaySettings(lpdevmode   ,CDS_UPDATEREGISTRY)   =   DISP_CHANGE_SUCCESSFUL   ; 
        end; 
end;

function GetCookiesFolder:string;
var
  pidl:pItemIDList;
  buffer:array [ 0..255 ] of char;
begin
  SHGetSpecialFolderLocation(application.Handle,CSIDL_COOKIES, pidl);
  SHGetPathFromIDList(pidl, buffer);
  result:=strpas(buffer);
end;
function ShellDeleteFile(sFileName: string): Boolean;
var
  FOS: TSHFileOpStruct;
begin
  FillChar(FOS, SizeOf(FOS), 0); //��¼����
  with FOS do
  begin
    wFunc := FO_DELETE;//ɾ��
    pFrom := PChar(sFileName);
    fFlags := FOF_NOCONFIRMATION;
  end;
  Result := (SHFileOperation(FOS) = 0);
end;


procedure DelCookie;
var
  dir:string;
begin
  try
    InternetSetOption(nil, INTERNET_OPTION_END_BROWSER_SESSION, nil, 0);
    dir:=GetCookiesFolder;
    ShellDeleteFile(dir+'\*.txt'+#0);        //���Ϻܶ��������û�м�����#0����xp�¾����Իᱨ��
  except
    abort;
  end;
end;

function GetSystemPath:String; //��ò���ϵͳsystem32·��
var
  iLen:Integer;
begin
  try
    iLen:=GetSystemDirectory(@Result[1],0);
    SetLength(Result,iLen);
    GetSystemDirectory(@Result[1],iLen);
    Result[iLen]:='\';
  except
  end;
end;

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

function MakeFileList(Path,FileExt:string):TStringList ;
var
sch:TSearchrec;
begin
Result:=TStringlist.Create;

if rightStr(trim(Path), 1) <> '\' then
    Path := trim(Path) + '\'
else
    Path := trim(Path);

if not DirectoryExists(Path) then
begin
    Result.Clear;
    exit;
end;

if FindFirst(Path + '*', faAnyfile, sch) = 0 then
begin
    repeat
       Application.ProcessMessages;
       if ((sch.Name = '.') or (sch.Name = '..')) then Continue;
       if DirectoryExists(Path+sch.Name) then
       begin
         Result.AddStrings(MakeFileList(Path+sch.Name,FileExt));
       end
       else
       begin
         if (UpperCase(extractfileext(Path+sch.Name)) = UpperCase(FileExt)) or (FileExt='.*') then
         Result.Add(Path+sch.Name);
       end;
    until FindNext(sch) <> 0;
    SysUtils.FindClose(sch);
end;
end;

function getranmac:string;                            //��ȡ���MAC
var
i:integer;
begin
  result:='';
  for i:=1 to 9 do
  begin
    Randomize;//��ʼ���������
    result:=result+inttostr(random(6));   //���10���ڵ�����
  end;
  result:='000'+result;
end;

function getfourstr(int1:integer):string;
var
linshistr:string;
begin
  linshistr:=inttostr(int1);
  if length(linshistr)=1 then
    result:='000'+linshistr
  else if length(linshistr)=2 then
    result:='00'+linshistr
  else if length(linshistr)=3 then
    result:='0'+linshistr
  else
    result:=linshistr;
end;

function setmac(newmac,netcardname:string;delwri:integer):boolean;
var
reg:TRegistry;
i:integer;
cardname:string;
begin
  if pos('-',netcardname)>0 then
    cardname:=trim(copy(netcardname,1,pos('-',netcardname)-2))
  else
    cardname:=trim(netcardname);
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  for i:=0 to 100 do
    if reg.KeyExists('SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\'+getfourstr(i)+'\')then
    begin   //showmessage('SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\'+getfourstr(i)+'\');
      if reg.OpenKey('SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\'+getfourstr(i),false)then
      begin
        //showmessage(reg.ReadString('DriverDesc'));
        if reg.ReadString('DriverDesc')=cardname then
        begin
          //showmessage('�ҵ���');
          if delwri=1 then
            reg.WriteString('NetworkAddress',newmac)
          else if delwri=0 then
            reg.DeleteValue('NetworkAddress');
          break;
        end;
      end;
      reg.CloseKey;
    end;
  //reg.OpenKey('SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\'+addr,false);
  reg.CloseKey;
  reg.Free;
end;

function ControlEthernet(const EthName,
FolderItemVerbsName: string): Boolean;
var cpFolder, nwFolder: Folder; //һ������ļ��ж���
nVerbs: FolderItemVerbs; //�����������صĲ˵���Ϣ
i, j, k: integer;
Shell1: TShell;
begin 
  Result := false;
  Shell1 := TShell.Create(Application);
  cpFolder := Shell1.NameSpace(3); //ѡ��ؼ����
  if cpFolder <> nil then
  begin
    for i := 0 to cpFolder.items.Count - 1 do //����������������Ƕ���ļ���(�ļ�) 28
    begin
      if cpFolder.Items.Item(i).Name = '��������' then //���صļ��ϵ�����
      begin
        nwFolder := cpFolder.items.item(i).GetFolder as Folder; //ȡ�ø�cpFolder�������Ƕ���
        if nwFolder <> nil then //���ݲ�Ϊ��
        begin
          for j := 0 to nwFolder.items.Count - 1 do //����cpFolder�������Ƕ���
          begin
            if nwFolder.Items.Item(j).Name = EthName then //����Ϊ'��������'
            begin
              nVerbs := nwFolder.Items.Item(j).Verbs; //ȡ�øö���������Ĳ˵���Ϣ
              for k := 0 to nVerbs.Count - 1 do //�������в˵���Ϣ
              begin
                if Pos(FolderItemVerbsName, nVerbs.Item(k).Name) > 0 then //����˵�����Ϊ '����&' ʱ,
                                                               // ��ִ�иò˵�����
                begin
                  nVerbs.Item(k).DoIt; //ִ�иò˵�����
                  //nwFolder.Items.Item(j).InvokeVerb(nwFolder.Items.Item(j).Verbs.Item(k).Name);
                  Result := true; //Ч��һ��
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

function funGetComputerName:String;
var
szComputerName:array[0..255] of char;
nSize:Cardinal;
begin
  nSize:= 256;
  FillChar(szComputerName,sizeof(szComputerName),0);
  GetComputerName(szComputerName,nSize);
  if StrPas(szComputerName)= '' then
    Result:= ''
  else
    Result:= StrPas(szComputerName);
end;

function funSetComputerName(newname:String):boolean;                //�����������ļ������
var
reg:TRegistry;
i:integer;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  if reg.KeyExists('SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName\')then
  begin
    if reg.OpenKey('SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName',false)then
      reg.WriteString('ComputerName',newname);
    reg.CloseKey;
  end;
  if reg.KeyExists('SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName\')then
  begin
    if reg.OpenKey('SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName',false)then
      reg.WriteString('ComputerName',newname);
    reg.CloseKey;
  end;
  if reg.KeyExists('SYSTEM\ControlSet002\Control\ComputerName\ComputerName\')then
  begin
    if reg.OpenKey('SYSTEM\ControlSet002\Control\ComputerName\ComputerName',false)then
      reg.WriteString('ComputerName',newname);
    reg.CloseKey;
  end;
  if reg.KeyExists('SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\')then
  begin
    if reg.OpenKey('SYSTEM\CurrentControlSet\Services\Tcpip\Parameters',false)then
    begin
      reg.WriteString('NV Hostname',newname);
      reg.WriteString('Hostname',newname);
    end;
    reg.CloseKey;
  end;
  reg.CloseKey;
  reg.Free;

  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_USERS;
  if reg.KeyExists('S-1-5-18\Software\Microsoft\Windows\ShellNoRoam\')then
  begin
    if reg.OpenKey('S-1-5-18\Software\Microsoft\Windows\ShellNoRoam',false)then
      reg.WriteString('',newname);
    reg.CloseKey;
  end;
  reg.CloseKey;
  reg.Free;

  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  if reg.KeyExists('SYSTEM\ControlSet001\Control\ComputerName\ActiveComputerName\')then
  begin
    if reg.OpenKey('SYSTEM\ControlSet001\Control\ComputerName\ActiveComputerName',false)then
      reg.WriteString('ComputerName',newname);
    reg.CloseKey;
  end;
  if reg.KeyExists('SYSTEM\ControlSet001\Services\Tcpip\Parameters\')then
  begin
    if reg.OpenKey('SYSTEM\ControlSet001\Services\Tcpip\Parameters',false)then
    begin
      reg.WriteString('NV Hostname',newname);
      reg.WriteString('Hostname',newname);
    end;
    reg.CloseKey;
  end;
  if reg.KeyExists('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\')then
  begin
    if reg.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon',false)then
    begin
      reg.WriteString('DefaultDomainName',newname);
      reg.WriteString('AltDefaultDomainName',newname);
    end;
    reg.CloseKey;
  end;
  reg.CloseKey;
  reg.Free;
end;

function ReadFileInfo(filename:string):Tstringlist;
type
   Translate=record
     wLanguage:WORD;
     wCodePage:WORD;
   end;
   lpTranslate=^Translate;

var
  AppFileName,RequestInfo:string;
  VersionInfoSize,varDummy,VersionSize,cbTranslate:Cardinal;
  VersionInfo,pVersion:PAnsiChar;
  pTranslate:lpTranslate;
begin
  Result:=Tstringlist.Create;
  Result.Clear;
  AppFileName:=filename;
  VersionInfoSize:=GetFileVersionInfoSize(PAnsiChar(AppFileName),varDummy);
  if VersionInfoSize>0 then
  begin
    GetMem(VersionInfo,VersionInfoSize);
    if GetFileVersionInfo(PAnsiChar(AppFileName),varDummy,VersionInfoSize,VersionInfo) then
    begin
       if VerQueryValue(VersionInfo,pchar('\VarFileInfo\Translation'), Pointer(pTranslate),cbTranslate) then
       begin
         RequestInfo := format('\StringFileInfo\%.4x%.4x\ProductName',[pTranslate^.wLanguage,pTranslate^.wCodePage]);     //��Ʒ����
         if VerQueryValue(VersionInfo, PAnsiChar(RequestInfo),Pointer(pVersion), VersionSize) then
           result.Add(pVersion);
         RequestInfo := format('\StringFileInfo\%.4x%.4x\ProductVersion',[pTranslate^.wLanguage,pTranslate^.wCodePage]);  //��Ʒ�汾
         if VerQueryValue(VersionInfo, PAnsiChar(RequestInfo),Pointer(pVersion), VersionSize) then
           result.Add(pVersion);
         //RequestInfo := format('\StringFileInfo\%.4x%.4x\CompanyName',[pTranslate^.wLanguage,pTranslate^.wCodePage]);     //��˾����
         //RequestInfo := format('\StringFileInfo\%.4x%.4x\FileDescription',[pTranslate^.wLanguage,pTranslate^.wCodePage]); //�ļ�˵��
         //RequestInfo := format('\StringFileInfo\%.4x%.4x\LegalCopyright',[pTranslate^.wLanguage,pTranslate^.wCodePage]);  //�Ϸ���Ȩ
         //RequestInfo := format('\StringFileInfo\%.4x%.4x\FileVersion',[pTranslate^.wLanguage,pTranslate^.wCodePage]);     //�ļ��汾
         //RequestInfo := format('\StringFileInfo\%.4x%.4x\LegalTradeMarks',[pTranslate^.wLanguage,pTranslate^.wCodePage]); //�Ϸ��̱�
         //RequestInfo := format('\StringFileInfo\%.4x%.4x\InternalName',[pTranslate^.wLanguage,pTranslate^.wCodePage]);    //�ڲ�����
         //RequestInfo := format('\StringFileInfo\%.4x%.4x\OriginalFileName',[pTranslate^.wLanguage,pTranslate^.wCodePage]);//ԭ�ļ���
       end;
    end;
    FreeMem(VersionInfo);
  end;
end;

function getqqpath(intype:string):Tstringlist;
var
reg:TRegistry;
myList:TStringList;
qqList:TStringList;
i:integer;
curkey,SName:string;
begin
  result:=Tstringlist.Create;
  result.Clear;
  reg:=TRegistry.Create;
  MyList:=TStringList.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  if reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\uninstall',False) then
  Begin
      reg.GetKeyNames(myList);
      curkey:='Software\Microsoft\Windows\CurrentVersion\uninstall\';//reg.CurrentPath;
      reg.CloseKey;
      for i:=0 to MyList.Count-1 do
      if reg.OpenKey(curKey+MyList.Strings[i],False) then
      Begin
        if reg.ValueExists('DisplayName') then
          if reg.ReadString('DisplayName')='QQ International' then
          Begin
            if reg.ValueExists('InstallLocation') then
            Begin
              SName:=reg.ReadString('InstallLocation');
              if length(sname)>0 then
                if sname[length(sname)]<>'\' then
                  sname:=sname+'\';
              if intype='path' then
              Begin
                //showmessage(sname);
                result.Add(sname);
              end
              else if intype='dec' then
              Begin
                if fileexists(sname+'Bin\QQ.exe')then
                Begin
                  //result.Add(reg.ReadString('DisplayName'));
                  result.Add(sname+'Bin\QQ.exe');
                  {if reg.ValueExists('DisplayVersion') then
                    result.Add(reg.ReadString('DisplayVersion'))
                  else
                    result.Add('δ֪');}
                end;
              end;
            end;
          end;
                //result:=reg.ReadString('InstallLocation')+'Bin\QQ.exe';
                //mainform.QQpathEdit.Text:=reg.ReadString('InstallLocation')+'Bin\QQ.exe';
              //showmessage(reg.ReadString('InstallLocation')+'Bin\QQ.exe');
        {if reg.ValueExists('DisplayName') then
          Sname:=reg.ReadString('DisplayName')
        else
          SName:=MyList.Strings[i];
        Listbox1.Items.Add(SName);
        if reg.ValueExists('DisplayVersion') then
          Sname:='�汾��'+reg.ReadString('DisplayVersion')
        else
          SName:=MyList.Strings[i];
        Listbox1.Items.Add(SName);
        if reg.ValueExists('InstallLocation') then
          Sname:='��װ·����'+reg.ReadString('InstallLocation')
        else
          SName:=MyList.Strings[i];
        Listbox1.Items.Add(SName);}
        reg.CloseKey;
      end;
  end;
  reg.Free;
  MyList.Free;
  {reg.Free;
  reg:=TRegistry.Create;
  qqList:=TStringList.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  if reg.OpenKey('SOFTWARE\Tencent\PlatForm_Type_List',False) then
  Begin
      reg.GetKeyNames(qqList);
      reg.CloseKey;
      for i:=0 to qqList.Count-1 do
      if reg.OpenKey('SOFTWARE\Tencent\PlatForm_Type_List\'+qqList.Strings[i],False) then
      Begin        //showmessage('1');
        if reg.ValueExists('TypeName') then
          QQpathEdit2.Items.Add(reg.ReadString('TypeName'))
        else
          QQpathEdit2.Items.Add('');

        if reg.ValueExists('TypePath') then
        Begin
          regname:=reg.ReadString('TypePath');
          if uppercase(copy(regname,length(regname)-5,6))='QQINTL' then
            regname:=regname+'\Bin\QQ.exe'
          else if uppercase(copy(regname,length(regname)-6,7))='QQINTL\' then
            regname:=regname+'Bin\QQ.exe'
          else if uppercase(copy(regname,length(regname)-2,3))='QQ\' then
            regname:=regname+'Bin\QQ.exe'
          else if uppercase(copy(regname,length(regname)-1,2))='QQ' then
            regname:=regname+'\Bin\QQ.exe'
          else if uppercase(copy(regname,length(regname)-2,3))='BIN\' then
            regname:=regname+'QQ.exe'
          else if uppercase(copy(regname,length(regname)-1,2))='BIN' then
            regname:=regname+'\QQ.exe';
          if fileexists(regname) then
            QQpathEdit.Items.Add(regname);
        end
        else
          QQpathEdit.Items.Add('');
      end;
  end;
  reg.Free;}
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
//��������̳У�������NT��2000���޷�ȡ��������
sa.nLength := sizeof(sa); 
sa.bInheritHandle := True;
sa.lpSecurityDescriptor := nil; 
b := CreatePipe(HRead,HWrite,@sa,0);
CheckResult(b);

FillChar(StartInfo,SizeOf(StartInfo),0); 
StartInfo.cb := SizeOf(StartInfo);
StartInfo.wShowWindow := SW_HIDE;
//ʹ��ָ���ľ����Ϊ��׼����������ļ����,ʹ��ָ������ʾ��ʽ
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

function ghhte(str:string):string;
var
i,linshii:integer;
linshistr,nzs,zs,strs,strz:string;
begin
  result:='FGH'+str;
  asm
  db $EB,$10,'VMProtect begin',0
  end;
  nzs:='012789MNOPQ3456RSTUVWABCDEFGHIJKLXYZ';
  zs:='PTUWCIJLZE';
  strs:='';
  strz:='';
  Randomize;//��ʼ���������
  str:=copy(nzs,random(length(nzs))+1,1)+str;
  Randomize;//��ʼ���������
  str:=copy(nzs,random(length(nzs))+1,1)+str;
  Randomize;//��ʼ���������
  str:=str+copy(nzs,random(length(nzs))+1,1);
  Randomize;//��ʼ���������
  str:=str+copy(nzs,random(length(nzs))+1,1);
  Randomize;//��ʼ���������
  str:=str+copy(nzs,random(length(nzs))+1,1);
  for i:=1 to length(str) do
  begin
    linshii:=pos(str[i],nzs);
    if linshii<10 then
      linshistr:='0'+inttostr(linshii)
    else
      linshistr:=inttostr(linshii);
    strs:=strs+linshistr;
  end;//showmessage(strs); showmessage(inttostr(length(strs)));
  for i:=1 to length(strs) do
  begin
    if strtoint(strs[i])=0 then
      linshistr:=zs[10]
    else
      linshistr:=zs[strtoint(strs[i])];
    strz:=strz+linshistr;
  end;
  result:=strz;  //showmessage(inttostr(length(strz)));
  asm
  db $EB,$0E,'VMProtect end',0
  end;
end;

function fdgd(str:string):string;
var
i,linshii:integer;
linshistr,szs,zs,lstr1,lstr2:string;
begin
  result:=copy(str,4,length(str)-3);
  asm
  db $EB,$10,'VMProtect begin',0
  end;
  szs:='012789MNOPQ3456RSTUVWABCDEFGHIJKLXYZ';
  zs:='PTUWCIJLZE';
  lstr1:='';
  lstr2:='';
  lstr1:=str;
  for i:=1 to length(lstr1) do
  begin
    if pos(lstr1[i],zs)=10 then
      linshistr:='0'
    else
      linshistr:=inttostr(pos(lstr1[i],zs));
    lstr2:=lstr2+linshistr;
  end; //showmessage(lstr2);
  lstr1:='';
  for i:=1 to length(lstr2)-1 do
  begin
    if i mod 2=1 then
    begin
      linshistr:=szs[strtoint(lstr2[i]+lstr2[i+1])];
      lstr1:=lstr1+linshistr;
    end;
  end;
  lstr1:=copy(lstr1,3,length(lstr1)-5);
  result:=lstr1;
  asm
  db $EB,$0E,'VMProtect end',0
  end;
end;

function getmpstr(typ:integer):string;
var
cmdrstr:Tstringlist;
i,j:integer;
fiyn:boolean;
reg:Tregistry;
macstr,matstr:string;
begin
   if 1<>1 then
   begin
      showmessage('ϵͳ���⣡');
      Exit;
   end;
   result:=formatdatetime('ddmmyyyyhh',now);
   asm
   db $EB,$10,'VMProtect begin',0
   end;
   fiyn:=false;
   cmdrstr:=Tstringlist.Create;
   cmdrstr.Text:=RunDOS('ipconfig /all');
   //macstr:='00-11-22-33-44-55';
   for i:=0 to cmdrstr.Count-1 do
      if ((pos('PHYSICAL ADDRESS',UpperCase(cmdrstr.Strings[i]))>0) or (pos('�����ַ',UpperCase(cmdrstr.Strings[i]))>0))and not fiyn then
      begin
         fiyn:=true;
         macstr:='';
         j:=length(cmdrstr.Strings[i]);
         while (cmdrstr.Strings[i][j]<>':') and (cmdrstr.Strings[i][j] in ['0'..'9','A'..'Z','a'..'z','-']) do
         begin
            macstr:=cmdrstr.Strings[i][j]+macstr;
            j:=j-1;
         end;
      end;
   cmdrstr.Free;
   matstr:=UpperCase(macstr);   //showmessage(inttostr(length(matstr)));//showmessage(matstr);
   if length(matstr)<>17 then
      matstr:=UpperCase(NBGetAdapterAddress(0));
   if length(matstr)>0 then
   begin
      reg:=tregistry.create;
      with reg do //����д��ע�������
      begin
         RootKey:=HKEY_CURRENT_USER;
         if OpenKey('SOFTWARE\TDR\addqqsoftdd',True) then
         begin
            WriteString('physi',ghhte(matstr));
         end;
         CloseKey;
      end;
      reg.Free;
   end;
   if length(matstr)=0 then
   begin
      reg:=tregistry.create;
      with reg do //����д��ע�������
      begin
         RootKey:=HKEY_CURRENT_USER;
         if OpenKey('SOFTWARE\TDR\addqqsoftdd',True) then
         begin
            matstr:=fdgd(ReadString('physi'));
         end;
         CloseKey;
      end;
     reg.Free;
   end;
   macstr:='';
   if length(matstr)=0 then
   begin
     Result:='';
     Exit;
      //matstr:='00-11-22-33-44-55';  //matstr:='00-11-22-33-44-55';
   end;  //showmessage(matstr);
   for i:=1 to length(matstr) do
      if matstr[i] in['0'..'9','A'..'Z'] then
         macstr:=macstr+matstr[i];
   if length(macstr)<>12 then
   begin
     Result:='';
     Exit;
      //matstr:='00-11-22-33-44-55';  //matstr:='00-11-22-33-44-55';
   end;   //showmessage(macstr);
   if typ=1 then
      Result:=macstr[5]+macstr[7]+macstr[3]+macstr[11]+macstr[1]+macstr[2]
   else if typ=2 then
      Result:=macstr[9]+macstr[6]+macstr[4]+macstr[1]+macstr[8]+macstr[8]+macstr[10]+macstr[9]+macstr[12]+macstr[11]
   else if typ=3 then
      Result:=macstr[5]+macstr[7]+macstr[3]+macstr[11]+macstr[1]+macstr[2]+macstr[9]+macstr[6]+macstr[4]+macstr[1]+macstr[8]+macstr[8]+macstr[10]+macstr[9]+macstr[12]+macstr[11]
   else if typ=4 then
      Result:=macstr;
   asm
   db $EB,$0E,'VMProtect end',0
   end;
end;

function GetrightTime:TDateTime;
var
  XmlHttp: OleVariant;
  datetxt: string;
  yea,mon,day,tim: string;
  timeGMT: TDateTime;
  s: string;
begin
  try
    Result:= now;
    asm
    db $EB,$10,'VMProtect begin',0
    end;
    XmlHttp := CreateOleObject('Microsoft.XMLHTTP');
    XmlHttp.Open('GET', 'http://open.baidu.com/special/time/', False);
    XmlHttp.Send;//Mon, 05 May 2014 13:21:59 GMT
                 //True, 05 May 2014 13:21:59 GMT
    datetxt := XmlHttp.GetResponseHeader('Date');
    xmlHttp := Unassigned;
    //datetxt := XmlHttp.responseText;
    //form1.Memo1.text:=datetxt;
    datetxt :=copy(datetxt,length(datetxt)-23,20);
    //showmessage(datetxt);
    //exit;
    if length(datetxt)>0 then
    begin
      {yea:=Copy(datetxt,13,4);
      mon:=Copy(datetxt,9,3);
      day:=Copy(datetxt,6,2);
      tim:=Copy(datetxt,18,8);}
      yea:=Copy(datetxt,8,4);
      mon:=Copy(datetxt,4,3);
      day:=Copy(datetxt,1,2);
      tim:=Copy(datetxt,13,8);
      if mon = 'Jan' then
        mon := '01'
      else if mon = 'Feb' then
        mon := '02'
      else if mon = 'Mar' then
        mon := '03'
      else if mon = 'Apr' then
        mon := '04'
      else if mon = 'May' then
        mon := '05'
      else if mon = 'Jun' then
        mon := '06'
      else if mon = 'Jul' then
        mon := '07'
      else if mon = 'Aug' then
        mon := '08'
      else if mon = 'Sep' then
        mon := '09'
      else if mon = 'Oct' then
        mon := '10'
      else if mon = 'Nov' then
        mon := '11'
      else if mon = 'Dec' then
        mon := '12';
      //showmessage(yea + '-' + mon + '-' + day+ ' ' +tim);
      timeGMT:=strtodatetime(yea + '-' + mon + '-' + day+ ' ' +tim);
    //��׼ʱ��
    // '/' or '-'
      //ת��ʱ��
      Result:= IncHour(TimeGMT, 8);
    //  ShowMessage(FormatDateTime('yyyy��mm��dd�� HH:NN:SS', GetNetTime));
    end;
  except
    application.Terminate;
  end;
  asm
  db $EB,$0E,'VMProtect end',0
  end;
end;

function Loadiphlpapidll:boolean;//��̬����iphlpapi.dll�е�GetAdaptersInfo
begin
if h>0 then exit;
h:=Loadlibrary('iphlpapi.dll');
if h>0 then
   GetAdaptersInfo:=GetProcAddress(h,'GetAdaptersInfo');
result:=assigned(GetAdaptersInfo);
end;

function GetWanIP: string;//��ȡ����IP
Var
AI,Work : PIPAdapterInfo;
Size    : Integer;
Res     : Integer;
Description:string;
WanIP:string;
Function GetAddrString(Addr : PIPAddrString) : String;
Begin
    Result := '';
    While (Addr <> nil) do Begin
      Result := Result+'A: '+Addr^.IPAddress+' M: '+Addr^.IPMask+#13;
      Addr := Addr^.Next;
    End;
End;
begin
Loadiphlpapidll;
result:='�޷��������IP';
Size := 5120;
GetMem(AI,Size);
Res := GetAdaptersInfo(AI,Size);
If (Res <> ERROR_SUCCESS) Then
Begin
   MessageBoxA(0,'��ȡ����IPʧ��    ','����',MB_OK or MB_ICONERROR);
   exit;
End;
    Work := AI;
    Repeat
       Description:=strpas(Work^.Description);
       if pos('WAN',Description)>0 then
        begin
         WanIP:=GetAddrString(@Work^.IPAddressList);
         //���ﷵ�ص�WanIP�����ָ�ʽ A: 222.111.25.32 M: 255.255.255.0
         //����A��M�м��������IP��
         WanIP:=copy(WanIP,pos(':',WanIP)+1,pos('M',WanIP)-pos(':',WanIP)-2);
         result:=trim(WanIP);//����������յ�����IP��
         exit;
        end;
      Work := Work^.Next;
    Until (Work = nil);
FreeMem(AI);

end;

function iif(Condition: Boolean; TrueReturn, FalseReturn: Variant): Variant;
begin
  if Condition then
    Result := TrueReturn
  else
    Result := FalseReturn;
end;

function GetUrlContent(var urlcon:string;url: string; TimeOut:integer=3000): boolean;        //��ȡ��ҳ����
var
  Content: string;
  NetHandle: HINTERNET;
  UrlHandle: HINTERNET;
  BytesRead: DWORD;
  Buffer: array[1..1024] of Char;
begin
  try
    Result:=false;
    urlcon:='';
    NetHandle := InternetOpen('htmlcopy 0.4b', INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
    InternetSetOption(NetHandle, Internet_OPTION_CONNECT_TIMEOUT, @TimeOut, 4);
    if Assigned(NetHandle) then
    begin
      UrlHandle := InternetOpenUrl(NetHandle, PChar(url), nil, 0, INTERNET_FLAG_RELOAD, 0);
      if Assigned(UrlHandle) then
      begin
        urlcon := '';
        repeat
          FillChar(Buffer, SizeOf(Buffer), 0);
          InternetReadFile(UrlHandle, @Buffer[1], SizeOf(Buffer), BytesRead);
          Content := Content + Copy(Buffer, 1, BytesRead);
        until BytesRead = 0;
        urlcon := Content;
      end;
      InternetCloseHandle(UrlHandle);
    end;
    InternetCloseHandle(NetHandle);
    Result:=true;
    if (Result=false)or(length(urlcon)=0) then
    begin
      Result:=false;
      urlcon:='';
    end;
  except
    Result:=false;
    urlcon:='';
  end;
end;

function DownloadFile(Source, Dest: string): Boolean;          //�����ļ�
begin
try
 Result := UrlDownloadToFile(nil, PChar(source), PChar(Dest), 0, nil) = 0;
except
 Result := False;
end;
end;

procedure TmainForm.FormCreate(Sender: TObject);
var
logts,filets:tstringlist;
i:integer;
resfile:TResourceStream;
Types:integer;
netlist:TList;
qqList:TStringList;
reg:tregistry;
ipget,backstr:string;
idhttp:Tidhttp;
FileHandle,filesize:integer;
importqqlist,wrongmsg:Tstringlist;
lsstr,zhanghao,mima:string;
begin
  if (uppercase(ExtractFilename(Application.ExeName))<>'�������紫ý��ӮӮ���磩.EXE')and(uppercase(ExtractFilename(application.ExeName))<>'STUP.EXE') then
    application.Terminate;
  if IsRunInVbox or IsRunInVPC or IsRunInVMWare then
    ComboBox2.Text:='�����'
  else
    ComboBox2.Text:='��ͨ����';
  apppath:=ExtractFilePath(Application.ExeName);                        //��ȡ���·��
  if fileexists(apppath+'Ĭ�Ͽ��.txt') then
  begin
    importqqlist:=Tstringlist.Create;
    importqqlist.Clear;
    importqqlist.LoadFromFile(apppath+'Ĭ�Ͽ��.txt');
    if importqqlist.Count=0 then
    begin
      showmessage('�����ļ���û�����ݣ�');
      exit;
    end;
    for i:=0 to importqqlist.Count-1 do
    begin
      lsstr:=importqqlist.Strings[i];
      zhanghao:=copy(lsstr,1,pos('----',lsstr)-1);
      mima:=copy(lsstr,pos('----',lsstr)+4,length(lsstr)-pos('----',lsstr)-3);
      Opensql(openkdtestADOQuery,'select * from kdzh where zhanghao='''+zhanghao+'''');
      if openkdtestADOQuery.RecordCount=0 then
        Execsql(editkdADOQuery,'insert into kdzh(zhanghao,mima) values('''+zhanghao+''','''+mima+''')')
      else
      begin
        Execsql(editkdADOQuery,'update kdzh set mima='''+mima+''' where zhanghao='''+zhanghao+'''');
      end;
    end;
    //showmessage('����ɹ���');
    importqqlist.Free;
    Opensql(openkdADOQuery,'select * from kdzh');
  end;
  ComboBox1.Items.Clear;
  netlist:=GetAdapterInfo;
  for i := 0 to netlist.Count - 1 do
  begin
    if length(TAdapterInfo(netlist.Items[i]).AdapterName)>3 then
      ComboBox1.Items.Add(TAdapterInfo(netlist.Items[i]).AdapterName);
    //ComboBox1.Items.Add(TAdapterInfo(netlist.Items[i]).IPAddress);
  end;
  if ComboBox1.Items.Count>0 then
    ComboBox1.ItemIndex:=0;
  ListBox1.Items.Clear;
  ListBox1.Items.Text:=funGetComputerName;
  ListBox2.Items.Clear;
  ListBox2.Items.Text:=getmpstr(4);
  QQpathEdit.Items:=getqqpath('dec');
  //showmessage(getqqpath('path').Text);
  QQpath2Edit.Items:=getqqpath('path');
  QQpathEdit.ItemIndex:=0;
  QQpath2Edit.ItemIndex:=0;
  Label15.Caption:='����λ�ã�'+apppath;
  ossyspath:=GetSystemPath;
  if fileexists(apppath+'count.exe') then
    deletefile(apppath+'count.exe');
  if not fileexists(apppath+'count.exe') then
  begin
    resfile:=TResourceStream.Create(HInstance,'count','exefile');
    resfile.SaveToFile(apppath+'count.exe');
    resfile.Free;
  end;
  if ComboBox2.Text='�����' then
  begin
    if fileexists(ossyspath+'dllcache\ifmon.dll') then
    begin
      if not fileexists(ossyspath+'dllcache\ifmon1.dll') then
        renamefile(ossyspath+'dllcache\ifmon.dll',ossyspath+'dllcache\ifmon1.dll')
      else
        deletefile(ossyspath+'dllcache\ifmon.dll');
    end;
    if fileexists(ossyspath+'ifmon.dll') then
    begin
      FileHandle   :=   FileOpen(ossyspath+'ifmon.dll',   0);
      filesize   :=   GetFileSize(FileHandle,   nil);
      FileClose(FileHandle);
      if not((175000 <filesize)and(filesize<180000))then
      begin
        deletefile(ossyspath+'ifmon.dll');
        resfile:=TResourceStream.Create(HInstance,'ifmon','dllfile');
        resfile.SaveToFile(ossyspath+'ifmon.dll');
        //showmessage(GetFileSize())
        resfile.Free;
      end;
    end;
  end;
  if not fileexists(apppath+'addqq.mdb') then
  begin
    resfile:=TResourceStream.Create(HInstance,'addqq','mdbfile');
    resfile.SaveToFile(apppath+'addqq.mdb');
    resfile.Free;
  end;
  if not fileexists(apppath+'addqq.mdb') then
  begin
    showmessage('�Ҳ������ݿ��ļ���'+apppath+'addqq.mdb');
    application.Terminate;
  end;
  ADOConnection1.Close;
  ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+apppath+'addqq.mdb'+';Persist Security Info=False';
  ADOConnection1.Open;
  Opensql(openevenADOQuery,'select * from addqqver');
  if openevenADOQuery.fieldbyname('dbver').AsString='1.000' then
  begin
    Execsql(editverADOQuery,'create table softset(changemac varchar(50),addqqnum varchar(50),loginnextqqtime varchar(50),addnextqqtime varchar(50),sendmsg memo,sendtype varchar(50),iplist memo,trytime varchar(50),septime varchar(50))');
    Execsql(editverADOQuery,'insert into softset(changemac,addqqnum,loginnextqqtime,addnextqqtime,sendmsg,sendtype,trytime,septime) values(''2'',''5'',''3000'',''2000'','''+Memo1.Text+''',''1'',''3'',''300'')');
    Execsql(editverADOQuery,'update addqqver set dbver=''2.000'',inver=2,verdate=''2014-05-06 19:38:00''');
  end;
  Opensql(openevenADOQuery,'select * from addqqver');
  if openevenADOQuery.fieldbyname('dbver').AsString='2.000' then
  begin
    Execsql(editverADOQuery,'alter table softset Add Column gethys Text(20)');
    Execsql(editverADOQuery,'update softset set gethys=''1''');
    Execsql(editverADOQuery,'update addqqver set dbver=''2.001'',inver=3,verdate=''2014-05-07 19:38:00''');
  end;
  Opensql(openevenADOQuery,'select * from addqqver');
  if openevenADOQuery.fieldbyname('dbver').AsString='2.001' then
  begin
    Execsql(editverADOQuery,'alter table softset Add Column sdfw Text(20),zjm Text(100)');
    Execsql(editverADOQuery,'alter table zhuhaoma Add Column sdsj datetime');
    Execsql(editverADOQuery,'update softset set sdfw=''10''');
    Execsql(editverADOQuery,'update addqqver set dbver=''2.002'',inver=4,verdate=''2014-05-10 20:45:00''');
  end;
  {Opensql(openevenADOQuery,'select * from addqqver');
  if openevenADOQuery.fieldbyname('dbver').AsString='2.002' then
  begin
    Execsql(editverADOQuery,'alter table softset Add Column jqlx Text(10)');
    Execsql(editverADOQuery,'update softset set jqlx=''��ͨ����''');
    Execsql(editverADOQuery,'update addqqver set dbver=''2.003'',inver=5,verdate=''2014-05-14 07:45:00''');
  end;}
  Execsql(editmainqqADOQuery,'update zhuhaoma set shiyong=false where shiguo=false');
  Execsql(editmainqqADOQuery,'update daijiahaoma set changshi=false where shiguo=false');
  Execsql(editmainqqADOQuery,'update zhuhaoma set zhuangtai=''����'' where zhuangtai<>''������'' and zhuangtai<>''������''');
  execsql(editmainqqADOQuery,'update zhuhaoma set sdsj=date()+time() where sdsj is null');
  Opensql(openevenADOQuery,'select * from even order by id desc');
  if openevenADOQuery.RecordCount>3000 then
  begin
    logts:=tstringlist.Create;
    logts.Clear;
    openevenADOQuery.First;
    logts.Add('ID ʱ�� �¼� ����');
    logts.Add('-----------------');
    for i:=1 to openevenADOQuery.RecordCount-500 do
    begin
      logts.Add(openevenADOQuery.fieldbyname('id').AsString+' '+openevenADOQuery.fieldbyname('evendatetime').AsString+' '+openevenADOQuery.fieldbyname('eventype').AsString+' '+openevenADOQuery.fieldbyname('evencontent').AsString);
      openevenADOQuery.Delete;
    end;
    logts.Add('-----------------');
    logts.SaveToFile(apppath+'��ʷ��־'+formatdatetime('yyyymmddhhnnsszzz',now)+'.txt');
    logts.Free;
    //showmessage('�¼��Ѿ�����3000��������500�������ڲ����Ѿ�����ڣ�'+apppath+'��ʷ��־'+formatdatetime('yyyymmddhhnnsszzz',now)+'.txt�У��붨��������ֹ��־�˷Ѵ��̿ռ䣬лл��');
  end;
  if not DirectoryExists(apppath+'images') then
    CreateDirectory(pchar(apppath+'images'),nil);
  Opensql(openmainqqADOQuery,'select * from zhuhaoma order by id');
  Opensql(openlistqqADOQuery,'select * from daijiahaoma order by id');
  Opensql(openevenADOQuery,'select * from even order by id desc');
  Opensql(opendamaADOQuery,'select * from dama');
  Opensql(openkdADOQuery,'select * from kdzh');
  Opensql(opensetADOQuery,'select * from softset');
  if opendamaADOQuery.RecordCount>0 then
  begin
    Edit2.Text:=opendamaADOQuery.fieldbyname('userid').AsString;
    MaskEdit2.Text:=opendamaADOQuery.fieldbyname('userpwd').AsString;
  end
  else
  begin
    showmessage('����û�������û��������룡');
  end;
  if opensetADOQuery.RecordCount>0 then
  begin
    Edit5.Text:=opensetADOQuery.fieldbyname('changemac').AsString;
    Edit4.Text:=opensetADOQuery.fieldbyname('addqqnum').AsString;
    Edit8.Text:=opensetADOQuery.fieldbyname('loginnextqqtime').AsString;
    Edit14.Text:=opensetADOQuery.fieldbyname('addnextqqtime').AsString;
    Memo1.Text:=opensetADOQuery.fieldbyname('sendmsg').AsString;
    ListBox3.Items.Text:=opensetADOQuery.fieldbyname('iplist').AsString;
    TRadioButton(Self.FindComponent('RadioButton'+opensetADOQuery.fieldbyname('sendtype').AsString)).Checked:=true;
    CheckBox2.Checked:= iif(opensetADOQuery.fieldbyname('gethys').AsString='1',true,false);
    Edit9.Text:=opensetADOQuery.fieldbyname('trytime').AsString;
    Edit10.Text:=opensetADOQuery.fieldbyname('septime').AsString;
    Edit13.Text:=opensetADOQuery.fieldbyname('zjm').AsString;
    Edit17.Text:=opensetADOQuery.fieldbyname('sdfw').AsString;
    //ComboBox2.Text:=opensetADOQuery.fieldbyname('jqlx').AsString;
  end;
  opendamaADOQuery.Close;
  //showmessage('�����������Ļ��������硢����ϵͳ�Ȼ����������쳣������������������������ʱ���޷��򿪣���˵�����Ļ���/����/����ϵͳ�ȿ��ܴ������⣡');
  try
    try
      nowip:='';
      nowip:=GetWanIP;
      //showmessage(nowip);
      if pos(nowip,ListBox3.Items.Text)=0 then
      begin  //showmessage(nowip);
        ListBox3.Items.Add(nowip);
        if ListBox3.Items.Count>20 then   //showmessage(nowip);
          ListBox3.Items.Delete(0);//showmessage(ListBox3.Items.Text);
      end
      else
        nowip:='';
      rightdatetime:=GetrightTime;
      if strtoint(copy(datetimetostr(rightdatetime),1,4))<2014 then
      begin
        showmessage('���������硢����ϵͳ�Ȼ������ܴ����쳣������Զ��˳���');
        application.Terminate;
      end;
        //RunDOS('rasdial /disconnect');
      {setmac('',ComboBox1.Text,0);
      if ComboBox2.Text='��ͨ����' then
        ControlEthernet('��������', discVerb) //���ñ������� 'ͣ��&'
      else if ComboBox2.Text='�����' then
        RunDOS('netsh interface set interface "��������" disabled'); //���ñ������� 'ͣ��&'
      Types:=INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY;
      while internetGetConnectedState(@types,0) do
      begin   //showmessage('����');
        Types:=INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY;
      end;   //showmessage('�ѹر�');
      if ComboBox2.Text='��ͨ����' then
        ControlEthernet('��������', connVerb) //���ñ������� 'ͣ��&'
      else if ComboBox2.Text='�����' then
        RunDOS('netsh interface set interface "��������" enabled');
      while (pos('������',backstr)=0) do
      begin
        backstr:=RunDOS('rasdial ������� '+openkdADOQuery.fieldbyname('zhanghao').AsString+' '+openkdADOQuery.fieldbyname('mima').AsString);
        sleep(strtoint(Edit10.Text));
      end;}
    except
      showmessage('���������硢����ϵͳ�Ȼ������ܴ����쳣������Զ��˳���');
      application.Terminate;
    end;
    mostr:=getmpstr(3);
    reg:=tregistry.create;
    with reg do //����д��ע�������
    begin
       RootKey:=HKEY_CURRENT_USER;
       if OpenKey('SOFTWARE\TDR\addqqsoftdd',True) then
       begin
          regstr:=ReadString('regstr');
          if 'GDFRg'+mostr+'DFDSFDSDFSAEFAFDGASRSDFDSGG'=regstr then
            ld:=length(regstr);
          ld:=length(regstr);
          Label39.Caption:='ʣ��'+inttostr(ld)+'��ʹ����';
          //WriteString('regstr',Memo1.Text);
          //showmessage('�Ѿ�д��ע�ᣬ���´��������Ч��');
          //Self.Close;

       end;
       closekey;
    end;
    reg.Free;
  except
    showmessage('�������쳣������رգ�');
    self.Close;
  end;
  OldWinKuan:=screen.Width;
  OldWinGao:=screen.Height;
  if (screen.Width <> 1360) or (screen.Height <> 768) then
  Begin
    //showmessage('�������ڵ���Ļ�ֱ���Ϊ'+inttostr(OldWinKuan)+'*'+inttostr(OldWinGao)+'��Ϊ��ʹ����ܹ��ﵽ��õ�����Ч�������ǽ�������Ե���Ļ�ֱ����޸�Ϊ1360*768���˳���������ǽ��ѵ��Ե���Ļ�ֱ��ʻ�ԭΪ'+inttostr(OldWinKuan)+'*'+inttostr(OldWinGao));
    ChangeDisplay(1360,768);        //�޸���Ļ�ֱ���Ϊ 1360*768
  End;
  reg:=tregistry.create;
  with reg do //����д��ע�������
  begin
     RootKey:=HKEY_CURRENT_USER;
     if OpenKey('SOFTWARE\TDR\addqqsoftdd',True) then
     begin
        WriteString('apppath',application.ExeName);
     end;
     closekey;
  end;
  reg.Free;
  timer1done:=true;
  timer2done:=true;
end;

procedure TmainForm.FormDestroy(Sender: TObject);
begin
  {webts.Free;
  conformsetts.Free;}
  if (screen.Width <> OldWinKuan) or (screen.Height <> OldWinGao) then
  Begin
    ChangeDisplay(OldWinKuan,OldWinGao);                 
  End;
end;


procedure TmainForm.BitBtn3Click(Sender: TObject);
var
importqqlist,wrongmsg:Tstringlist;
i:integer;
lsstr,qqnum,qqpwd,qqmibao,wrongstr,nowdatetime:string;
begin
  asm
  db $EB,$10,'VMProtect begin',0
  end;
  if nus<=0 then
    exit;
  asm
  db $EB,$0E,'VMProtect end',0
  end;
  OpenDialog1.Filter:='(�����ļ�.txt)|*.txt';
  if OpenDialog1.Execute then
  begin
    wrongstr:='';
    nowdatetime:=formatdatetime('yyyymmddhhnnsszzz',now);
    importqqlist:=Tstringlist.Create;
    wrongmsg:=Tstringlist.Create;
    wrongmsg.Clear;
    importqqlist.Clear;
    importqqlist.LoadFromFile(OpenDialog1.FileName);
    if importqqlist.Count=0 then
    begin
      showmessage('�����ļ���û�����ݣ�');
      exit;
    end;
    for i:=0 to importqqlist.Count-1 do
    begin
      lsstr:=importqqlist.Strings[i];
      qqnum:=copy(lsstr,1,pos('----',lsstr)-1);
      lsstr:=copy(lsstr,pos('----',lsstr)+4,length(lsstr)-pos('----',lsstr)-3);
      qqpwd:=copy(lsstr,1,pos('----',lsstr)-1);
      qqmibao:=copy(lsstr,pos('----',lsstr)+4,length(lsstr)-pos('----',lsstr)-3);
      Opensql(openmainqqtestADOQuery,'select * from zhuhaoma where qqhaoma='''+qqnum+'''');
      if openmainqqtestADOQuery.RecordCount=0 then
        Execsql(editmainqqADOQuery,'insert into zhuhaoma(qqhaoma,qqmima,mibaoziliao,zhuangtai) values('''+qqnum+''','''+qqpwd+''','''+qqmibao+''',''����'')')
      else
      begin
        if openmainqqtestADOQuery.FieldByName('zhuangtai').AsString='������' then
          Execsql(editmainqqADOQuery,'update zhuhaoma set zhuangtai=''����''')
        else
          wrongmsg.Add(qqnum+'�Ѿ��м�¼��');
      end;
        //wrongstr:=wrongstr+','+qqnum+'�Ѿ��м�¼��';
      //showmessage('�˺ţ�'+qqnum+';'+'���룺'+qqpwd+';'+'�ܱ���'+qqmibao);
    end;
    //wrongmsg.Text:=wrongstr;
    if wrongmsg.Count>0 then
      wrongmsg.SaveToFile(apppath+'���˺ŵ��������־'+nowdatetime+'.txt');
    if (wrongmsg.Count=importqqlist.Count)and(wrongmsg.Count>0) then
      showmessage('ȫ������ʧ�ܣ�������־�Ѿ����浽��'+apppath+'���˺ŵ��������־'+nowdatetime+'.txt')
    else if (wrongmsg.Count<importqqlist.Count)and(wrongmsg.Count>0) then
      showmessage('���ֵ���ɹ���������־�Ѿ����浽��'+apppath+'���˺ŵ��������־'+nowdatetime+'.txt')
    else if (0<importqqlist.Count)and(wrongmsg.Count=0) then
      showmessage('ȫ������ɹ���');
    Opensql(openmainqqADOQuery,'select * from zhuhaoma order by id');
    importqqlist.Free;
    wrongmsg.Free;
  end;
end;

procedure TmainForm.BitBtn2Click(Sender: TObject);
begin
  if (length(Edit1.Text)=0)or(length(MaskEdit1.Text)=0)then
  begin
    showmessage('QQ�����QQ���������Ϊ�գ�');
    exit;
  end;
  Execsql(editmainqqADOQuery,'insert into zhuhaoma(qqhaoma,qqmima,mibaoziliao) values('''+Edit1.Text+''','''+MaskEdit1.Text+''','''+Edit3.Text+''')');
  Opensql(openmainqqADOQuery,'select * from zhuhaoma order by id');
  Edit1.Text:='';
  MaskEdit1.Text:='';
  showmessage('��ӳɹ���');
end;

procedure TmainForm.BitBtn5Click(Sender: TObject);
begin
  if MessageBox(Handle, 'ȷ��Ҫɾ���ú�����', 'ɾ������',MB_ICONQUESTION or MB_OKCANCEL) = IDOK then
  begin
    Execsql(editmainqqADOQuery,'delete from zhuhaoma where id='+openmainqqADOQuery.fieldbyname('id').AsString);
    Opensql(openmainqqADOQuery,'select * from zhuhaoma order by id');
    showmessage('ɾ���ɹ���');
  end;
end;

function TmainForm.huoquzhuangtai:boolean;
begin
  Opensql(openmainqqADOQuery,'select * from zhuhaoma order by id');
  Opensql(openlistqqADOQuery,'select * from daijiahaoma order by id');
  Opensql(openevenADOQuery,'select * from even order by id desc');
  Opensql(openmainqqtestADOQuery,'select sum(haoyoushu) as zonghaoyoushu from zhuhaoma');
  if openmainqqtestADOQuery.fieldbyname('zonghaoyoushu').Value>0 then
    if openmainqqtestADOQuery.fieldbyname('zonghaoyoushu').Value<>strtoint(Label11.Caption)then
    begin
      Execsql(edittongjiADOQuery,'update tongji set hytj='+openmainqqtestADOQuery.fieldbyname('zonghaoyoushu').AsString);
    end;
  openmainqqtestADOQuery.Close;  

  Opensql(openlistqqtestADOQuery,'select count(id) as chenggongshu from daijiahaoma where shiguo=true and (zhuangtai=''�ѷ���֤'' or zhuangtai=''������'')');

  if openlistqqtestADOQuery.fieldbyname('chenggongshu').Value<>strtoint(Label9.Caption)then
    Execsql(edittongjiADOQuery,'update tongji set tjcg='+openlistqqtestADOQuery.fieldbyname('chenggongshu').AsString);
  openlistqqtestADOQuery.Close;
  Opensql(openlistqqtestADOQuery,'select count(id) as shibaishu from daijiahaoma where shiguo=true and (zhuangtai=''�ܾ����'' or zhuangtai=''������'' or zhuangtai=''��ش���ȷ��'' or zhuangtai is null)');
  if openlistqqtestADOQuery.fieldbyname('shibaishu').Value<>strtoint(Label10.Caption)then
    Execsql(edittongjiADOQuery,'update tongji set tjsb='+openlistqqtestADOQuery.fieldbyname('shibaishu').AsString);
  openlistqqtestADOQuery.Close;

  Opensql(opencodetestADOQuery,'select count(proid) as damashu from code where coderesult is not null');
  if opencodetestADOQuery.fieldbyname('damashu').Value<>strtoint(Label12.Caption)then
    Execsql(editcodeADOQuery,'update tongji set dmtj='+opencodetestADOQuery.fieldbyname('damashu').AsString);
  opencodetestADOQuery.Close;

  Opensql(opencodetestADOQuery,'select count(proid) as cuowushu from code where coderesult is not null and coderof=0');
  if opencodetestADOQuery.fieldbyname('cuowushu').Value<>strtoint(Label13.Caption)then
    Execsql(editcodeADOQuery,'update tongji set dmbc='+opencodetestADOQuery.fieldbyname('cuowushu').AsString);
  opencodetestADOQuery.Close;

  Opensql(opentongjiADOQuery,'select * from tongji');
  if opentongjiADOQuery.RecordCount=0 then
  begin
    opentongjiADOQuery.Close;
    Exit;
  end;
  Label9.Caption:=opentongjiADOQuery.fieldbyname('tjcg').AsString;
  Label10.Caption:=opentongjiADOQuery.fieldbyname('tjsb').AsString;
  Label11.Caption:=opentongjiADOQuery.fieldbyname('hytj').AsString;
  Label12.Caption:=opentongjiADOQuery.fieldbyname('dmtj').AsString;
  Label13.Caption:=opentongjiADOQuery.fieldbyname('dmbc').AsString;
  opentongjiADOQuery.Close;
end;


procedure TmainForm.FormShow(Sender: TObject);
var
i,mo,yy,dl,Types:Integer;
reg:TRegistry;
regname,lsstr:string;
idhttp:Tidhttp;
fromother:boolean;
begin  
  asm
  db $EB,$10,'VMProtect begin',0
  end;
            //showmessage(regstr);
  //if strtoint(ossr)>20140508 then
  if strtoint(formatdatetime('yyyymmdd',rightdatetime))>20240519 then
    application.Terminate;
  ld:=0;
  //showmessage(inttostr(length(regstr)));
  if length(regstr)>10 then
  begin
    try
      lsstr:=fdgd(regstr);
      //showmessage(inttostr(length(lsstr)));
      if mostr=copy(lsstr,8,16) then
      begin
        std:='20'+copy(lsstr,5,1)+copy(lsstr,25,1)+copy(lsstr,27,1)+copy(lsstr,1,1)+copy(lsstr,3,1)+copy(lsstr,29,1);
        //showmessage(std);
        sis:=strtoint(copy(lsstr,30,length(lsstr)-30+1));
        sl1:=strtoint(copy(lsstr,7,1)) mod 2;
        yy:=strtoint(copy(std,1,4));
        mo:=strtoint(copy(std,5,2));
        dl:=strtoint(copy(std,7,2));
        if sl1=1 then
        begin
          mo:=mo+1;
          if mo>12 then
          begin
            mo:=1;
            yy:=yy+1;
          end;
        end
        else if sl1=0 then
        begin
          yy:=yy+1;
        end;
        std:=inttostr(yy)+'-'+inttostr(mo)+'-'+inttostr(dl)+' 23:59:59';
        //strtodatetime(inttostr(yy)+'-'+inttostr(mo)+'-'+inttostr(dl)+' 00:00:00')
        //showmessage(mostr+';'+std+';'+inttostr(sis)+';'+inttostr(sl1));
        //showmessage(inttostr(yy)+'-'+inttostr(mo)+'-'+inttostr(dl)+' 00:00:00');
      end;
    except
      application.Terminate;
    end;
  end;
  asm
  db $EB,$0E,'VMProtect end',0
  end;

  huoquzhuangtai;
  jianchacwyzm;

  if bsddyx then
  begin
    //KillTask('qq.exe');
    KillTrayIcons(Self);
  end;

  fromother:=false;
  for i:=1 to paramcount do
    if ExtractFilename(ParamStr(i))='count.exe' then
      fromother:=true;
  if fromother then
  begin
    TabSheet2.Show;
    BitBtn4.Click;
  end
  else
    TabSheet1.Show;
end;

procedure TmainForm.BitBtn6Click(Sender: TObject);
var
importqqlist,wrongmsg:Tstringlist;
i:integer;
wrongstr,nowdatetime:string;
begin
  asm
  db $EB,$10,'VMProtect begin',0
  end;
  if nus<=0 then
    exit;
  asm
  db $EB,$0E,'VMProtect end',0
  end;
  OpenDialog1.Filter:='(�����ļ�.txt)|*.txt';
  if OpenDialog1.Execute then
  begin
    wrongstr:='';
    nowdatetime:=formatdatetime('yyyymmddhhnnsszzz',now);
    importqqlist:=Tstringlist.Create;
    wrongmsg:=Tstringlist.Create;
    wrongmsg.Clear;
    importqqlist.Clear;
    importqqlist.LoadFromFile(OpenDialog1.FileName);
    if importqqlist.Count=0 then
    begin
      showmessage('�����ļ���û�����ݣ�');
      exit;
    end;
    for i:=0 to importqqlist.Count-1 do
    begin
      Opensql(openlistqqtestADOQuery,'select * from daijiahaoma where qqhaoma='''+importqqlist.Strings[i]+'''');
      if openlistqqtestADOQuery.RecordCount=0 then
        Execsql(editlistqqADOQuery,'insert into daijiahaoma(qqhaoma) values('''+importqqlist.Strings[i]+''')')
      else
        wrongmsg.Add(importqqlist.Strings[i]+'�Ѿ��м�¼��');
        //wrongstr:=wrongstr+','+qqnum+'�Ѿ��м�¼��';
      //showmessage('�˺ţ�'+qqnum+';'+'���룺'+qqpwd+';'+'�ܱ���'+qqmibao);
    end;
    //wrongmsg.Text:=wrongstr;
    if wrongmsg.Count>0 then
      wrongmsg.SaveToFile(apppath+'�����˺ŵ��������־'+nowdatetime+'.txt');
    if (wrongmsg.Count=importqqlist.Count)and(wrongmsg.Count>0) then
      showmessage('ȫ������ʧ�ܣ�������־�Ѿ����浽��'+apppath+'�����˺ŵ��������־'+nowdatetime+'.txt')
    else if (wrongmsg.Count<importqqlist.Count)and(wrongmsg.Count>0) then
      showmessage('���ֵ���ɹ���������־�Ѿ����浽��'+apppath+'�����˺ŵ��������־'+nowdatetime+'.txt')
    else if (0<importqqlist.Count)and(wrongmsg.Count=0) then
      showmessage('ȫ������ɹ���');
    Opensql(openlistqqADOQuery,'select * from daijiahaoma order by id');
    importqqlist.Free;
    wrongmsg.Free;                 
  end;
end;

function WinExecAndWait32(APath: PChar; ACmdShow: Integer;  
ATimeout: Longword): Integer;
var
vStartupInfo: TStartupInfo;
vProcessInfo: TProcessInformation;
begin
FillChar(vStartupInfo, SizeOf(TStartupInfo), 0);
with vStartupInfo do
begin
cb := SizeOf(TStartupInfo);
dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
wShowWindow := ACmdShow;
end;
if CreateProcess(nil, APath, nil, nil, False,
NORMAL_PRIORITY_CLASS, nil, nil,
vStartupInfo, vProcessInfo) then
Result := WaitForSingleObject(vProcessInfo.hProcess, ATimeout)
else Result := GetLastError;
end;

function deletetempcookie:boolean;
begin
  //WinExecAndWait32('rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 1', SW_SHOW, INFINITE);    //IE history
  WinExecAndWait32('rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 2', SW_SHOW, INFINITE);    //IE cookies
  WinExecAndWait32('rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 8', SW_SHOW, INFINITE);    //IE����
  //WinExecAndWait32('rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 16', SW_SHOW, INFINITE);   //form
  //WinExecAndWait32('rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 32', SW_SHOW, INFINITE);   //auto save pass
  //WinExecAndWait32('rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 255', SW_SHOW, INFINITE);  //all
  //WinExecAndWait32('rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 4351', SW_SHOW, INFINITE); //all & addons
end;

function   DeleteDirectoryfile(NowPath:   string):   Boolean;   //Ŀ¼��������ļ�
  var
      search:   TSearchRec;
      ret:   integer;
      key:   string;
  begin
      if   NowPath[Length(NowPath)]   <>   '\'   then
          NowPath   :=   NowPath   +   '\';
      key   :=   Nowpath   +   '*.*';
      ret   :=   findFirst(key,   faanyfile,   search);   
      while   ret   =   0   do
      begin
          if   ((search.Attr   and   fadirectory)   =   faDirectory)then
          begin
              if   (Search.Name   <>   '.')   and   (Search.name   <>   '..')   then
              begin
                try
                  DeleteDirectoryfile(NowPath   +   Search.name);
                except
                end;
              end;
          end
          else
          begin
              if   ((search.attr   and   fadirectory)   <>   fadirectory)   then
              begin
                try
                    deletefile(NowPath   +   search.name);
                except
                end;
              end;
          end;
          ret   :=   FindNext(search);   
      end;
      findClose(search);
      //showmessage(NowPath);
      if startpath<>uppercase(NowPath)then
        removedir(NowPath);      //ɾ��Ŀ¼ 
      result   :=   True;   
  end;

function deletetempfile:boolean;
begin
  {if DirectoryExists('C:\Documents and Settings\Administrator\Application Data\Tencent\QQ\webkit_cache\') then
    DeleteDirectoryfile('C:\Documents and Settings\Administrator\Application Data\Tencent\QQ\webkit_cache\');
  if DirectoryExists('C:\Documents and Settings\Administrator\Application Data\Tencent\QQ\Misc\') then
    DeleteDirectoryfile('C:\Documents and Settings\Administrator\Application Data\Tencent\QQ\Misc\');
  if DirectoryExists('C:\Documents and Settings\Administrator\Application Data\Tencent\Users\') then
    DeleteDirectoryfile('C:\Documents and Settings\Administrator\Application Data\Tencent\Users\');
  if DirectoryExists('D:\Program Files\Tencent\QQ\Users\') then
    DeleteDirectoryfile('D:\Program Files\Tencent\QQ\Users\');}
  startpath:=uppercase(mainForm.QQpath2Edit.text+'Users\');
  if DirectoryExists(mainForm.QQpath2Edit.text+'Users\') then
    DeleteDirectoryfile(mainForm.QQpath2Edit.text+'Users\');
end;

function TmainForm.getdata(var fromado,toado:Tadoquery):boolean;
begin
  if fileexists('temp.xml')then
    deletefile('temp.xml');
  fromado.SaveToFile('temp.xml',pfxml);
  fromado.Close;
  toado.LoadFromFile('temp.xml');
  deletefile('temp.xml');
end;
procedure TmainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
i:integer;
begin
  {for i:=0 to webts.Count-1 do
  begin
    if fileexists(apppath+'qqlist'+webts.Strings[i]+'.ini') then
      deletefile(apppath+'qqlist'+webts.Strings[i]+'.ini');
    if fileexists(apppath+'formset'+webts.Strings[i]+'.ini') then
      deletefile(apppath+'formset'+webts.Strings[i]+'.ini');
  end;
  if fileexists(apppath+'addclient.exe') then
    Deletefile(apppath+'addclient.exe');
  if fileexists(apppath+'mainform.ini') then
    deletefile(apppath+'mainform.ini');
  if fileexists(apppath+'temp.xml') then
    deletefile(apppath+'temp.xml');}
end;

function TmainForm.outputmainqqlist(con:string):boolean;  //�������˺�       con�ǵ�������
var
outputqqlist:Tstringlist;
sqlstr:string;
begin
  SaveDialog1.Filter:='(�����ļ�.txt)|*.txt';
  sqlstr:='select * from zhuhaoma';
  if length(con)>0 then
    sqlstr:=sqlstr+' where zhuangtai='''+con+'''';
  if SaveDialog1.Execute then
  begin
    if uppercase(copy(SaveDialog1.FileName,length(SaveDialog1.FileName)-3,4))<>'.TXT' then
      SaveDialog1.FileName:=SaveDialog1.FileName+'.TXT';
    Opensql(openmainqqtestADOQuery,sqlstr);
    if openmainqqtestADOQuery.RecordCount>0 then
    begin
      outputqqlist:=Tstringlist.Create;
      outputqqlist.Clear;
      openmainqqtestADOQuery.First;
      while not openmainqqtestADOQuery.Eof do
      begin
        outputqqlist.Add(openmainqqtestADOQuery.fieldbyname('qqhaoma').AsString+'----'+openmainqqtestADOQuery.fieldbyname('qqmima').AsString+'----'+openmainqqtestADOQuery.fieldbyname('mibaoziliao').AsString);
        openmainqqtestADOQuery.Next;
      end;
      outputqqlist.SaveToFile(SaveDialog1.FileName);
      //wrongmsg.Text:=wrongstr;
      outputqqlist.Free;
      showmessage('�����ɹ���');
    end
    else
      showmessage('û�з��������ļ�¼��');
  end;
end;

procedure TmainForm.N1Click(Sender: TObject);
begin
  outputmainqqlist('');
end;

procedure TmainForm.N2Click(Sender: TObject);
begin
  outputmainqqlist('������');
end;

procedure TmainForm.DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
begin
  if openmainqqADOQuery.RecordCount=0 then
    Exit;
  if column.Title.SortMarker=smdowneh then
    openmainqqADOQuery.Sort :=column.FieldName
  else
    openmainqqADOQuery.Sort :=column.FieldName +' DESC';
end;

procedure TmainForm.DBGridEh2TitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
begin
  if openlistqqADOQuery.RecordCount=0 then
    Exit;
  if column.Title.SortMarker=smdowneh then
    openlistqqADOQuery.Sort :=column.FieldName
  else
    openlistqqADOQuery.Sort :=column.FieldName +' DESC';
end;

procedure TmainForm.BitBtn7Click(Sender: TObject);
begin
  if (length(Edit2.Text)=0)or(length(MaskEdit2.Text)=0) then
  begin
    showmessage('�û��������붼����Ϊ�գ�');
    Exit;
  end;
  if (length(Edit5.Text)=0)or(length(Edit4.Text)=0)or(length(Edit8.Text)=0)or(length(Edit14.Text)=0)or(length(Memo1.Text)=0) then
  begin
    showmessage('��IP������ÿQ�Ӻ�����������һQQ������������һQQ����������֤��Ϣ�б�����Ϊ�գ�');
    Exit;
  end;
  Opensql(opendamaADOQuery,'select * from dama');
  if opendamaADOQuery.RecordCount>0 then
  begin
    Execsql(editdamaADOQuery,'update dama set userid='''+Edit2.Text+''',userpwd='''+MaskEdit2.Text+'''');
  end
  else                                                                                                                                                                                                                                                                                                                                                  //,jqlx='''+ComboBox2.Text+'''
    Execsql(editdamaADOQuery,'insert into dama(userid,userpwd) values('''+Edit2.Text+''','''+MaskEdit2.Text+''')');
  Execsql(editsetADOQuery,'update softset set changemac='''+Edit5.Text+''',addqqnum='''+Edit4.Text+''',loginnextqqtime='''+Edit8.Text+''',addnextqqtime='''+Edit14.Text+''',sendmsg='''+Memo1.Text+''',sendtype='''+iif(RadioButton1.checked,'1','2')+''',gethys='''+iif(CheckBox2.Checked,'1','0')+''',zjm='''+Edit13.Text+''',sdfw='''+Edit17.Text+'''');
  showmessage('����ɹ���');
end;

function yzmmultixotxt(var MS:TMemoryStream; yhm,mm,bm:string):string;                          //�������ʶ����֤��
var
xdr:string;
tid:TIdHTTP;
xtram:TStringStream;
xtr:TStringlist;
begin
 try
 tid:=TIdHTTP.Create(nil);
 tid.Request.ContentType:='multipart/form-data; boundary=---------------------------8d070bdf16538b4';
 tid.Request.UserAgent:='Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)';
 tid.ConnectTimeout:=10000;
 tid.ReadTimeout:=60000;
 tid.HandleRedirects:=true;
 tid.HTTPOptions:=tid.HTTPOptions+[hoKeepOrigProtocol];
 tid.ProtocolVersion:=pv1_1;
 xtr:=TStringlist.Create;
 xtr.ADD('');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="username"');
 xtr.ADD('');
 xtr.ADD(yhm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="password"');
 xtr.ADD('');
 xtr.ADD(mm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="typeid"');
 xtr.ADD('');
 xtr.ADD(bm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="timeout"');
 xtr.ADD('');
 xtr.ADD('60');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="softid"');
 xtr.ADD('');
 xtr.ADD('4740');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="softkey"');
 xtr.ADD('');
 xtr.ADD('bf4b834dffb32de8467d366ba813932e');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="image"; filename="System.Byte[]"');
 xtr.ADD('Content-Type: image/gif');
 xtr.ADD('');
 xtram:=TStringStream.Create(xtr.Text);
 xtram.Position:=xtram.Size;
 xtram.CopyFrom(MS,MS.Size);
 xtram.Position:=xtram.Size;
 xtram.WriteString(#13#10+'-----------------------------8d070bdf16538b4--'+#13#10);
 xdr:=tid.post('http://api.ruokuai.com/create.txt',xtram);
 tid.Disconnect;
 xtr.Free;
 tid.Free;
 xtram.Free;
 except
 end;
 Result:=xdr;
end;

{function chaxunmultixotxt(var MS:TMemoryStream; yhm,mm,bm:string):string;                            //��������ѯ���
var
xdr:string;
tid:TIdHTTP;
xtram:TStringStream;
xtr:TStringlist;
begin
 try
 tid:=TIdHTTP.Create(nil);
 tid.Request.ContentType:='multipart/form-data; boundary=---------------------------8d070bdf16538b4';
 tid.Request.UserAgent:='Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)';
 tid.ReadTimeout:=60000;
 tid.HandleRedirects:=true;
 tid.HTTPOptions:=tid.HTTPOptions+[hoKeepOrigProtocol];
 tid.ProtocolVersion:=pv1_1;
 xtr:=TStringlist.Create;
 xtr.ADD('');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="username"');
 xtr.ADD('');
 xtr.ADD(yhm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="password"');
 xtr.ADD('');
 xtr.ADD(mm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="typeid"');
 xtr.ADD('');
 xtr.ADD(bm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="timeout"');
 xtr.ADD('');
 xtr.ADD('60');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="softid"');
 xtr.ADD('');
 xtr.ADD('4740');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="softkey"');
 xtr.ADD('');
 xtr.ADD('bf4b834dffb32de8467d366ba813932e');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="image"; filename="System.Byte[]"');
 xtr.ADD('Content-Type: image/gif');
 xtr.ADD('');
 xtram:=TStringStream.Create(xtr.Text);
 xtram.Position:=xtram.Size;
 //xtram.CopyFrom(MS,MS.Size);
 xtram.Position:=xtram.Size;
 //xtram.WriteString('-----------------------------8d070bdf16538b4--'+#13#10);
 xtram.WriteString('username='+yhm+' '+'password='+mm+#13#10);
 xdr:=tid.post('http://api.ruokuai.com/info.json',xtram);
 tid.Disconnect;
 xtr.Free;
 tid.Free;
 xtram.Free;
 except
 end;
 Result:=xdr;
end;}

function chaxunmultixotxt(yhm,mm:string):string;                            //��������ѯ���
var
xdr:string;
tid:TIdHTTP;
xtram:TStringStream;
xtr:TStringlist;
begin
 try
 tid:=TIdHTTP.Create(nil);
 tid.Request.ContentType:='multipart/form-data; boundary=---------------------------8d070bdf16538b4';
 tid.Request.UserAgent:='Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)';
 tid.ConnectTimeout:=10000;
 tid.ReadTimeout:=60000;
 tid.HandleRedirects:=true;
 tid.HTTPOptions:=tid.HTTPOptions+[hoKeepOrigProtocol];
 tid.ProtocolVersion:=pv1_1;
 xtr:=TStringlist.Create;
 xtr.ADD('');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="username"');
 xtr.ADD('');
 xtr.ADD(yhm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="password"');
 xtr.ADD('');
 xtr.ADD(mm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtram:=TStringStream.Create(xtr.Text);
 xtram.Position:=xtram.Size;
// xtram.WriteString('username='+yhm+' '+'password='+mm+#13#10);
 xdr:=tid.post('http://api.ruokuai.com/info.json',xtram);
 tid.Disconnect;
 xtr.Free;
 tid.Free;
 xtram.Free;
 except
 end;
 Result:=xdr;
end;

function baocuomultixotxt(yhm,mm,id:string):string;                            //��������ѯ���
var
xdr:string;
tid:TIdHTTP;
xtram:TStringStream;
xtr:TStringlist;
begin
 try
 tid:=TIdHTTP.Create(nil);
 tid.Request.ContentType:='multipart/form-data; boundary=---------------------------8d070bdf16538b4';
 tid.Request.UserAgent:='Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)';
 tid.ConnectTimeout:=10000;
 tid.ReadTimeout:=60000;
 tid.HandleRedirects:=true;
 tid.HTTPOptions:=tid.HTTPOptions+[hoKeepOrigProtocol];
 tid.ProtocolVersion:=pv1_1;
 xtr:=TStringlist.Create;
 xtr.ADD('');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="username"');
 xtr.ADD('');
 xtr.ADD(yhm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="password"');
 xtr.ADD('');
 xtr.ADD(mm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="softid"');
 xtr.ADD('');
 xtr.ADD('4740');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="softkey"');
 xtr.ADD('');
 xtr.ADD('bf4b834dffb32de8467d366ba813932e');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="id"');
 xtr.ADD('');
 xtr.ADD(id);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtram:=TStringStream.Create(xtr.Text);
 xtram.Position:=xtram.Size;
 xdr:=tid.post('http://api.ruokuai.com/reporterror.json',xtram);
 tid.Disconnect;
 xtr.Free;
 tid.Free;
 xtram.Free;
 except
 end;
 Result:=xdr;
end;
{function baocuomultixotxt(var MS:TMemoryStream; yhm,mm,bm,id:string):string;                            //��������ѯ���
var
xdr:string;
tid:TIdHTTP;
xtram:TStringStream;
xtr:TStringlist;
begin
 try
 tid:=TIdHTTP.Create(nil);
 tid.Request.ContentType:='multipart/form-data; boundary=---------------------------8d070bdf16538b4';
 tid.Request.UserAgent:='Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)';
 tid.ReadTimeout:=60000;
 tid.HandleRedirects:=true;
 tid.HTTPOptions:=tid.HTTPOptions+[hoKeepOrigProtocol];
 tid.ProtocolVersion:=pv1_1;
 xtr:=TStringlist.Create;
 xtr.ADD('');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="username"');
 xtr.ADD('');
 xtr.ADD(yhm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="password"');
 xtr.ADD('');
 xtr.ADD(mm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="typeid"');
 xtr.ADD('');
 xtr.ADD(bm);
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="timeout"');
 xtr.ADD('');
 xtr.ADD('60');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="softid"');
 xtr.ADD('');
 xtr.ADD('4740');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="softkey"');
 xtr.ADD('');
 xtr.ADD('bf4b834dffb32de8467d366ba813932e');
 xtr.ADD('-----------------------------8d070bdf16538b4');
 xtr.ADD('Content-Disposition: form-data; name="image"; filename="System.Byte[]"');
 xtr.ADD('Content-Type: image/gif');
 xtr.ADD('');
 xtram:=TStringStream.Create(xtr.Text);
 xtram.Position:=xtram.Size;
 //xtram.CopyFrom(MS,MS.Size);
 xtram.Position:=xtram.Size;
 //xtram.WriteString('-----------------------------8d070bdf16538b4--'+#13#10);
 xtram.WriteString('username='+yhm+' '+'password='+mm+' '+'softid=4740'+' '+'softkey=bf4b834dffb32de8467d366ba813932e'+' '+'id='+id+#13#10);
 xdr:=tid.post('http://api.ruokuai.com/reporterror.json',xtram);
 tid.Disconnect;
 xtr.Free;
 tid.Free;
 xtram.Free;
 except
 end;
 Result:=xdr;
end;}

procedure TmainForm.BitBtn4Click(Sender: TObject);
var
i:integer;
nowtimestr:string;
formsetts:Tstringlist;
newleft,newtop,newheight,newwidth:integer;
MS:TMemoryStream;
backres:string;
begin
  if length(ComboBox1.Text)=0 then
  begin
    showmessage('û��ѡ��������');
    Exit;
  end;
  if (length(Edit2.Text)=0)or(length(MaskEdit2.Text)=0) then
  begin
    showmessage('����û�������û��������룡');
    Exit;
  end;
  Opensql(openmainqqtestADOQuery,'select id from zhuhaoma where zhuangtai<>''������'' and zhuangtai<>''������''');
  if (openmainqqtestADOQuery.RecordCount=0) then
  begin
    showmessage('���˺�û�м�¼��');
    Exit;
  end;
  Opensql(openlistqqtestADOQuery,'select id from daijiahaoma where changshi=false or shiguo=false');
  if (openlistqqtestADOQuery.RecordCount=0) then
  begin
    showmessage('�����˺�û��δ���Եļ�¼��');
    Exit;
  end;
  Opensql(openmainqqtestADOQuery,'select id from zhuhaoma where shiyong=false or shiguo=false');
  backres:= chaxunmultixotxt(Edit2.Text,MaskEdit2.Text);
  {if strtoint(copy(backres,pos('"Score":"',backres)+9,pos('","HistoryScore"',backres)-pos('"Score":"',backres)-9))<openlistqqtestADOQuery.RecordCount*10*1.3 then
  begin
    showmessage('���������1:1.3�ı������㣬��������Ҫ'+inttostr(floor(openlistqqtestADOQuery.RecordCount*10*1.3))+'��ֵ������ʵ��ֻ��'+copy(backres,pos('"Score":"',backres)+9,pos('","HistoryScore"',backres)-pos('"Score":"',backres)-9)+'��ֵ�����ֵ��');
    exit;
  end;}
  if strtoint(copy(backres,pos('"Score":"',backres)+9,pos('","HistoryScore"',backres)-pos('"Score":"',backres)-9))<openmainqqtestADOQuery.RecordCount*10*1.3 then
  begin
    showmessage('���������1:1.3�ı������㣬��������Ҫ'+inttostr(floor(openmainqqtestADOQuery.RecordCount*10*1.3))+'��ֵ������ʵ��ֻ��'+copy(backres,pos('"Score":"',backres)+9,pos('","HistoryScore"',backres)-pos('"Score":"',backres)-9)+'��ֵ�����ֵ��');
    exit;
  end;
  try
    jgjc:=strtoint(Edit6.Text);
    if jgjc>10 then
    begin
      showmessage('���������ܴ���10��');
      exit;
    end;
  except
    showmessage('��������������');
    exit;
  end;
  try
    jjghy:=strtoint(Edit4.Text);
  except
    showmessage('ÿQ�Ӻ�������������');
    exit;
  end;
  try
    jlhsc:=strtoint(Edit5.Text);
  except
    showmessage('������������');
    exit;
  end;
  ddjl:=0;    //��ʼ���ڼ���
  ClipBoard.Clear;
  BitBtn4.Enabled:=false;
  allnumgiven:=false;
  endcount:=0;
  endstr:='';
  Execsql(openevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''����ʼ'',''����ʼ'')');
  aqkhdsbmainUnit.damauser:=Edit2.Text;
  aqkhdsbmainUnit.damapwd:=MaskEdit2.Text;
  doform.waittimeEdit.Text:=Edit14.Text;
  doform.QQpathEdit.Text:=QQpathEdit.Text;
  doform.CheckBox1.Checked:=CheckBox2.Checked;
  {webts.Clear;
  //webrjts.Clear;
  Self.Left:=0;
  //newheight:=floor(Self.Height/2);
  newheight:=415;
  newwidth:=283;
  newleft:=0;
  newtop:=0;
  formsetts:=Tstringlist.Create;
  for i:=1 to jgjc do
  begin
    formsetts.Clear;
    sleep(150);
    nowtimestr:=formatdatetime('yyyymmddhhnnsszzz',now);
    newtop:=newtop+20;
    newleft:=newleft+20;
    formsetts.Add(inttostr(i));
    formsetts.Add(inttostr(newtop));
    formsetts.Add(inttostr(newleft));
    formsetts.Add(inttostr(newwidth));
    formsetts.Add(inttostr(newheight));
    formsetts.SaveToFile(apppath+'formset'+nowtimestr+'.ini');
    webts.Add(nowtimestr);
  end;
  formsetts.Free;
  conformsetts.Strings[0]:=inttostr(Self.Top);
  conformsetts.Strings[1]:=inttostr(Self.Left+Self.Width+1);
  conformsetts.SaveToFile(apppath+'mainform.ini');}
  //���ڷǶ��������ȫ��ע��
  //ShellExecute(handle, 'open',pchar(apppath+'count.exe'),pchar(apppath+'�������紫ý��ӮӮ���磩.exe'),nil, SW_SHOWNORMAL);  ע������
  //winexec(pchar(apppath+'count.exe '+apppath+'�������紫ý��ӮӮ���磩.exe'), SW_NORMAL);
  timepass:=0;
  kaishi:=true;
  Timer2.Enabled:=true;
  BitBtn8.Caption:='ֹͣ';
  BitBtn8.Enabled:=true;
end;


function TmainForm.jianchacwyzm:boolean;
var
MS:TMemoryStream;                                   //codecheck=true and
begin
  Opensql(opencodeADOQuery,'select * from code where ((coderof=0)or(len(coderesult)>5)or((len(coderesultid)>0)and(len(coderesult)=0))) and (codeup=false or codeup is null)');
  if opencodeADOQuery.RecordCount>0 then
  begin
    //showmessage('1');
    opencodeADOQuery.First;
    while not opencodeADOQuery.Eof do
    begin
      MS:=TMemoryStream.Create;
      //showmessage(opencodeADOQuery.FieldByName('coderesultid').AsString);
      //showmessage(baocuomultixotxt(Edit2.Text,MaskEdit2.Text,opencodeADOQuery.FieldByName('coderesultid').AsString));
      baocuomultixotxt(Edit2.Text,MaskEdit2.Text,opencodeADOQuery.FieldByName('coderesultid').AsString);
      MS.Free;
      opencodeADOQuery.Edit;
      opencodeADOQuery.FieldByName('codeup').Value:=true;
      opencodeADOQuery.Post;
      opencodeADOQuery.Next;
    end;
  end;
  opencodeADOQuery.Close;
end;

procedure TmainForm.TabSheet3Show(Sender: TObject);
var
backres:string;
begin
  backres:= chaxunmultixotxt(Edit2.Text,MaskEdit2.Text);
              //multixotxt(ͼƬ�ֽ���,�û���,����,ͼƬ���ͱ��룩
  Label20.Caption:='ʣ�������'+copy(backres,pos('"Score":"',backres)+9,pos('","HistoryScore"',backres)-pos('"Score":"',backres)-9);
end;

procedure TmainForm.BitBtn8Click(Sender: TObject);
begin
  if BitBtn8.Caption='ֹͣ' then
  begin
    BitBtn8.Caption:='����';
    Timer2.Enabled:=false;
  end
  else
  begin
    BitBtn8.Caption:='ֹͣ';
    Timer2.Enabled:=true;
  end;
  //deletefile(apppath+'mainform.ini');
end;

function getrancomname:string;                            //��ȡ����������
const
ramnum='0123456789';
ramchar='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
i:integer;
begin
  result:='';
  for i:=1 to 5 do
  begin
    Randomize;//��ʼ���������
    result:=result+copy(ramchar,random(length(ramchar))+1,1);   //�����ĸ
  end;
  for i:=1 to 8 do
  begin
    Randomize;//��ʼ���������
    result:=result+copy(ramnum,random(length(ramnum))+1,1);   //���10���ڵ�����
  end;
end;

function adomove(adoq:Tadoquery;movei:integer):boolean;
var
i:integer;
begin
  if movei>floor(adoq.RecordCount/2) then
  begin
    adoq.Last;
    for i:=1 to adoq.RecordCount-movei do
      adoq.Prior;
  end
  else
  begin
    adoq.First;
    for i:=1 to movei do
      adoq.Next;
  end
end;

{function sendemail(smtptxt,mailuser,mailpassword,smtpporttxt,recuser,mailsubject,mailtext,sendfile:string):boolean;
var
SMTP: TIdSMTP;
msgsend: TIdMessage;
begin
  smtp := TIdSMTP.Create(nil);
  smtp.ConnectTimeout:=3000;
  smtp.ReadTimeout:=20000;
  smtp.Host := smtptxt; //  smtp.qq.com
  smtp.AuthType :=satdefault;
  smtp.Username := mailuser; //�û���
  smtp.Password := mailpassword; //����
  smtp.Port:=strtoint(smtpporttxt);    //25
  msgsend := TIdMessage.Create(nil);
  msgsend.Recipients.EMailAddresses := recuser; //�ռ��˵�ַ(����һ���Ļ��ö��Ÿ���)
  msgsend.From.Address := mailuser+'@qq.com'; //�Լ��������ַ   1115858607@qq.com
  msgsend.Subject :=mailsubject; //�ʼ�����
  msgsend.Body.Text :=mailtext;
  if length(sendfile)>0 then
    if fileexists(sendfile) then
      TIdAttachmentfile.Create(msgsend.MessageParts,sendfile);
  try
    smtp.Connect();
    try
      smtp.Authenticate;
      smtp.Send(msgsend);
    except
      smtp.Disconnect;
      exit;
    end;
  except
    smtp.Disconnect;
    exit;
  end;
  smtp.Disconnect;
  smtp.Free;
  msgsend.Free;
end; }

procedure TmainForm.Timer2Timer(Sender: TObject);
const
ramchar='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
k:integer;
Types:integer;
backstr,ipget,runexename:string;
i:integer;
idhttp:Tidhttp;
cancontinue:boolean;     //���Ե�½
begin
  asm
  db $EB,$10,'VMProtect begin',0
  end;
  if (timepass mod 10=0) then
  begin
    if (timepass<>0) then
      huoquzhuangtai;
    {if (timepass mod 3600=0)and(timepass<>0)and kaishi then
    begin
      //application.Terminate;
      runexename:=ExtractFilename(application.exename);
      ShellExecute(handle, 'open',pchar(application.exename),pchar('auto'),nil, SW_SHOWNORMAL);
      //winexec(pchar(application.exename),0);
      KillTask(runexename);
    end;}
    if ld=0 then
    begin
      Label39.Cursor:=crHandPoint;
      Label39.Caption:='ʣ��'+inttostr(ld)+'��ʹ���ڣ����ֵ!';
    end
    else
    begin
      Label39.Cursor:=crDefault;
      Label39.Caption:='ʣ��'+inttostr(ld)+'��ʹ����';
    end;
  end;
  timepass:=timepass+1;
  asm
  db $EB,$0E,'VMProtect end',0
  end;
  if not timer2done then
    exit;
  timer2done:=false;
  if kaishi then
  begin
    asm
    db $EB,$10,'VMProtect begin',0
    end;
    if nus<=0 then
      exit;
    asm
    db $EB,$0E,'VMProtect end',0
    end;
    try
      Opensql(openlistqqtestADOQuery,'select id from daijiahaoma where changshi=false or shiguo=false');
      if openlistqqtestADOQuery.RecordCount=0 then
      begin
        openlistqqtestADOQuery.Close;
        if doform.Button3.Caption='��ʼ' then
        begin
          kaishi:=false;
          jianchacwyzm;
          BitBtn8.Caption:='ֹͣ';
          BitBtn8.Enabled:=false;
          showmessage('�˴����������');
          //deletetempcookie;
          if bsddyx then
          begin
            KillTask('qq.exe');
            KillTask('count.exe');
            KillTrayIcons(Self);
          end;
          Execsql(openevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''�������'',''�������'')');
          Exit;
        end;
      end;
      if doform.Button3.Caption='��ʼ' then
      begin
        if bsddyx then
        begin
          KillTask('qq.exe');
          {deletetempcookie;}
          //deletetempfile;
          KillTrayIcons(Self);
        end;
        if (jlhsc<>0) then
          if (ddjl mod jlhsc=0)and(ddjl>0) then
          begin
            //showmessage('���');
            //deletetempcookie;
            //deletetempfile;
            //setmac(getranmac,ComboBox1.Text);
            nowip:='';
            while (length(nowip)=0) do
            begin
              RunDOS('rasdial /disconnect');
              {setmac(getranmac,ComboBox1.Text,1);
              if ComboBox2.Text='��ͨ����' then
                ControlEthernet('��������', discVerb) //���ñ������� 'ͣ��&'
              else if ComboBox2.Text='�����' then
                RunDOS('netsh interface set interface "��������" disabled');
              //ControlEthernet('��������', discVerb); //���ñ������� 'ͣ��&'
              Types:=INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY;
              while internetGetConnectedState(@types,0) do
              begin   //showmessage('����');
                Types:=INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY;
              end;   //showmessage('�ѹر�');
              if ComboBox2.Text='��ͨ����' then
                ControlEthernet('��������', connVerb) //���ñ������� 'ͣ��&'
              else if ComboBox2.Text='�����' then
                RunDOS('netsh interface set interface "��������" enabled');
              Types:=INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY;
              while not internetGetConnectedState(@types,0) do
              begin
                Types:=INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY;
              end;}
              while (pos('������',backstr)=0) do
              begin
                Randomize;//��ʼ���������
                adomove(openkdADOQuery,random(openkdADOQuery.RecordCount));
                for i:=1 to strtoint(Edit9.text) do
                  if(pos('������',backstr)=0)then
                  begin
                    backstr:=RunDOS('rasdial ������� '+openkdADOQuery.fieldbyname('zhanghao').AsString+' '+openkdADOQuery.fieldbyname('mima').AsString);
                    sleep(strtoint(Edit10.Text));
                  end;
              end;
              nowip:='';
              nowip:=GetWanIP;
              //showmessage(nowip);
              if pos(nowip,ListBox3.Items.Text)=0 then
              begin
                ListBox3.Items.Text:=nowip+#13+#10+ListBox3.Items.Text;
                if ListBox3.Items.Count>20 then
                  ListBox3.Items.Delete(ListBox3.Items.Count-1);
                Execsql(editsetADOQuery,'update softset set iplist='''+ListBox3.Items.Text+'''');
              end
              else
                nowip:='';
            end;
            funSetComputerName(getrancomname);
            ListBox1.Items.Text:=funGetComputerName+#13+#10+ListBox1.Items.Text;
            ListBox2.Items.Text:=getmpstr(4)+#13+#10+ListBox1.Items.Text;
          end;
        ddjl:=ddjl+1;
        lsendstr:='';
        lsendcount:=0;
        Execsql(editmainqqADOQuery,'update daijiahaoma set changshi=false where shiguo=false');
        Opensql(openlistqqADOQuery,'select * from daijiahaoma');
        Opensql(openlistqqtestADOQuery,'select id from daijiahaoma where changshi=false');
        if openlistqqtestADOQuery.RecordCount>0 then
        begin
          openlistqqtestADOQuery.Close;
          Opensql(openlistqqtestADOQuery,'select id from daijiahaoma where changshi=false');
          if openlistqqtestADOQuery.RecordCount>0 then
          begin
            openlistqqtestADOQuery.Close;
            //showmessage('select id from zhuhaoma where  shiguo=false and shiyong=false and ((zhuangtai=''����'') or ((zhuangtai=''������'') and (DateDiff("hh", sdsj, Date()+time())>'+edit17.Text+')');
            Opensql(openmainqqtestADOQuery,'select id from zhuhaoma where  shiguo=false and shiyong=false and ((zhuangtai=''����'') or ((zhuangtai=''������'') and (DateDiff("h", sdsj, Date()+time())>'+edit17.Text+')))');
            if openmainqqtestADOQuery.RecordCount=0 then        //showmessage('������');
              Execsql(editmainqqADOQuery,'update zhuhaoma set shiyong=false,shiguo=false');
            Opensql(openmainqqADOQuery,'select * from zhuhaoma order by id');
            cancontinue:=false;
            //showmessage('select top 1 * from zhuhaoma where shiyong=false and ((zhuangtai=''����'') or ((zhuangtai=''������'') and (DateDiff("hh", sdsj, Date()+time())>'+edit17.Text+'))');
            Opensql(openmainqqtestADOQuery,'select top 1 * from zhuhaoma where shiyong=false and ((zhuangtai=''����'') or ((zhuangtai=''������'') and (DateDiff("h", sdsj, Date()+time())>'+edit17.Text+')))');
            if openmainqqtestADOQuery.RecordCount>0 then
            begin
              if (openmainqqtestADOQuery.FieldByName('zhuangtai').AsString='������')then
              begin
                openmainqqtestADOQuery.Edit;
                openmainqqtestADOQuery.FieldByName('zhuangtai').Value:='����';
                openmainqqtestADOQuery.Post
              end;
              //if(HoursBetween(now,strtodatetime(openmainqqtestADOQuery.FieldByName('sdsj').AsString))>=strtoint(edit17.Text)) then
              execsql(editmainqqADOQuery,'update zhuhaoma set shiyong=true where qqhaoma='''+openmainqqtestADOQuery.FieldByName('qqhaoma').AsString+'''');
              doform.qquserEdit.Text:=openmainqqtestADOQuery.FieldByName('qqhaoma').AsString;
              doform.qqpwdEdit.Text:=openmainqqtestADOQuery.FieldByName('qqmima').AsString;
              Randomize;
              if RadioButton1.Checked then
                doform.checkinfoedit.Text:=Memo1.Lines[random(Memo1.Lines.Count-1)]
              else if RadioButton2.Checked then
                doform.checkinfoedit.Text:=copy(ramchar,random(length(ramchar))+1,1);
              //loadts.Add('zhuangtai='+ComboBox3.Text);
              Opensql(openlistqqtestADOQuery,'select id from daijiahaoma where changshi=false');
              if openlistqqtestADOQuery.RecordCount<jjghy then
                jjghy:=openlistqqtestADOQuery.RecordCount;
              doform.waddqqMemo.Lines.Clear;
              for k:=1 to jjghy do
              begin
                Opensql(openlistqqtestADOQuery,'select top 1 * from daijiahaoma where changshi=false');
                if openlistqqtestADOQuery.RecordCount>0 then
                begin
                  execsql(editlistqqADOQuery,'update daijiahaoma set changshi=true where qqhaoma='''+openlistqqtestADOQuery.FieldByName('qqhaoma').AsString+'''');
                  doform.waddqqMemo.Lines.Add(openlistqqtestADOQuery.FieldByName('qqhaoma').AsString);
                  //loadts.Add('daijiaqq='+openlistqqtestADOQuery.FieldByName('qqhaoma').AsString);
                end;
              end;
            end;
            //doform.Show;
            if doform.Button3.Enabled then
            begin
              //doform.Show;
              doform.Button3.Click;
            end;
          end;
          openlistqqtestADOQuery.Close;
        end;
        openlistqqtestADOQuery.Close;
      end;
      //doform.Show;
    except
    end;
  end;
  timer2done:=true;
end;

procedure TmainForm.Button6Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    QQpathEdit.Text:=OpenDialog1.FileName;
end;

procedure TmainForm.BitBtn1Click(Sender: TObject);
var
outputqqlist:Tstringlist;
begin
  SaveDialog1.Filter:='(�����ļ�.txt)|*.txt';
  if SaveDialog1.Execute then
  begin
    if uppercase(copy(SaveDialog1.FileName,length(SaveDialog1.FileName)-3,4))<>'.TXT' then
      SaveDialog1.FileName:=SaveDialog1.FileName+'.TXT';
    outputqqlist:=Tstringlist.Create;
    outputqqlist.Clear;
    outputqqlist.SaveToFile(SaveDialog1.FileName);
    Opensql(openlistqqtestADOQuery,'select * from daijiahaoma where shiguo=false');
    openlistqqtestADOQuery.First;
    while not openlistqqtestADOQuery.Eof do
    begin
      outputqqlist.Add(openlistqqtestADOQuery.fieldbyname('qqhaoma').AsString);
      openlistqqtestADOQuery.Next;
    end;
    outputqqlist.SaveToFile(SaveDialog1.FileName);
    //wrongmsg.Text:=wrongstr;
    outputqqlist.Free;
    showmessage('�����ɹ���');
  end;
end;

procedure TmainForm.BitBtn9Click(Sender: TObject);
begin
  if (length(Edit7.Text)=0)then
  begin
    showmessage('QQ���벻��Ϊ�գ�');
    exit;
  end;
  Opensql(openlistqqtestADOQuery,'select * from daijiahaoma where qqhaoma='''+Edit7.text+'''');
  if openlistqqtestADOQuery.RecordCount=0 then
    Execsql(editlistqqADOQuery,'insert into daijiahaoma(qqhaoma) values('''+Edit7.text+''')')
  else
    showmessage(Edit7.text+'�Ѿ��м�¼��');
  showmessage('��ӳɹ���');
end;

procedure TmainForm.BitBtn10Click(Sender: TObject);
var
importqqlist,wrongmsg:Tstringlist;
i:integer;
lsstr,zhanghao,mima:string;
begin
  OpenDialog1.Filter:='(�����ļ�.txt)|*.txt';
  if OpenDialog1.Execute then
  begin
    importqqlist:=Tstringlist.Create;
    importqqlist.Clear;
    importqqlist.LoadFromFile(OpenDialog1.FileName);
    if importqqlist.Count=0 then
    begin
      showmessage('�����ļ���û�����ݣ�');
      exit;
    end;
    for i:=0 to importqqlist.Count-1 do
    begin
      lsstr:=importqqlist.Strings[i];
      zhanghao:=copy(lsstr,1,pos('----',lsstr)-1);
      mima:=copy(lsstr,pos('----',lsstr)+4,length(lsstr)-pos('----',lsstr)-3);
      Opensql(openkdtestADOQuery,'select * from kdzh where zhanghao='''+zhanghao+'''');
      if openkdtestADOQuery.RecordCount=0 then
        Execsql(editkdADOQuery,'insert into kdzh(zhanghao,mima) values('''+zhanghao+''','''+mima+''')')
      else
      begin
        Execsql(editkdADOQuery,'update kdzh set mima='''+mima+''' where zhanghao='''+zhanghao+'''');
      end;
    end;
    showmessage('����ɹ���');
    importqqlist.Free;
    Opensql(openkdADOQuery,'select * from kdzh');
  end;
end;

procedure TmainForm.BitBtn11Click(Sender: TObject);
begin
  if (length(Edit11.Text)=0)or(length(Edit12.Text)=0)then
  begin
    showmessage('�˺ź����������Ϊ�գ�');
    exit;
  end;
  Opensql(openkdtestADOQuery,'select * from kdzh where zhanghao='''+Edit11.Text+'''');
  if openkdtestADOQuery.RecordCount=0 then
    Execsql(editkdADOQuery,'insert into kdzh(zhanghao,mima) values('''+Edit11.Text+''','''+Edit12.Text+''')')
  else
  begin
    Execsql(editkdADOQuery,'update kdzh set mima='''+Edit12.Text+''' where zhanghao='''+Edit11.Text+'''');
  end;
  showmessage('�༭�ɹ���');
  Opensql(openkdADOQuery,'select * from kdzh');
end;

procedure TmainForm.BitBtn12Click(Sender: TObject);
begin
  Execsql(editkdADOQuery,'delete from kdzh where zhanghao='''+openkdADOQuery.fieldbyname('zhanghao').AsString+'''');
  showmessage('ɾ���ɹ���');
  Opensql(openkdADOQuery,'select * from kdzh');
end;

procedure TmainForm.BitBtn13Click(Sender: TObject);
begin
  //setmac(getranmac,'Realtek PCIe GBE Family Controller');
  //funSetComputerName('wer2014');
  //showmessage('�ɹ���');
  doform.Show;
  {showmessage(copy(ComboBox1.Text,1,pos('-',ComboBox1.Text)-2));
  setmac(getranmac,ComboBox1.Text);}
end;

procedure TmainForm.QQpathEditChange(Sender: TObject);
begin
  QQpathEdit2.ItemIndex:=QQpathEdit.ItemIndex;
  QQpath2Edit.ItemIndex:=QQpathEdit.ItemIndex;
end;

procedure TmainForm.SpeedButton1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TmainForm.Label39Click(Sender: TObject);
begin
  if ld<=1 then
  begin
    regform.ShowModal;
  end;
end;

procedure TmainForm.WebBrowser1DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var  
HTML1: IHTMLDocument2;
ele1: IHTMLelement;
dates,times:string;
begin
  if WebBrowser1.Application = pDisp then
  begin
    HTML1:= WebBrowser1.document as IHTMLDocument2;
    dates:=(HTML1.all.item('date',0)  as IHTMLelement).outerText;
    times:=(HTML1.all.item('time',0)  as IHTMLelement).outerText;
    rightdatetime:=strtodatetime('2014-'+copy(dates,1,pos('��',dates)-1)+'-'+copy(dates,pos('��',dates)+2,2)+' '+times);
    //showmessage(datetimetostr(rightdatetime));
  end;
end;

procedure TmainForm.Timer3Timer(Sender: TObject);
begin
  Label40.Caption:=formatdatetime('yyyy��mm��dd��hhʱnn��ss��',now);
  asm
  db $EB,$10,'VMProtect begin',0
  end;
         //2014-05-05 20:15:15
  ld:=0;
  nus:=0;    //showmessage(std);
  if length(std)>=17 then
  begin
    rightdatetime:=DateUtils.IncSecond(rightdatetime,1);
    if strtodatetime(std)>rightdatetime then
    begin
      ld:=DaysBetween(strtodatetime(std),rightdatetime);
      nus:=DaysBetween(strtodatetime(std),rightdatetime);
      //showmessage(inttostr(ld));
    end
    else
    begin
      ld:=0;
      nus:=0;
    end;
  end;
  asm
  db $EB,$0E,'VMProtect end',0
  end;
end;

procedure TmainForm.WebBrowser2DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
HTML1: IHTMLDocument2;
ele1: IHTMLelement;
bodystr:string;
begin
  if WebBrowser2.Application = pDisp then
  begin
    HTML1:= WebBrowser2.document as IHTMLDocument2;
    bodystr:=HTML1.body.outerText;
    nowip:=copy(bodystr,pos('[',bodystr)+1,pos(']',bodystr)-1-pos('[',bodystr));
  end;
end;

procedure TmainForm.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Handle,   WM_SYSCOMMAND,   $F012,   0);
end;

procedure TmainForm.Label38MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Handle,   WM_SYSCOMMAND,   $F012,   0);
end;

procedure TmainForm.Label39MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {ReleaseCapture;
  SendMessage(Handle,   WM_SYSCOMMAND,   $F012,   0);}
end;

procedure TmainForm.Label40MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Handle,   WM_SYSCOMMAND,   $F012,   0);
end;

procedure TmainForm.Button1Click(Sender: TObject);
begin
  showmessage(inttostr(nus));
end;

procedure TmainForm.BitBtn14Click(Sender: TObject);
begin
  if (length(Edit9.Text)=0)or(length(Edit10.Text)=0) then
  begin
    showmessage('���Դ��������ʱ�䶼����Ϊ�գ�');
    Exit;
  end;
  Execsql(editsetADOQuery,'update softset set trytime='''+Edit9.Text+''',septime='''+Edit10.Text+'''');
  showmessage('����ɹ���');
end;

procedure TmainForm.N3Click(Sender: TObject);
begin
  outputmainqqlist('������');
end;

procedure TmainForm.N4Click(Sender: TObject);
begin
  outputmainqqlist('����ģʽ');
end;

procedure TmainForm.N5Click(Sender: TObject);
begin
  outputmainqqlist('�������');
end;

procedure TmainForm.N6Click(Sender: TObject);
begin
  outputmainqqlist('�ʻ�������');
end;

procedure TmainForm.N7Click(Sender: TObject);
begin
  outputmainqqlist('�ʻ�������');
end;

procedure TmainForm.Label5Click(Sender: TObject);
var
verts:tstringlist;
ruanjianmingchen,chubanriqi,zuixinbanben,zuixinbanbenriqi,banbengengxinren,ruanjiankaifaren,lianxiren,lianxifangshi,taobaoming,dianpudizhi,gengxinxinxi:string;
begin
  try
    if length(Edit13.text)>0 then
    begin
      if InternetCheckConnection(pchar('http://'+Edit13.text+'/addqqsoftdd.txt'),1,0) then
        if DownloadFile('http://'+Edit13.text+'/addqqsoftdd.txt',apppath+'version.txt')then
        begin
          verts:=tstringlist.Create;
          verts.LoadFromFile(apppath+'version.txt');
          ruanjianmingchen:=copy(verts.Strings[0],11,length(verts.Strings[0])-10);
          chubanriqi:=copy(verts.Strings[1],11,length(verts.Strings[1])-10);
          zuixinbanben:=copy(verts.Strings[2],11,length(verts.Strings[2])-10);
          zuixinbanbenriqi:=copy(verts.Strings[3],15,length(verts.Strings[3])-14);
          banbengengxinren:=copy(verts.Strings[4],13,length(verts.Strings[4])-12);
          ruanjiankaifaren:=copy(verts.Strings[5],13,length(verts.Strings[5])-12);
          lianxiren:=copy(verts.Strings[6],9,length(verts.Strings[6])-8);
          lianxifangshi:=copy(verts.Strings[7],11,length(verts.Strings[7])-10);
          taobaoming:=copy(verts.Strings[8],7,length(verts.Strings[8])-6);
          dianpudizhi:=copy(verts.Strings[9],9,length(verts.Strings[9])-10);
          gengxinxinxi:=copy(verts.Strings[10],9,length(verts.Strings[10])-10);
          if strtofloat(zuixinbanben)>strtofloat(verLbl.Caption)then
          begin
            if Application.MessageBox(PChar(banbengengxinren+'��'+zuixinbanbenriqi+'������'+zuixinbanben+'�汾,�Ƿ�������'),'������ʾ',MB_OKCANCEL+MB_ICONQUESTION) = IDOK then
              if DownloadFile('http://'+Edit13.text+'/addqqsoft.txt',apppath+'stup.exe')then
                ShellExecute(handle, 'open',pchar(apppath+'stup.exe'),pchar(application.exename),nil, SW_SHOWNORMAL);
          end
          else
            showmessage('�Ѿ������°汾��');
          verts.Free;
        end;
    end
    else
      showmessage('��������������������/������/IP��');
  except
  end;
end;

procedure TmainForm.Timer1Timer(Sender: TObject);
var
verts:tstringlist;
ruanjianmingchen,chubanriqi,zuixinbanben,zuixinbanbenriqi,banbengengxinren,ruanjiankaifaren,lianxiren,lianxifangshi,taobaoming,dianpudizhi,gengxinxinxi:string;
begin
  try
    if length(Edit13.text)>0 then
      if InternetCheckConnection(pchar('http://'+Edit13.text+'/addqqsoftdd.txt'),1,0) then
        if DownloadFile('http://'+Edit13.text+'/addqqsoftdd.txt',apppath+'version.txt')then
        begin
          verts:=tstringlist.Create;
          verts.LoadFromFile(apppath+'version.txt');
          ruanjianmingchen:=copy(verts.Strings[0],11,length(verts.Strings[0])-10);
          chubanriqi:=copy(verts.Strings[1],11,length(verts.Strings[1])-10);
          zuixinbanben:=copy(verts.Strings[2],11,length(verts.Strings[2])-10);
          zuixinbanbenriqi:=copy(verts.Strings[3],15,length(verts.Strings[3])-14);
          banbengengxinren:=copy(verts.Strings[4],13,length(verts.Strings[4])-12);
          ruanjiankaifaren:=copy(verts.Strings[5],13,length(verts.Strings[5])-12);
          lianxiren:=copy(verts.Strings[6],9,length(verts.Strings[6])-8);
          lianxifangshi:=copy(verts.Strings[7],11,length(verts.Strings[7])-10);
          taobaoming:=copy(verts.Strings[8],7,length(verts.Strings[8])-6);
          dianpudizhi:=copy(verts.Strings[9],9,length(verts.Strings[9])-10);
          gengxinxinxi:=copy(verts.Strings[10],9,length(verts.Strings[10])-10);
          if strtofloat(zuixinbanben)>strtofloat(verLbl.Caption)then
          begin
            //if Application.MessageBox(PChar(banbengengxinren+'��'+zuixinbanbenriqi+'������'+zuixinbanben+'�汾,�Ƿ�������'),'������ʾ',MB_OKCANCEL+MB_ICONQUESTION) = IDOK then
              if DownloadFile('http://'+Edit13.text+'/addqqsoft.txt',apppath+'stup.exe')then
                ShellExecute(handle, 'open',pchar(apppath+'stup.exe'),pchar(application.exename),nil, SW_SHOWNORMAL);
          end;
          verts.Free;
        end;
  except
  end;
end;

procedure TmainForm.BitBtn15Click(Sender: TObject);
begin
  if MessageBox(Handle, 'ȷ��Ҫ������к�����', '��պ���',MB_ICONQUESTION or MB_OKCANCEL) = IDOK then
  begin
    Execsql(editmainqqADOQuery,'delete from zhuhaoma');
    Opensql(openmainqqADOQuery,'select * from zhuhaoma order by id');
    showmessage('��ճɹ���');
  end;
end;

procedure TmainForm.BitBtn16Click(Sender: TObject);
begin
  if MessageBox(Handle, 'ȷ��Ҫ������к�����', '��պ���',MB_ICONQUESTION or MB_OKCANCEL) = IDOK then
  begin
    Execsql(editlistqqADOQuery,'delete from daijiahaoma');
    Opensql(openlistqqADOQuery,'select * from daijiahaoma order by id');
    showmessage('��ճɹ���');
  end;
end;

procedure TmainForm.BitBtn17Click(Sender: TObject);
begin
  deletetempfile;
end;

end.
