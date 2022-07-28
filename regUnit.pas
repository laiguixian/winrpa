unit regUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,registry,nb30;

type
  TregForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  regForm: TregForm;

implementation

{$R *.dfm}
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

function NBGetAdapterAddress(a: Integer): string;
var
NCB: TNCB; // Netbios control block //NetBios控制块
ADAPTER: TADAPTERSTATUS; // Netbios adapter status//取网卡状态
LANAENUM: TLANAENUM; // Netbios lana
intIdx: Integer; // Temporary work value//临时变量
cRC: Char; // Netbios return code//NetBios返回值
strTemp: string; // Temporary string//临时变量
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
  Randomize;//初始化随机种子
  str:=copy(nzs,random(length(nzs))+1,1)+str;
  Randomize;//初始化随机种子
  str:=copy(nzs,random(length(nzs))+1,1)+str;
  Randomize;//初始化随机种子
  str:=str+copy(nzs,random(length(nzs))+1,1);
  Randomize;//初始化随机种子
  str:=str+copy(nzs,random(length(nzs))+1,1);
  Randomize;//初始化随机种子
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
      showmessage('系统问题！');
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
      if ((pos('PHYSICAL ADDRESS',UpperCase(cmdrstr.Strings[i]))>0) or (pos('物理地址',UpperCase(cmdrstr.Strings[i]))>0))and not fiyn then
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
   matstr:=UpperCase(macstr);   //showmessage(inttostr(length(matstr)));//showmessage(matstr);
   if length(matstr)<>17 then
      matstr:=UpperCase(NBGetAdapterAddress(0));
   if length(matstr)>0 then
   begin
      reg:=tregistry.create;
      with reg do //设置写入注册表并读出
      begin
         RootKey:=HKEY_CURRENT_USER;
         if OpenKey('SOFTWARE\TDR\addqqsoftdd',True) then
         begin
            WriteString('physi',ghhte(matstr));
         end;
         closekey;
      end;
     reg.Free;
   end;
   if length(matstr)=0 then
   begin
      reg:=tregistry.create;
      with reg do //设置写入注册表并读出
      begin
         RootKey:=HKEY_CURRENT_USER;
         if OpenKey('SOFTWARE\TDR\addqqsoftdd',True) then
         begin
            matstr:=fdgd(ReadString('physi'));
         end;
         closekey;
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
   cmdrstr.Free;
   asm
   db $EB,$0E,'VMProtect end',0
   end;
end;
procedure TregForm.BitBtn1Click(Sender: TObject);
var
reg:tregistry;
begin
  {edit1.Text:=uppercase('5hdfhgf32hhg');
  edit2.Text:=ghhte(edit1.Text);
  edit3.Text:=fdgd(edit2.Text);}
  //showmessage(enstr1(uppercase('wesfds2324')));
  reg:=tregistry.create;
  with reg do //设置写入注册表并读出
  begin
     RootKey:=HKEY_CURRENT_USER;
     if OpenKey('SOFTWARE\TDR\addqqsoftdd',True) then
     begin
        WriteString('regstr',Memo1.Text);
        showmessage('已经写入注册，重新打开软件后生效！');
        Self.Close;
     end;
     closekey;
  end;
  reg.Free;
end;

procedure TregForm.FormCreate(Sender: TObject);
begin
  edit1.Text:=getmpstr(1)+'-'+getmpstr(2);
end;

end.
