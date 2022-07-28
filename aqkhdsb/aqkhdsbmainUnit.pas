unit aqkhdsbmainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,ShlObj,ComObj,ShellApi,StdCtrls, Mask,Clipbrd,math,IdHTTP,
  DB, ADODB,Tlhelp32,IdSMTP,IdMessage,IdAttachmentfile, Buttons, TeeProcs,
  TeEngine, Chart, ComCtrls;

type
  TdoForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Image4: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label31: TLabel;
    QQpathEdit: TEdit;
    Memo1: TMemo;
    nowhandelEdit: TEdit;
    Button3: TButton;
    qquserEdit: TEdit;
    qqpwdEdit: TMaskEdit;
    Memo2: TMemo;
    Memo3: TMemo;
    Edit5: TEdit;
    Edit6: TEdit;
    Button1: TButton;
    Button2: TButton;
    checkinfoedit: TEdit;
    Button4: TButton;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit15: TEdit;
    Button8: TButton;
    Button5: TButton;
    waddqqMemo: TMemo;
    Button6: TButton;
    Button7: TButton;
    waittimeEdit: TEdit;
    CheckBox1: TCheckBox;
    Button11: TButton;
    Button9: TButton;
    OpenDialog1: TOpenDialog;
    opendamaADOQuery: TADOQuery;
    opencodeADOQuery: TADOQuery;
    editsuodingADOQuery: TADOQuery;
    editmainqqADOQuery: TADOQuery;
    editlistqqADOQuery: TADOQuery;
    editevenADOQuery: TADOQuery;
    editcodeADOQuery: TADOQuery;
    ADOConnection1: TADOConnection;
    Button10: TButton;
    TabSheet2: TTabSheet;
    Chart1: TChart;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    procedure Memo1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    function yzmmultixotxt(var MS:TMemoryStream; yhm,mm,bm:string):string;
    procedure FormDestroy(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  doForm: TdoForm;
  apppath:string;
  nowcodeid,onlyoneid:string;
  bsddyx:boolean;//不是单独运行
  damauser,damapwd,damacode:string;
  bmpts:tstringlist;        //bmp模板
  imagemodel:Timage;        //bmp模板
  function EnumWindowsProc1(AhWnd:LongInt;AForm:TdoForm):boolean;stdcall;
  function EnumWindowsProc2(AhWnd:LongInt;AForm:TdoForm):boolean;stdcall;


implementation

uses codeUnit,funcs, controlmain;

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

function EnumWindowsProc1(AhWnd:LongInt;AForm:TdoForm):boolean;

var
   lpszClassName,lpszWindowText:array[0..254] of char;
begin
   GetWindowText(AhWnd,lpszWindowText,100);
   doForm.memo1.lines.add(inttostr(AhWnd)+';'+StrPas(lpszWindowText));
   Result:=True;
end;

function EnumWindowsProc2(AhWnd:LongInt;AForm:TdoForm):boolean;

var
   lpszClassName,lpszWindowText:array[0..254] of char;
begin
   GetWindowText(AhWnd,lpszWindowText,100);
   doForm.memo3.lines.add(inttostr(AhWnd)+';'+StrPas(lpszWindowText));
   Result:=True;
end;


procedure TdoForm.Memo1Click(Sender: TObject);
begin
  //nowhandelEdit.Text:=memo1.SelText;
end;


function ForceForegroundWindow(hwnd: THandle): boolean;
const
    SPI_GETFOREGROUNDLOCKTIMEOUT = $2000;
    SPI_SETFOREGROUNDLOCKTIMEOUT = $2001;
var
    ForegroundThreadID: DWORD;
    ThisThreadID      : DWORD;
    timeout           : DWORD;
begin
    if IsIconic(hwnd) then ShowWindow(hwnd, SW_RESTORE);

    // Windows 98/2000 doesn't want to foreground a window when some other
    // window has keyboard focus

    if ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion > 4))
        or
        ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
        ((Win32MajorVersion > 4) or ((Win32MajorVersion = 4) and
         (Win32MinorVersion > 0)))) then begin
        // Code from Karl E. Peterson, www.mvps.org/vb/sample.htm
        // Converted to Delphi by Ray Lischner
        // Published in The Delphi Magazine 55, page 16

        Result := false;
        ForegroundThreadID := GetWindowThreadProcessID(GetForegroundWindow,nil);
        ThisThreadID := GetWindowThreadPRocessId(hwnd,nil);
        if AttachThreadInput(ThisThreadID, ForegroundThreadID, true) then begin
            BringWindowToTop(hwnd); // IE 5.5 related hack
            SetForegroundWindow(hwnd);
            AttachThreadInput(ThisThreadID, ForegroundThreadID, false);
            Result := (GetForegroundWindow = hwnd);
        end;

        if not Result then begin
            // Code by Daniel P. Stasinski
            SystemParametersInfo(SPI_GETFOREGROUNDLOCKTIMEOUT, 0, @timeout, 0);
            SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(0), SPIF_SENDCHANGE);
            BringWindowToTop(hwnd); // IE 5.5 related hack
            SetForegroundWindow(hWnd);
            SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(timeout), SPIF_SENDCHANGE);
        end;
    end
    else begin
        BringWindowToTop(hwnd); // IE 5.5 related hack
        SetForegroundWindow(hwnd);
    end;

    Result := (GetForegroundWindow = hwnd);
end;

function inputstr(instr:string;charts:tstringlist):boolean;
var
i:integer;
begin
  result:=false;
  try
    for i:=0 to 30 do                                //删除编辑框内容
    begin
      keybd_event(8,0,0,0);
      keybd_event(8,0,KEYEVENTF_KEYUP,0);
    end;
    for i:=0 to 30 do
    begin
      keybd_event(46,0,0,0);
      keybd_event(46,0,KEYEVENTF_KEYUP,0);
    end;
    for i:=1 to length(instr) do
    begin
      if instr[i] in ['a'..'z'] then
      begin
        keybd_event(strtoint(charts.Strings[charts.IndexOf(instr[i])+1]),0,0,0);
        keybd_event(strtoint(charts.Strings[charts.IndexOf(instr[i])+1]),0,KEYEVENTF_KEYUP,0);
      end
      else if instr[i] in ['A'..'Z'] then
      begin
        keybd_event(16,0,0,0);
        keybd_event(strtoint(charts.Strings[charts.IndexOf(instr[i])+1]),0,0,0);
        keybd_event(strtoint(charts.Strings[charts.IndexOf(instr[i])+1]),0,KEYEVENTF_KEYUP,0);
        keybd_event(16,0,KEYEVENTF_KEYUP,0);
      end
      else if instr[i] in ['0'..'9','`','-','=','\','[',']',';','''',',','.','/'] then
      begin
        keybd_event(strtoint(charts.Strings[charts.IndexOf(instr[i])+1]),0,0,0);
        keybd_event(strtoint(charts.Strings[charts.IndexOf(instr[i])+1]),0,KEYEVENTF_KEYUP,0);
      end
      else if instr[i] in [')','!','@','#','$','%','^','&','*','(',')','~','_','+','|','{','}',':','"','<','>','?'] then
      begin
        keybd_event(16,0,0,0);
        keybd_event(strtoint(charts.Strings[charts.IndexOf(instr[i])+1]),0,0,0);
        keybd_event(strtoint(charts.Strings[charts.IndexOf(instr[i])+1]),0,KEYEVENTF_KEYUP,0);
        keybd_event(16,0,KEYEVENTF_KEYUP,0);
      end;
      sleep(50);
    end;
    result:=true;
  except
    result:=false;
  end;
end;

function twovalue(inbmp:TBitMap;limvalue:integer):TBitMap;
var
p: PByteArray;
X: Integer;
Y: Integer;
colorint:array[0..255] of integer;
i:integer;
maxi:extended;
nowcolor:integer;
tempbmp:tbitmap;
begin
  //self.DoubleBuffered:=true;
  for i:=0 to 255 do
    colorint[i]:=0;
  tempbmp:=tbitmap.Create;                                //取图
  tempbmp.Canvas.Lock;
  tempbmp.Width  := inbmp.Width;
  tempbmp.Height := inbmp.Height;
  tempbmp.pixelformat := pf24bit;
  tempbmp.canvas.draw(0,0,inbmp);
  for y := 0 to tempbmp.Height - 1 do                           //取灰度分布
  begin
      p := tempbmp.scanline[y];
      for x := 0 to tempbmp.Width - 1 do
      begin  //首先将图像灰度化
          nowcolor := Round(p[x * 3 + 2] * 0.3 + p[x * 3 + 1] * 0.59 + p[x
              * 3] * 0.11);
          colorint[nowcolor]:=colorint[nowcolor]+1;
      end;
  end;
  maxi:=0;                                                    //按临界值选取灰度阀值
  i:=0;
  while maxi*100/(tempbmp.Height*tempbmp.Width)<limvalue do
  begin
    maxi:=maxi+colorint[i];
    i:=i+1;
  end; //showmessage(floattostr(maxi)+';'+inttostr(tempbmp.Height)+';'+inttostr(tempbmp.Width)+';'+inttostr(i));
  for y := 0 to tempbmp.Height - 1 do
  begin
      p := tempbmp.scanline[y];
      for x := 0 to tempbmp.Width - 1 do
      begin  //首先将图像灰度化
          nowcolor := Round(p[x * 3 + 2] * 0.3 + p[x * 3 + 1] * 0.59 + p[x
              * 3] * 0.11);
          //colorint[nowcolor]:=colorint[nowcolor]+1;
          if nowcolor >i then //按阀值进行二值化
          begin
              p[x * 3] := 255;
              p[x * 3 + 1] := 255;
              p[x * 3 + 2] := 255;
          end
          else
          begin
              p[x * 3] := 0;
              p[x * 3 + 1] := 0;
              p[x * 3 + 2] := 0;
          end;
      end;
  end;
  tempbmp.Canvas.unLock;
  result:=Tbitmap.Create;
  result.Assign(tempbmp);
  tempbmp.Free;
end;

function twovalue2(inbmp:TBitMap;limvalue:integer):TBitMap;
var
p: PByteArray;
X: Integer;
Y: Integer;
colorint:array[0..255] of integer;
i:integer;
maxi:extended;
nowcolor:integer;
tempbmp,tempbmp2:tbitmap;
minx,miny,maxx,maxy:integer;
begin
  //self.DoubleBuffered:=true;
  for i:=0 to 255 do
    colorint[i]:=0;
  tempbmp:=tbitmap.Create;                                //取图
  tempbmp.Width  := inbmp.Width;
  tempbmp.Height := inbmp.Height;
  tempbmp.pixelformat := pf24bit;
  tempbmp.canvas.draw(0,0,inbmp);
  for y := 0 to tempbmp.Height - 1 do                           //取灰度分布
  begin
      p := tempbmp.scanline[y];
      for x := 0 to tempbmp.Width - 1 do
      begin  //首先将图像灰度化
          nowcolor := Round(p[x * 3 + 2] * 0.3 + p[x * 3 + 1] * 0.59 + p[x
              * 3] * 0.11);
          colorint[nowcolor]:=colorint[nowcolor]+1;
      end;
  end;
  maxi:=0;                                                    //按临界值选取灰度阀值
  i:=255;
  while maxi*100/(tempbmp.Height*tempbmp.Width)<limvalue do
  begin
    maxi:=maxi+colorint[i];
    i:=i-1;
  end; //showmessage(floattostr(maxi)+';'+inttostr(tempbmp.Height)+';'+inttostr(tempbmp.Width)+';'+inttostr(i));
  for y := 0 to tempbmp.Height - 1 do
  begin
      p := tempbmp.scanline[y];
      for x := 0 to tempbmp.Width - 1 do
      begin  //首先将图像灰度化
          nowcolor := Round(p[x * 3 + 2] * 0.3 + p[x * 3 + 1] * 0.59 + p[x
              * 3] * 0.11);
          //colorint[nowcolor]:=colorint[nowcolor]+1;
          if nowcolor <i then //按阀值进行二值化
          begin
              p[x * 3] := 0;
              p[x * 3 + 1] := 0;
              p[x * 3 + 2] := 0;
          end
          else
          begin
              p[x * 3] := 255;
              p[x * 3 + 1] := 255;
              p[x * 3 + 2] := 255;
          end;
      end;
  end;
  minx:=tempbmp.Width - 1;
  miny:=tempbmp.Height - 1;
  maxx:=0;
  maxy:=0;
  for y:=0 to tempbmp.Height - 1 do
  begin
    for x:=0 to tempbmp.Width - 1 do
    begin
      if tempbmp.Canvas.Pixels[x,y]=clblack then
      begin
        if minx>x then
          minx:=x;
        if miny>y then
          miny:=y;
        if maxx<x then
          maxx:=x;
        if maxy<y then
          maxy:=y;
      end;
    end;
  end;
  tempbmp2:=tbitmap.Create;                                //取轮廓
  tempbmp2.Width  := maxx-minx;
  tempbmp2.Height := maxy-miny;
  tempbmp2.pixelformat := pf24bit;
  //tempbmp2.Canvas.CopyRect(rect(1,1,maxx-minx-1,maxy-miny-1),tempbmp.Canvas,rect(minx,miny,maxx,maxy));
  tempbmp2.Canvas.CopyRect(rect(0,0,maxx-minx,maxy-miny),tempbmp.Canvas,rect(minx,miny,maxx,maxy));
  tempbmp.Assign(tempbmp2);
  for y:=0 to tempbmp.Height - 1 do
  begin
    for x:=0 to tempbmp.Width - 1 do
    begin
      if tempbmp.Canvas.Pixels[x,y]=clblack then
      begin
        tempbmp.Canvas.Pixels[x,y]:=clwhite;
      end
      else
      begin
        tempbmp.Canvas.Pixels[x,y]:=clblack;
      end;
    end;
  end;
  //showmessage(inttostr(tempbmp.Width)+';'+inttostr(tempbmp.Height));
  result:=Tbitmap.Create;
  result.Assign(tempbmp);
  tempbmp.Free;
  tempbmp2.Free;
end;

function twovalue3(inbmp:TBitMap;limvalue:integer):TBitMap;
var
p: PByteArray;
X: Integer;
Y: Integer;
colorint:array[0..255] of integer;
i:integer;
maxi:extended;
nowcolor:integer;
tempbmp:tbitmap;
begin
  //self.DoubleBuffered:=true;
  for i:=0 to 255 do
    colorint[i]:=0;
  tempbmp:=tbitmap.Create;                                //取图
  tempbmp.Canvas.Lock;
  tempbmp.Width  := inbmp.Width;
  tempbmp.Height := inbmp.Height;
  tempbmp.pixelformat := pf24bit;
  tempbmp.canvas.draw(0,0,inbmp);
  for y := 0 to tempbmp.Height - 1 do
  begin
      p := tempbmp.scanline[y];
      for x := 0 to tempbmp.Width - 1 do
      begin  //首先将图像灰度化
          nowcolor := Round(p[x * 3 + 2] * 0.3 + p[x * 3 + 1] * 0.59 + p[x
              * 3] * 0.11);
          //colorint[nowcolor]:=colorint[nowcolor]+1;
          if nowcolor >limvalue then //按阀值进行二值化
          begin
              p[x * 3] := 255;
              p[x * 3 + 1] := 255;
              p[x * 3 + 2] := 255;
          end
          else
          begin
              p[x * 3] := 0;
              p[x * 3 + 1] := 0;
              p[x * 3 + 2] := 0;
          end;
      end;
  end;
  tempbmp.Canvas.unLock;
  result:=Tbitmap.Create;
  result.Assign(tempbmp);
  tempbmp.Free;
end;

function isyzm(inbmp:TBitMap):boolean;
var
p: PByteArray;
X: Integer;
Y: Integer;
tol:integer;
maxi:extended;
nowcolor:integer;
tempbmp:tbitmap;
yzm:boolean;
begin
  result:=false;
  try
    yzm:=true;
    tol:=0;
    tempbmp:=tbitmap.Create;                                //取图
    //tempbmp.Canvas.Lock;
    tempbmp.Width  := inbmp.Width;
    tempbmp.Height := inbmp.Height;
    tempbmp.pixelformat := pf24bit;
    //tempbmp.canvas.draw(0,0,inbmp);
    tempbmp.canvas.CopyRect(rect(0,0,tempbmp.Width,tempbmp.Height),inbmp.canvas,rect(0,0,tempbmp.Width,tempbmp.Height));
    tempbmp.Assign(twovalue3(tempbmp,240));
    doform.Image3.Picture.Bitmap.Assign(tempbmp);
    codeform.Show;
    codeform.Hide;
    if yzm then
      for y := 0 to 2 do
        for x := 0 to tempbmp.Width - 1 do
          if tempbmp.Canvas.Pixels[x,y]=clblack then
            yzm:=false;
    if yzm then
      for y := tempbmp.Height - 3 to tempbmp.Height - 1 do
        for x := 0 to tempbmp.Width - 1 do
          if tempbmp.Canvas.Pixels[x,y]=clblack then
            yzm:=false;
    if yzm then
      for y := 0 to tempbmp.Height - 1 do
        for x := 0 to 2 do
          if tempbmp.Canvas.Pixels[x,y]=clblack then
            yzm:=false;
    if yzm then
      for y := 0 to tempbmp.Height - 1 do
        for x := tempbmp.Width - 3 to tempbmp.Width - 1 do
          if tempbmp.Canvas.Pixels[x,y]=clblack then
            yzm:=false;
    if yzm then
      for y := 0 to tempbmp.Height - 1 do
          for x := 0 to tempbmp.Width - 1 do
            if tempbmp.Canvas.Pixels[x,y]=clblack then
              tol:=tol+1;
    if yzm then
      //showmessage(floattostr(tol/(tempbmp.Height*tempbmp.Width)));
      if tol/(tempbmp.Height*tempbmp.Width)<0.01 then
        yzm:=false;
    //tempbmp.Canvas.unLock;
    tempbmp.Free;
    if yzm then
      result:=true;
  except
    result:=false;
  end;
end;

function bmpisin(smallbmp,bigbmp:TBitMap):integer;
var
X,xi: Integer;
Y,yi: Integer;
tol,bla:Integer;
maxflo:extended;
begin
  result:=-1;
  maxflo:=0;
  {doForm.Image2.Picture.Bitmap.Assign(smallbmp);
  doForm.Image3.Picture.Bitmap.Assign(bigbmp);}
  for y := 0 to bigbmp.Height-smallbmp.Height do                           //取灰度分布
  begin
      for x := 0 to bigbmp.Width-smallbmp.Width do
      begin
        tol:=0;
        bla:=0;  //showmessage('b');
        for yi := 0 to smallbmp.Height - 1 do                           //取灰度分布
        begin
            for xi := 0 to smallbmp.Width - 1 do
            begin
              if (smallbmp.Canvas.Pixels[xi,yi]=clblack) then
              begin
                tol:=tol+1;
                if (bigbmp.Canvas.Pixels[x+xi,y+yi]=clblack) then
                  bla:=bla+1;
              end;
            end;
        end;
        if bla/tol>0.9 then
        begin   //showmessage('0');
          result:=0;
          maxflo:=0;
          break;
        end;
        if maxflo<bla/tol then
          maxflo:=bla/tol;
      end;
  end;
  if maxflo>0 then
    result:=floor(maxflo*10000);
end;

function bmpissimilar({inbmp1,inbmp2:TBitMap;}bmp1,bmp2:TBitMap;lim:Extended):integer; //图片是否相似 //返回相似度  lim为相似极限 达到即认为一样则返回0
var
X: Integer;
Y: Integer;
tol1,bla1,tol2,bla2,tol,bla:Integer;
maxflo,minflo:extended;
//bmp1,bmp2:TBitMap;
begin
  result:=-1;
  {if not((inbmp1.Height = inbmp2.Height)and(inbmp1.Width = inbmp2.Width)and(inbmp1.PixelFormat = inbmp2.PixelFormat))then
    Exit;
  bmp1:=TBitMap.Create;
  bmp1.Canvas.Lock;
  bmp1.Width  := inbmp1.Width;
  bmp1.Height := inbmp1.Height;
  bmp1.pixelformat := pf24bit;
  bmp1.Canvas.Draw(0,0,inbmp1);
  bmp1.Canvas.unLock;
  bmp2:=TBitMap.Create;
  bmp2.Canvas.Lock;
  bmp2.Width  := inbmp2.Width;
  bmp2.Height := inbmp2.Height;
  bmp2.pixelformat := pf24bit;
  bmp2.Canvas.Draw(0,0,inbmp2);
  bmp2.Canvas.unLock;}
  if not((bmp1.Height = bmp2.Height)and(bmp1.Width = bmp2.Width)and(bmp1.PixelFormat = bmp2.PixelFormat))then
    Exit;
  maxflo:=0;
  minflo:=0;
  tol:=0;
  bla:=0;  //showmessage('b');
  tol1:=0;
  bla1:=0;  //showmessage('b');
  tol2:=0;
  bla2:=0;  //showmessage('b');
  doForm.Image2.Picture.Bitmap.Assign(bmp1);
  doForm.Image3.Picture.Bitmap.Assign(bmp2);
  codeform.Show;
  codeform.Hide;
  for y := 0 to bmp1.Height - 1 do                           //取灰度分布
  begin
      for x := 0 to bmp1.Width - 1 do
      begin  //首先将图像灰度化
        if (bmp1.Canvas.Pixels[x,y]=clblack) then
        begin                                                           
          tol1:=tol1+1;
          if (bmp2.Canvas.Pixels[x,y]=clblack) then
            bla1:=bla1+1;
        end;                                                           
      end;
  end;
  for y := 0 to bmp2.Height - 1 do                           //取灰度分布
  begin
      for x := 0 to bmp2.Width - 1 do
      begin  //首先将图像灰度化
        if (bmp2.Canvas.Pixels[x,y]=clblack) then
        begin
          tol2:=tol2+1;
          if (bmp1.Canvas.Pixels[x,y]=clblack) then
            bla2:=bla2+1;
        end;
      end;
  end; //showmessage(floattostr(minflo));
  //showmessage(inttostr(tol1));
  if (tol1>0) and (tol2>0) then
  begin
    try
      minflo:=bla1/tol1;
      if minflo>bla2/tol2 then
        minflo:=bla2/tol2;
    except
      minflo:=0;
    end;
    //showmessage(floattostr(minflo));
    if {(minflo>0)and}(minflo>=0.6)and(minflo<0.9) then
      result:=floor(minflo*10000)
    else if minflo>=lim then
    begin   //showmessage('0');
      result:=0;
      minflo:=0;
    end;
  end;
end;

function CaptureScreenRect(ARect:TRect;sctype:integer):TBitmap;
var ScreenDC:HDC; //设备描述表的句柄
tempbmp:tbitmap;
begin
result:=TBitmap.Create;
result.Assign(nil);
if sctype=1 then
begin
  with Result,ARect do
  begin
  Width :=Right-left;
  Height:=Bottom-Top;
  ScreenDC:=GetDC(0); //获取一个窗口的设备描述表的句柄，0参数返回屏幕窗口设备描述表的句柄
  try
  //BOOL BitBlt(hdcDest,nXDest,nYDest,nWidth,nHeight,hdcSrc,nXSrc,nYSrc,dwRop)
  //把位图从源设备描述表hdcSrc复制到目标设备描述表hdcDest，
  //光栅操作码dwRop指定了 源图的组合方式
  BitBlt(Canvas.Handle ,0,0,Width,Height,ScreenDC,left,top,SRCCOPY);
  finally
  ReleaseDC(0,ScreenDC);
  end;
  end;
end
else if sctype=2 then
begin
  tempbmp:=tbitmap.Create;
  tempbmp.Assign(nil);
  //while tempbmp=nil do
  //begin
  try
    keybd_event(VK_SNAPSHOT,0,0,0);
    keybd_event(VK_SNAPSHOT,0,KEYEVENTF_KEYUP,0);
    tempbmp.Assign(Clipboard);
  except
  end;
  sleep(1000);
  try
    keybd_event(VK_SNAPSHOT,0,0,0);
    keybd_event(VK_SNAPSHOT,0,KEYEVENTF_KEYUP,0);
    tempbmp.Assign(Clipboard);
  except
  end;
  //end;
  with Result,ARect do
  begin
  Width :=Right-left;
  Height:=Bottom-Top;
  try
  //BOOL BitBlt(hdcDest,nXDest,nYDest,nWidth,nHeight,hdcSrc,nXSrc,nYSrc,dwRop)
  //把位图从源设备描述表hdcSrc复制到目标设备描述表hdcDest，
  //光栅操作码dwRop指定了 源图的组合方式
  Result.Canvas.CopyRect(rect(0,0,Width,Height),tempbmp.Canvas,ARect);
  finally

  end;
  end;
  tempbmp.Free;
end;
end;

function CaptureScreen(AHandle: THandle;
  ALeft,ATop,AWidth, AHeight: Integer):TBitmap;
const
  CAPTUREBLT = $40000000;
var
  FScreenHdc: HDC;
  FCompatibleHdc: HDC;
  FBitmap: TBitmap;
  FHBITMAP: HBITMAP;
begin
  FScreenHdc := GetWindowDC(AHandle);
  try
    FCompatibleHdc := CreateCompatibleDC(FScreenHdc);
    try
      FHBITMAP := CreateCompatibleBitmap(FScreenHdc, AWidth, AHeight);
      SelectObject(FCompatibleHdc, FHBITMAP);
      FBitmap := TBitmap.Create;
      try
        FBitmap.Handle := FHBITMAP;
        BitBlt(FCompatibleHdc, 0, 0, FBitmap.Width, FBitmap.Height, FScreenHdc,
          ALeft,ATop, SRCCOPY or CAPTUREBLT);
        result := TBitmap.Create;
        result.Assign(FBitmap);
        //FBitmap.SaveToFile(AFileName);
      finally
        FBitmap.Free;
      end;
    finally
      DeleteDC(FCompatibleHdc);
    end;
  finally
    DeleteDC(FScreenHdc);
  end;
end;


function getstep(fi,ti:integer;windowhandle:integer):string;
var
tempbmp,capbmp:TBitMap;
maxint,nowint,i,x,y,tol,bla:integer;
rc:tRect;
iscon:boolean;
begin
  result:='';
  maxint:=0;
  //nowint:=-1;
  //showmessage(inttostr(rc.Left)+';'+inttostr(rc.Top));
  {doForm.Image1.Picture.Bitmap.Assign(nil);
  doForm.Image2.Picture.Bitmap.Assign(nil);
  doForm.Image3.Picture.Bitmap.Assign(nil);}
  for i:=fi to ti do
  begin
    if i mod 2=0 then
    begin
      //showmessage(bmpts.Strings[i]);
      GetWindowRect(windowhandle,rc);
      if copy(bmpts.Strings[i+1],1,2)='LT' then
      begin
        iscon:=((strtoint(copy(bmpts.Strings[i+1],3,4))+strtoint(copy(bmpts.Strings[i+1],11,4)))<=rc.Right-rc.Left)and(strtoint(copy(bmpts.Strings[i+1],7,4))+strtoint(copy(bmpts.Strings[i+1],15,4))<=rc.Bottom-rc.Top);
      end
      else if copy(bmpts.Strings[i+1],1,2)='RT' then
      begin
        iscon:=((rc.Right-rc.Left-strtoint(copy(bmpts.Strings[i+1],3,4))+strtoint(copy(bmpts.Strings[i+1],11,4)))<=rc.Right-rc.Left)and(strtoint(copy(bmpts.Strings[i+1],7,4))+strtoint(copy(bmpts.Strings[i+1],15,4))<=rc.Bottom-rc.Top);
      end
      else if copy(bmpts.Strings[i+1],1,2)='LB' then
      begin
        iscon:=((strtoint(copy(bmpts.Strings[i+1],3,4))+strtoint(copy(bmpts.Strings[i+1],11,4)))<=rc.Right-rc.Left)and(rc.Bottom-rc.Top-strtoint(copy(bmpts.Strings[i+1],7,4))+strtoint(copy(bmpts.Strings[i+1],15,4))<=rc.Bottom-rc.Top);
      end;
      //iscon:=true;
      if iscon then
      begin   //showmessage(bmpts.Strings[i]);
        tol:=0;
        bla:=0;
        capbmp:=TBitMap.Create;
        capbmp.Assign(nil);
        capbmp.PixelFormat:=pf24bit;
        GetWindowRect(windowhandle,rc);
        ForceForegroundWindow(windowhandle);
        if copy(bmpts.Strings[i+1],1,2)='LT' then
        begin
          capbmp.Assign(CaptureScreen(windowhandle,strtoint(copy(bmpts.Strings[i+1],3,4)),strtoint(copy(bmpts.Strings[i+1],7,4)),strtoint(copy(bmpts.Strings[i+1],11,4)),strtoint(copy(bmpts.Strings[i+1],15,4))));
        end
        else if copy(bmpts.Strings[i+1],1,2)='RT' then
        begin
          GetWindowRect(windowhandle,rc);
          capbmp.Assign(CaptureScreen(windowhandle,rc.Right-rc.Left-strtoint(copy(bmpts.Strings[i+1],3,4)),strtoint(copy(bmpts.Strings[i+1],7,4)),strtoint(copy(bmpts.Strings[i+1],11,4)),strtoint(copy(bmpts.Strings[i+1],15,4))));
        end
        else if copy(bmpts.Strings[i+1],1,2)='LB' then
        begin
          GetWindowRect(windowhandle,rc);
          capbmp.Assign(CaptureScreen(windowhandle,strtoint(copy(bmpts.Strings[i+1],3,4)),rc.Bottom-rc.Top-strtoint(copy(bmpts.Strings[i+1],7,4)),strtoint(copy(bmpts.Strings[i+1],11,4)),strtoint(copy(bmpts.Strings[i+1],15,4))));
        end;
        capbmp.Assign(twovalue(capbmp,10));
        //doForm.Image1.Picture.Bitmap.Assign(capbmp);
        for y := 0 to capbmp.Height-1 do
          for x := 0 to capbmp.Width-1 do
          begin
            tol:=tol+1;
            if (capbmp.Canvas.Pixels[x,y]=clblack) then
              bla:=bla+1;
          end;
        if (bla/tol<0.8) then
        begin
          tempbmp:=TBitMap.Create;
          tempbmp.Assign(nil);
          tempbmp.PixelFormat:=pf24bit;
          tempbmp.Assign(Timage(doForm.FindComponent(bmpts.Strings[i])).Picture.Bitmap);
          tempbmp.Assign(twovalue(tempbmp,10));
          nowint:=bmpissimilar(tempbmp,capbmp,0.9);
          if nowint=0 then
          begin  //showmessage(inttostr(nowint));
            maxint:=nowint;
            result:=bmpts.Strings[i];
            exit;
          end;
          tempbmp.Free;
        end;
        capbmp.Free;
      end;
    end;
  end;
end;

function readnumformbmp(inbmp:TBitMap):integer;
var
tempbmp,capbmp:TBitMap;
maxint,nowint,i,x,y,tol,bla:integer;
resultstr:string;
begin
  result:=0;
  maxint:=0;
  resultstr:='0';
  x:=0;
  y:=0;
  while y <= inbmp.Height-10 do
  begin  //showmessage('11');
    while x<= inbmp.Width-5 do
    begin
      tol:=tol+1;
      for i:=0 to 9 do
      begin
        tol:=0;
        bla:=0;
        tempbmp:=TBitMap.Create;
        tempbmp.PixelFormat:=pf24bit;
        tempbmp.Assign(Timage(doForm.FindComponent('zm'+inttostr(i))).Picture.Bitmap);
        tempbmp.Assign(twovalue(tempbmp,10));
        capbmp:=TBitMap.Create;
        capbmp.Width:=tempbmp.Width;
        capbmp.Height:=tempbmp.Height;
        capbmp.PixelFormat:=pf24bit;
        capbmp.Canvas.CopyRect(rect(0,0,capbmp.Width,capbmp.Height),inbmp.Canvas,rect(x,y,capbmp.Width+x,capbmp.Height+y));
        nowint:=bmpissimilar(tempbmp,capbmp,0.8);
        if nowint=0 then
        begin  //showmessage(inttostr(nowint));
          resultstr:=resultstr+inttostr(i);
        end;
        tempbmp.Free;
        capbmp.Free;
      end;
        x:=x+1;
    end;
      y:=y+1;
      x:=0;
  end;
  result:=strtoint(resultstr);
end;

function IsBmpSame(bmp1,bmp2: TBitmap): Boolean;            //判断两图片是否一样
var
  i,j: Integer;
  ScanLine1,ScanLine2: PByteArray;
  Count: Integer;
begin
  Result := (bmp1.Height = bmp2.Height) and
            (bmp1.Width = bmp2.Width) and
            (bmp1.PixelFormat = bmp2.PixelFormat);
  if Result then
  begin
    i := Integer(bmp1.PixelFormat);
    if i < 4 then
      i := 4
    else if i = 4 then
      inc(i);
    Count := (i - 3) * bmp1.Width - 1;

    for i:=0 to bmp1.Height-1 do
    begin
      ScanLine1 := bmp1.ScanLine[i];
      ScanLine2 := bmp2.ScanLine[i];
      for j := 0 to Count do
        if ScanLine1[j] <> ScanLine2[j] then
        begin
          Result := False;
          Exit;
        end;
    end;
  end;
end;

function TdoForm.yzmmultixotxt(var MS:TMemoryStream; yhm,mm,bm:string):string;                          //若快打码识别验证码
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

function chaxunmultixotxt(yhm,mm:string):string;                            //若快打码查询余额
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

function baocuomultixotxt(yhm,mm,id:string):string;                            //若快打码报错
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

function getcode(damayhm,damamm:string):string;
var
MS:TMemoryStream;
backres:string;
begin
  try
    with doform do
    begin
      backres:= chaxunmultixotxt(damayhm,damamm);
      if strtoint(copy(backres,pos('"Score":"',backres)+9,pos('","HistoryScore"',backres)-pos('"Score":"',backres)-9))>0 then
      begin
        MS:=TMemoryStream.Create;
        MS.LoadFromFile(apppath+'images\'+nowcodeid+'.bmp');
        backres:= yzmmultixotxt(MS,damayhm,damamm,'2000');
                  //multixotxt(图片字节流,用户名,密码,图片类型编码）
        MS.Free;
        if length(backres)>0 then
        begin
          execsql(editcodeADOQuery,'update code set coderesult='''+copy(backres,1,pos('|',backres)-1)+''',coderesultid='''+copy(backres,pos('|',backres)+1,length(backres)-pos('|',backres))+''' where proid='''+onlyoneid+''' and codeid='''+nowcodeid+'''');
          //bacresult:=copy(backres,1,pos('|',backres)-1);
          result:=copy(backres,1,pos('|',backres)-1);
          //SendMessage(form1.Handle, WM_srbqryzm, 0, 0);
          //srbqryzm(copy(backres,1,pos('|',backres)-1),damaleixing);
        end
        else
        begin
          execsql(editcodeADOQuery,'update code set codecheck=true,coderead=true,coderof=0 where proid='''+onlyoneid+''' and codeid='''+nowcodeid+'''');
          //application.MessageBox('打码平台返回值为空，出现异常，自动退出！','打码异常',MB_iconerror);
          Execsql(editmainqqADOQuery,'update zhuhaoma set zhuangtai=''正常'' where qqhaoma='''+qquserEdit.Text+'''');
          //KillTask('addqqcontrol.exe');
          //Close;
        end;
      end
      else
      begin
        execsql(editcodeADOQuery,'update code set codecheck=true,coderead=true,coderof=0 where proid='''+onlyoneid+''' and codeid='''+nowcodeid+'''');
        //application.MessageBox('余额不够，软件直接退出，请重新打开软件！','打码异常',MB_iconerror);
        Execsql(editmainqqADOQuery,'update zhuhaoma set zhuangtai=''正常'' where qqhaoma='''+qquserEdit.Text+'''');
        //KillTask('addqqcontrol.exe');
        //showmessage('余额不够，软件直接退出，请重新打开软件！');
        //Close;
      end;
      //Timer0.Enabled:=true;
    end;
  except

  end;
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
  smtp.Username := mailuser; //用户名
  smtp.Password := mailpassword; //密码
  smtp.Port:=strtoint(smtpporttxt);    //25
  msgsend := TIdMessage.Create(nil);
  msgsend.Recipients.EMailAddresses := recuser; //收件人地址(多于一个的话用逗号隔开)
  msgsend.From.Address := mailuser+'@qq.com'; //自己的邮箱地址   1115858607@qq.com
  msgsend.Subject :=mailsubject; //邮件标题
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

procedure TdoForm.Button3Click(Sender: TObject);
var
  rc:tRect;
  i,j:integer;
  keystates:TKeyboardState;
  charts:tstringlist;
  lasthandle,stepstr,linshistepstr,nowdatestr:string;
  lastcodebmp,nowcodebmp:Tbitmap;
  notsamebmp:boolean;
  qqmain,qqquery,lasttime,yzmcs,hys:integer;
  tempbmp1,tempbmp2:Tbitmap;
  function exitpro:boolean;           //直接退出进程
  begin
    charts.Free;
    sleep(strtoint(waittimeEdit.Text));
    Button3.Caption:='开始';
    Button3.Enabled:=true;
    abort;
  end;
  function setxyqqmain:boolean;      //移动QQ主界面到10,10的位置
  var
    rc1:tRect;
  begin
    {GetWindowRect(qqmain,rc1);
    if mainform.ComboBox2.Text='虚拟机' then
      movewindow(qqmain,10,10,rc1.Right-rc1.Left,rc1.Bottom-rc1.Top,true)
    else
      SetWindowPos(qqmain, HWND_TOPMOST, 10,10, 100,200, SWP_NOSIZE); //将QQ界面置于顶层并放在坐标10,10的位置}
    GetWindowRect(qqmain,rc1);
    while (rc1.Top>40) or (rc1.Left>40) do
    begin
      if mainform.ComboBox2.Text='虚拟机' then
      begin
        //movewindow(qqmain,10,10,rc1.Right-rc1.Left,rc1.Bottom-rc1.Top,true)
        GetWindowRect(qqmain,rc1);
        SetCursorPos(rc1.Left+16,rc1.Top+16);
        mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
        Randomize;
        SetCursorPos(60+Random(10),60+Random(5));
        Randomize;
        sleep(300+Random(300));
        Randomize;
        SetCursorPos(50+Random(20),40+Random(10));
        Randomize;
        sleep(300+Random(200));
        Randomize;
        SetCursorPos(40+Random(10),40+Random(20));
        Randomize;
        sleep(200+Random(100));
        Randomize;
        SetCursorPos(30+Random(10),30+Random(10));
        Randomize;
        sleep(200+Random(100));
        mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
        sleep(350+Random(300));
      end
      else
        SetWindowPos(qqmain, HWND_TOPMOST, 10,10, 100,200, SWP_NOSIZE); //将QQ界面置于顶层并放在坐标10,10的位置
      GetWindowRect(qqmain,rc1);
    end;
  end;
begin
  if not (Button3.Enabled and (Button3.Caption='开始'))then
    exit;
  Button3.Caption:='停止';
  Button3.Enabled:=false;
  charts:=tstringlist.Create;                        //加载虚拟键值列表
  charts.Text:=memo2.Text;
  Memo1.Lines.Clear;                                 //加载当前系统窗口列表
  EnumWindows(@EnumWindowsProc1,LongInt(self));
  sleep(100);
  ShellExecute(handle, 'open',pchar(QQpathEdit.Text),nil,nil, SW_SHOWNORMAL); //启动QQ
  sleep(2000);
  nowhandelEdit.Text:='nowhandelEdit';
  lasttime:=0;
  while (nowhandelEdit.Text='nowhandelEdit')and(lasttime<=60) do
  begin
    Memo3.Lines.Clear;
    EnumWindows(@EnumWindowsProc2,LongInt(self));
    for i:=0 to Memo3.Lines.Count-1 do
      if pos('QQ International',Memo3.Lines[i])>0 then                 //查找QQ窗口
      begin
        if pos(Memo3.Lines[i],Memo1.Text)=0 then
        begin                       //如果当前找到的QQ窗口不在列表
          //sleep(500);
          ForceForegroundWindow(strtoint(copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1)));
          nowhandelEdit.Text:=copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1);
          linshistepstr:=getstep(6,7,strtoint(nowhandelEdit.Text));         //获得当前阶段
          if length(linshistepstr)>0 then
            stepstr:=linshistepstr;
          //showmessage(stepstr);
          nowhandelEdit.Text:='nowhandelEdit';
          if (stepstr='denglukuang')then
          begin
            nowhandelEdit.Text:=copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1);//则将当前窗口赋予调用值
            break;
          end;
        end;
      end;
    sleep(1000);
    lasttime:=lasttime+1;
    if lasttime>60 then
    begin
      if bsddyx then
        exitpro;
    end;
  end;
  //showmessage(stepstr);
  if (not(stepstr='denglukuang'))and bsddyx then
    exitpro;
  lasthandle:=nowhandelEdit.Text;
  GetKeyboardState(keystates);   //获得键盘状态
  if odd(keystates[VK_CAPITAL]) then     //如果键盘处于Caps Lock状态
  begin
    keybd_event(20,0,0,0);
    keybd_event(20,0,KEYEVENTF_KEYUP,0); //则去除Caps Lock状态
  end;
  GetWindowRect(strtoint(nowhandelEdit.Text),rc);//获取QQ窗口矩形（用于获取窗口坐标）
  ForceForegroundWindow(strtoint(nowhandelEdit.Text));
  SetCursorPos(rc.Left+150,rc.Top+165);  //根据QQ窗口坐标定位到账号输入框
  mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0); //模拟鼠标点击
  mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
  GetWindowRect(strtoint(nowhandelEdit.Text),rc);//获取QQ窗口矩形（用于获取窗口坐标）
  ForceForegroundWindow(strtoint(nowhandelEdit.Text));
  inputstr(qquserEdit.Text,charts);                     //输入账号
  GetWindowRect(strtoint(nowhandelEdit.Text),rc);//获取QQ窗口矩形（用于获取窗口坐标）
  ForceForegroundWindow(strtoint(nowhandelEdit.Text));
  SetCursorPos(rc.Left+150,rc.Top+200);  //根据QQ窗口坐标定位到密码输入框
  mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
  mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
  sleep(300);
  inputstr(qqpwdEdit.Text,charts);                 //输入密码
  Memo1.Lines.Clear;
  EnumWindows(@EnumWindowsProc1,LongInt(self));
  sleep(100);
  //nowhandelEdit.Text:='nowhandelEdit';
  GetWindowRect(strtoint(nowhandelEdit.Text),rc);//获取QQ窗口矩形（用于获取窗口坐标）
  ForceForegroundWindow(strtoint(nowhandelEdit.Text));
  SetCursorPos(rc.Right-226,rc.Bottom-32);
  mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);       //点击登录
  mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
  if bsddyx then
  begin
    Execsql(editmainqqADOQuery,'update zhuhaoma set shiguo=true where qqhaoma='''+qquserEdit.Text+'''');
    Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''QQ登录'',''QQ：'+qquserEdit.Text+'登录'')');
  end;
  sleep(2000);
  lasttime:=0;
  while (stepstr='denglukuang')and(lasttime<=60) do
  begin
    Memo3.Lines.Clear;
    EnumWindows(@EnumWindowsProc2,LongInt(self));
    for i:=0 to Memo3.Lines.Count-1 do
      if pos('QQ International',Memo3.Lines[i])>0 then
        if pos(Memo3.Lines[i],Memo1.Text)=0 then
        begin
          ForceForegroundWindow(strtoint(copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1)));
          if length(getstep(0,17,strtoint(copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1))))>0 then
            nowhandelEdit.Text:=copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1);
        end;
    ForceForegroundWindow(strtoint(nowhandelEdit.Text));
    linshistepstr:=getstep(0,17,strtoint(nowhandelEdit.Text));
    if length(linshistepstr)>0 then
      stepstr:=linshistepstr;
    //showmessage(stepstr);
    sleep(1000);
    lasttime:=lasttime+1;
    if lasttime>60 then
    begin
      if bsddyx then
        exitpro;
    end;
  end;
  if stepstr='yanzhengmakuang' then
  begin
    lastcodebmp:=Tbitmap.Create;
    nowcodebmp:=Tbitmap.Create;
    nowcodebmp.Assign(CaptureScreen(strtoint(nowhandelEdit.Text),87,116,128,51));
    notsamebmp:=(not IsBmpSame(lastcodebmp,nowcodebmp))and (isyzm(nowcodebmp));
    yzmcs:=0;
    lasttime:=0;
    onlyoneid:=formatdatetime('yyyymmddhhnnsszzz',now);
    while (stepstr='yanzhengmakuang')and(yzmcs<=5) and(lasttime<=60)do
    begin
      //nowcodebmp.Assign(CaptureScreen(strtoint(nowhandelEdit.Text),87,116,128,51));
      if notsamebmp then
      begin
        notsamebmp:=false;
        lasttime:=0;
        yzmcs:=yzmcs+1;
        if yzmcs>5 then
        begin
          if bsddyx then
          begin
            Execsql(editcodeADOQuery,'update code set codecheck=true,coderof=2 where proid='''+onlyoneid+''' and (coderof<>1 or coderof is null) and codetype=''denglu''');
            Execsql(editmainqqADOQuery,'update zhuhaoma set zhuangtai=''被限制'',xianzhiyuanyin=''超过五次输入登录验证码'' where qqhaoma='''+qquserEdit.Text+'''');
            Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''账号被限制'',''QQ：'+qquserEdit.Text+'被限制，原因：超过五次输入登录验证码'')');
            exitpro;
          end;
        end;
        nowdatestr:=formatdatetime('yyyymmddhhnnsszzz',now);
        nowcodeid:=nowdatestr+'0';
        Image4.Picture.Bitmap.Assign(nowcodebmp);
        Image4.Picture.Bitmap.SaveToFile(apppath+'images\'+nowcodeid+'.bmp');
        codeForm.Image1.Picture.Bitmap.Assign(nowcodebmp);
        lastcodebmp.Assign(nowcodebmp);
        if bsddyx then
        begin
          Execsql(editcodeADOQuery,'insert into code(proid,codeid,codetype) values('''+onlyoneid+''','''+nowcodeid+''',''denglu'')');
          damacode:=getcode(damauser,damapwd);
          if length(damacode)=0 then
            damacode:='WRUQ';
        end
        else
          //codeForm.show;
          codeForm.showmodal;
        sleep(100);
        GetWindowRect(strtoint(nowhandelEdit.Text),rc);
        ForceForegroundWindow(strtoint(nowhandelEdit.Text));
        SetCursorPos(rc.Left+100,rc.Top+95);
        mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
        mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
        sleep(100);
        if bsddyx then
          inputstr(damacode,charts)
        else
          inputstr(codeForm.Edit1.Text,charts);              //输入验证码
        sleep(100);
        Memo1.Lines.Clear;
        EnumWindows(@EnumWindowsProc1,LongInt(self));
        GetWindowRect(strtoint(nowhandelEdit.Text),rc);
        ForceForegroundWindow(strtoint(nowhandelEdit.Text));
        SetCursorPos(rc.Left+279,rc.Top+275);
        mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
        mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);           //点确定
        sleep(1500);
      end
      else
      begin
        lasttime:=lasttime+1;
        sleep(1000);
        if lasttime>60 then
        begin
          if bsddyx then
            exitpro;
        end;
      end;
      Memo3.Lines.Clear;
      EnumWindows(@EnumWindowsProc2,LongInt(self));
      for i:=0 to Memo3.Lines.Count-1 do
        if pos('QQ International',Memo3.Lines[i])>0 then
          if pos(Memo3.Lines[i],Memo1.Text)=0 then
            nowhandelEdit.Text:=copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1);
      ForceForegroundWindow(strtoint(nowhandelEdit.Text));
      linshistepstr:=getstep(0,17,strtoint(nowhandelEdit.Text));
      if length(linshistepstr)>0 then
        stepstr:=linshistepstr;
      if stepstr='yanzhengmakuang' then
      begin
        nowcodebmp.Assign(CaptureScreen(strtoint(nowhandelEdit.Text),87,116,128,51));
        notsamebmp:=(not IsBmpSame(lastcodebmp,nowcodebmp))and (isyzm(nowcodebmp));
      end;
    end;
    lastcodebmp.Free;
    nowcodebmp.Free;
  end;
  ForceForegroundWindow(strtoint(nowhandelEdit.Text));
  linshistepstr:=getstep(0,17,strtoint(nowhandelEdit.Text));
  if length(linshistepstr)>0 then
    stepstr:=linshistepstr;
  //showmessage(stepstr);
  if (stepstr='chenggongdenglu')or(stepstr='chenggongdenglu1')or(stepstr='chenggongdenglu2') then
  begin
    sleep(3000);
    Memo3.Lines.Clear;
    EnumWindows(@EnumWindowsProc2,LongInt(self));
    for i:=0 to Memo3.Lines.Count-1 do
      if pos('熱鍵衝突',Memo3.Lines[i])>0 then
      begin
        GetWindowRect(strtoint(copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1)),rc);
        ForceForegroundWindow(strtoint(copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1)));
        SetCursorPos(rc.Right-53,rc.Bottom-26);
        mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
        mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
      end;
    if bsddyx then
    begin
      Execsql(editmainqqADOQuery,'update zhuhaoma set zhuangtai=''上线'' where qqhaoma='''+qquserEdit.Text+'''');
      Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''成功登录'',''QQ：'+qquserEdit.Text+'成功登录'')');
      Execsql(editcodeADOQuery,'update code set codecheck=true,coderof=1 where proid='''+onlyoneid+''' and codeid='''+nowcodeid+''' and codetype=''denglu''');
      Execsql(editcodeADOQuery,'update code set codecheck=true,coderof=0 where proid='''+onlyoneid+''' and (coderof<>1 or coderof is null) and codetype=''denglu''');
    end;
    lasthandle:=nowhandelEdit.Text;
    qqmain:=strtoint(nowhandelEdit.Text);
    lasttime:=0;
    setxyqqmain;
    GetWindowRect(qqmain,rc);
    while (lasthandle=nowhandelEdit.Text)and(lasttime<=20) do
    begin
      SetCursorPos(rc.Left+53,rc.Bottom-23);
      setxyqqmain;
      mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);                                   //点击查找好友
      mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
      sleep(1000);
      Memo3.Lines.Clear;
      EnumWindows(@EnumWindowsProc2,LongInt(self));
      for i:=0 to Memo3.Lines.Count-1 do
        if pos('查找聯繫人',Memo3.Lines[i])>0 then
          nowhandelEdit.Text:=copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1);
      sleep(1000);
      lasttime:=lasttime+1;
      if lasttime>20 then
      begin
        if bsddyx then
          exitpro;
      end;
    end;
    for j:=0 to waddqqMemo.Lines.Count-1 do
    begin
      //deletetempcookie;
      //deletetempfile;
      Memo3.Lines.Clear;
      EnumWindows(@EnumWindowsProc2,LongInt(self));
      for i:=0 to Memo3.Lines.Count-1 do
        if pos('查找聯繫人',Memo3.Lines[i])>0 then
          nowhandelEdit.Text:=copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1);
      stepstr:='查找聯繫人';
      lasthandle:=nowhandelEdit.Text;
      qqquery:=strtoint(nowhandelEdit.Text);
      GetWindowRect(strtoint(nowhandelEdit.Text),rc);
      ForceForegroundWindow(strtoint(nowhandelEdit.Text));
      SetCursorPos(rc.Left+126,rc.Top+67);                                                             //点找人
      mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
      mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
      GetWindowRect(strtoint(nowhandelEdit.Text),rc);
      ForceForegroundWindow(strtoint(nowhandelEdit.Text));
      SetCursorPos(rc.Left+90,rc.Top+170);                                                             //点输入查找账号
      mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
      mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
      inputstr(waddqqMemo.Lines[j],charts);                                                            //输入查找账号
      Randomize;//初始化随机种子
      sleep(300+random(1000));
      GetWindowRect(strtoint(nowhandelEdit.Text),rc);
      ForceForegroundWindow(strtoint(nowhandelEdit.Text));
      SetCursorPos(rc.right-100,rc.Top+170);
      mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);                                              //点击查找
      mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
      if bsddyx then
      begin
        Execsql(editmainqqADOQuery,'update daijiahaoma set shiguo=true where qqhaoma='''+waddqqMemo.Lines[j]+'''');
        Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''尝试添加好友'',''QQ：'+qquserEdit.Text+'加'+waddqqMemo.Lines[j]+'为好友'')');
      end;
      Randomize;//初始化随机种子
      sleep(1000+random(1000));
      lasttime:=0;
      while (stepstr='查找聯繫人')and(lasttime<=20) do
      begin
        linshistepstr:=getstep(18,21,strtoint(nowhandelEdit.Text));
        if length(linshistepstr)>0 then
          stepstr:=linshistepstr;
        lasttime:=lasttime+1;
        sleep(1000+random(1000));
        if lasttime>20 then
        begin
          if bsddyx then
            exitpro;
        end;
      end;
      if (stepstr='ziliao01')or(stepstr='ziliao02')or(stepstr='zhaodaohaoyou') then
      begin
        if (stepstr='ziliao01')or(stepstr='ziliao02') then
        begin
          if stepstr='ziliao01' then
          begin
            GetWindowRect(strtoint(nowhandelEdit.Text),rc);
            ForceForegroundWindow(strtoint(nowhandelEdit.Text));
            SetCursorPos(rc.right-116,rc.Top+304);                                                   //点击加为好友
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
            Randomize;//初始化随机种子
            sleep(3*random(1000));
          end
          else if stepstr='ziliao02' then
          begin
            GetWindowRect(strtoint(nowhandelEdit.Text),rc);
            ForceForegroundWindow(strtoint(nowhandelEdit.Text));
            SetCursorPos(rc.right-82,rc.Top+304);                                                   //点击加为好友
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
            Randomize;//初始化随机种子
            sleep(3*random(1000));
          end;
          lasttime:=0;
          while (lasthandle=nowhandelEdit.Text)and(lasttime<=20) do
          begin
            Memo3.Lines.Clear;
            EnumWindows(@EnumWindowsProc2,LongInt(self));
            for i:=0 to Memo3.Lines.Count-1 do
              if pos('的資料',Memo3.Lines[i])>0 then
                nowhandelEdit.Text:=copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1);
            sleep(1000);
            lasttime:=lasttime+1;
            if lasttime>20 then
            begin
              if bsddyx then
                exitpro;
            end;
          end;
          if nowhandelEdit.Text<>lasthandle then
          begin
            stepstr:='看资料';
            lasthandle:=nowhandelEdit.Text;
            GetWindowRect(strtoint(nowhandelEdit.Text),rc);
            ForceForegroundWindow(strtoint(nowhandelEdit.Text));
            SetCursorPos(rc.Left+50,rc.Top+185);                                                   //点击加为好友
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
            Randomize;//初始化随机种子
            sleep(3*random(1000));
            lasthandle:=nowhandelEdit.Text;
            GetWindowRect(strtoint(nowhandelEdit.Text),rc);
            ForceForegroundWindow(strtoint(nowhandelEdit.Text));
            SetCursorPos(rc.Right-23,rc.Top+15);                                                   //关闭资料
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
            Randomize;//初始化随机种子
            sleep(3*random(1000));
            //showmessage(linshistepstr);
          end;
        end
        else if stepstr='zhaodaohaoyou' then
        begin
          GetWindowRect(strtoint(nowhandelEdit.Text),rc);
          ForceForegroundWindow(strtoint(nowhandelEdit.Text));
          SetCursorPos(rc.right-48,rc.Top+305);                                                   //点击加为好友
          mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
          mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
          Randomize;//初始化随机种子
          sleep(3*random(1000));
        end;

        GetWindowRect(strtoint(nowhandelEdit.Text),rc);
        ForceForegroundWindow(strtoint(nowhandelEdit.Text));
        SetCursorPos(rc.right-48,rc.Top+305);                                                   //点击加为好友
        mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
        mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
        Randomize;//初始化随机种子
        sleep(3*random(1000));
        lasttime:=0;
        while (lasthandle=nowhandelEdit.Text)and(lasttime<=20) do
        begin
          Memo3.Lines.Clear;
          EnumWindows(@EnumWindowsProc2,LongInt(self));
          for i:=0 to Memo3.Lines.Count-1 do
            if pos('添加好友',Memo3.Lines[i])>0 then
              nowhandelEdit.Text:=copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1);
          sleep(1000);
          lasttime:=lasttime+1;
          if lasttime>20 then
          begin
            if bsddyx then
              exitpro;
          end;
        end;
        if nowhandelEdit.Text<>lasthandle then
        begin
          stepstr:='添加好友';
          lasthandle:=nowhandelEdit.Text;
          linshistepstr:=getstep(22,29,strtoint(nowhandelEdit.Text));
          if length(linshistepstr)>0 then
            stepstr:=linshistepstr;
          //showmessage(linshistepstr);
          if stepstr='fayanzhengxinxi' then
          begin
            Clipboard.SetTextBuf(PChar(checkinfoedit.Text));      //将验证信息装入剪切板
            Randomize;//初始化随机种子
            sleep(3*random(1000));
            GetWindowRect(strtoint(nowhandelEdit.Text),rc);
            ForceForegroundWindow(strtoint(nowhandelEdit.Text));
            SetCursorPos(rc.Left+185,rc.Top+107);
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
            keybd_event(17,0,0,0);                        //将验证信息粘贴出来
            keybd_event(86,0,0,0);
            keybd_event(86,0,KEYEVENTF_KEYUP,0);
            keybd_event(17,0,KEYEVENTF_KEYUP,0);
            GetWindowRect(strtoint(nowhandelEdit.Text),rc);
            ForceForegroundWindow(strtoint(nowhandelEdit.Text));
            SetCursorPos(rc.Right-130,rc.Bottom-25);
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
            Randomize;//初始化随机种子
            sleep(3*random(1000));
            GetWindowRect(strtoint(nowhandelEdit.Text),rc);
            ForceForegroundWindow(strtoint(nowhandelEdit.Text));
            SetCursorPos(rc.Right-130,rc.Bottom-25);
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
            Randomize;//初始化随机种子
            sleep(1000*(random(3)+1));
            linshistepstr:=getstep(30,31,strtoint(nowhandelEdit.Text));
            if length(linshistepstr)>0 then
              stepstr:=linshistepstr;
            if bsddyx then
            begin
              if stepstr='jiahaoyouguoyupinfan' then
              begin
                Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''QQ：'+qquserEdit.Text+'被锁定'',''原因：加好友过于频繁'')');
                Execsql(editlistqqADOQuery,'update zhuhaoma set zhuangtai=''被锁定'',sdsj= '''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''' where qqhaoma='''+qquserEdit.Text+'''');
                break;
              end
              else
              begin
                Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''发送验证信息'',''QQ：'+qquserEdit.Text+'加'+waddqqMemo.Lines[j]+'验证信息已发送'')');
                Execsql(editlistqqADOQuery,'update daijiahaoma set changshi=true,shiguo=true,zhuangtai=''已发验证'' where qqhaoma='''+waddqqMemo.Lines[j]+'''');
              end;
            end;
            //  showmessage(stepstr);
            GetWindowRect(strtoint(nowhandelEdit.Text),rc);
            ForceForegroundWindow(strtoint(nowhandelEdit.Text));
            SetCursorPos(rc.Right-50,rc.Bottom-25);
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
          end
          else if stepstr='zhijiejia' then
          begin
            GetWindowRect(strtoint(nowhandelEdit.Text),rc);
            ForceForegroundWindow(strtoint(nowhandelEdit.Text));
            SetCursorPos(rc.Right-130,rc.Bottom-25);
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
            sleep(1000*(random(3)+1));
            linshistepstr:=getstep(30,31,strtoint(nowhandelEdit.Text));
            if length(linshistepstr)>0 then
              stepstr:=linshistepstr;
            if bsddyx then
            begin
              if stepstr='jiahaoyouguoyupinfan' then
              begin
                Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''QQ：'+qquserEdit.Text+'被锁定'',''原因：加好友过于频繁'')');
                Execsql(editlistqqADOQuery,'update zhuhaoma set zhuangtai=''被锁定'' where qqhaoma='''+qquserEdit.Text+'''');
                break;
              end
              else
              begin
                Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''增加成功'',''QQ：'+waddqqMemo.Lines[j]+'增加成功'')');
                Execsql(editlistqqADOQuery,'update daijiahaoma set changshi=true,shiguo=true,zhuangtai=''增加成功'' where qqhaoma='''+waddqqMemo.Lines[j]+'''');
              end;
            end;
            GetWindowRect(strtoint(nowhandelEdit.Text),rc);
            ForceForegroundWindow(strtoint(nowhandelEdit.Text));
            //  showmessage(stepstr);
            SetCursorPos(rc.Right-130,rc.Bottom-25);
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
          end
          else if stepstr='huidayanzhengwenti' then
          begin
            GetWindowRect(strtoint(nowhandelEdit.Text),rc);
            ForceForegroundWindow(strtoint(nowhandelEdit.Text));
            SetCursorPos(rc.Right-50,rc.Bottom-25);
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
            if bsddyx then
            begin
              Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''放弃'',''原因：QQ：'+waddqqMemo.Lines[j]+'需要回答验证问题'')');
              Execsql(editlistqqADOQuery,'update daijiahaoma set changshi=true,shiguo=true,zhuangtai=''需要回答验证问题'' where qqhaoma='''+waddqqMemo.Lines[j]+'''');
            end;
          end
          else if stepstr='jujuebeitianjia' then
          begin
            GetWindowRect(strtoint(nowhandelEdit.Text),rc);
            ForceForegroundWindow(strtoint(nowhandelEdit.Text));
            SetCursorPos(rc.Right-50,rc.Bottom-25);
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
            if bsddyx then
            begin
              Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''拒绝被添加'',''QQ：'+waddqqMemo.Lines[j]+'拒绝被添加'')');
              Execsql(editlistqqADOQuery,'update daijiahaoma set changshi=true,shiguo=true,zhuangtai=''拒绝被添加'' where qqhaoma='''+waddqqMemo.Lines[j]+'''');
            end;
          end;
        end;
      end
      else if stepstr='meizhaodaohaoyou' then
      begin
        if bsddyx then
        begin
          Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''账号不存在'',''QQ：'+waddqqMemo.Lines[j]+'不存在'')');
          Execsql(editlistqqADOQuery,'update daijiahaoma set changshi=true,shiguo=true,zhuangtai=''不存在'' where qqhaoma='''+waddqqMemo.Lines[j]+'''');
        end;
      end
      else
      begin
        if bsddyx then
        begin
          Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''搜索超时'',''QQ：'+waddqqMemo.Lines[j]+'搜索超时'')');
          Execsql(editlistqqADOQuery,'update daijiahaoma set changshi=false,shiguo=false,zhuangtai=''搜索超时'' where qqhaoma='''+waddqqMemo.Lines[j]+'''');
        end;
      end;
    end;
    GetWindowRect(qqquery,rc);
    ForceForegroundWindow(qqquery);
    SetCursorPos(rc.Right-23,rc.Top+15);                                                            //关闭查找
    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
    {if checkbox1.Checked then
    begin
      GetWindowRect(qqmain,rc);
      while (rc.Top<>10) or (rc.Left<>10) do
      begin
        SetWindowPos(qqmain, HWND_TOPMOST, 10,10, 100,200, SWP_NOSIZE); //将QQ界面置于顶层并放在坐标10,10的位置
        GetWindowRect(qqmain,rc);
      end;
      GetWindowRect(qqmain,rc);
      SetCursorPos(rc.Left+26,rc.Bottom-26);                                                          //点击主菜单
      mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
      mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
      sleep(500);
      SetCursorPos(rc.Left+50,rc.Bottom-275);                                                         //点击工具
      mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
      mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
      sleep(500);
      SetCursorPos(rc.Left+226,rc.Bottom-205);                                                        //点击好友管理器
      mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
      mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
      sleep(500);
      Memo3.Lines.Clear;
      EnumWindows(@EnumWindowsProc2,LongInt(self));
      for i:=0 to Memo3.Lines.Count-1 do
        if pos('好友管理器',Memo3.Lines[i])>0 then
          if pos(Memo3.Lines[i],Memo1.Text)=0 then
            nowhandelEdit.Text:=copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1);
      GetWindowRect(strtoint(nowhandelEdit.Text),rc);
      while (rc.Left<>(screen.Width-(rc.Right-rc.Left)-30))or(rc.Top<>(screen.Height-(rc.Bottom-rc.Top)-30)) do //将好友管理器移动到靠近右下角的位置
      begin
        SetWindowPos(strtoint(nowhandelEdit.Text), HWND_TOPMOST, screen.Width-(rc.Right-rc.Left)-30,screen.Height-(rc.Bottom-rc.Top)-30, 100,200, SWP_NOSIZE); //将QQ界面置于顶层并放在坐标10,10的位置
        GetWindowRect(strtoint(nowhandelEdit.Text),rc);
      end;
      //Image2.Picture.Bitmap.Assign(CaptureScreen(strtoint(nowhandelEdit.Text),13,117,87,19));    //截取识别数量图片
      //Image3.Picture.Bitmap.Assign(twovalue2(Image2.Picture.Bitmap));                            //读出特征图片
      tempbmp1:=Tbitmap.Create;
      tempbmp1.Assign(CaptureScreen(strtoint(nowhandelEdit.Text),13,117,87,19));    //截取识别数量图片
      tempbmp1.Assign(twovalue2(tempbmp1));
      tempbmp2:=Tbitmap.Create;
      tempbmp2.Width:=tempbmp1.Width-53;
      tempbmp2.Height:=10;                                               //读出有效特征图片
      tempbmp2.Canvas.CopyRect(rect(0,0,tempbmp1.Width-53,10),tempbmp1.Canvas,rect(53,5,tempbmp1.Width,15));
      //image1.Picture.Bitmap.Assign(tempbmp1);
      hys:=readnumformbmp(tempbmp2);
      tempbmp1.Free;
      tempbmp2.Free;
      //showmessage(inttostr(readnumformbmp(tempbmp)));
      if hys>0 then
      begin
        Execsql(editmainqqADOQuery,'update zhuhaoma set haoyoushu='+inttostr(hys)+' where qqhaoma='''+qquserEdit.Text+'''');
        Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''成功读取好友数'',''QQ：'+qquserEdit.Text+'成功读取好友数,数量为：'+inttostr(hys)+''')');
      end;
      SetCursorPos(rc.Right-23,rc.Top+15);                                                            //关闭好友管理器
      mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
      mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
    end;}
    setxyqqmain;
    GetWindowRect(qqmain,rc);
    SetCursorPos(rc.Right-23,rc.Top+15);                                                           //关闭QQ
    setxyqqmain;
    GetWindowRect(qqmain,rc);
    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
    sleep(1000);
    Memo3.Lines.Clear;                                                                              //判断有无关闭提示
    EnumWindows(@EnumWindowsProc2,LongInt(self));
    for i:=0 to Memo3.Lines.Count-1 do
      if pos('關閉提示',Memo3.Lines[i])>0 then
        nowhandelEdit.Text:=copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1);
    GetWindowRect(strtoint(nowhandelEdit.Text),rc);
    ForceForegroundWindow(strtoint(nowhandelEdit.Text));
    SetCursorPos(rc.Left+96,rc.Top-106);                                                              //选退出程式
    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
    GetWindowRect(strtoint(nowhandelEdit.Text),rc);
    ForceForegroundWindow(strtoint(nowhandelEdit.Text));
    SetCursorPos(rc.Right-130,rc.Bottom-26);
    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);                                                         //点确定
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
    sleep(500);
    Memo3.Lines.Clear;                                                                                //判断有无关闭警告，如：还有聊天窗口
    EnumWindows(@EnumWindowsProc2,LongInt(self));
    for i:=0 to Memo3.Lines.Count-1 do
      if pos('提示',Memo3.Lines[i])>0 then
        nowhandelEdit.Text:=copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1);
    GetWindowRect(strtoint(nowhandelEdit.Text),rc);
    ForceForegroundWindow(strtoint(nowhandelEdit.Text));
    SetCursorPos(rc.Right-130,rc.Bottom-26);                                                          //点确定
    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
  end
  else if stepstr='baohumoshi' then
  begin
    Execsql(editmainqqADOQuery,'update zhuhaoma set zhuangtai=''保护模式'',xianzhiyuanyin=''存被盗风险'' where qqhaoma='''+qquserEdit.Text+'''');
    Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''账号进入保护模式'',''QQ：'+qquserEdit.Text+'进入保护模式,原因：存被盗风险'')');
    GetWindowRect(strtoint(nowhandelEdit.Text),rc);
    ForceForegroundWindow(strtoint(nowhandelEdit.Text));
    SetCursorPos(rc.Right-53,rc.Top+18);
    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
  end
  else if stepstr='mimabuzhengque' then
  begin
    Execsql(editmainqqADOQuery,'update zhuhaoma set zhuangtai=''密码错误'',xianzhiyuanyin=''密码错误'' where qqhaoma='''+qquserEdit.Text+'''');
    Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''密码错误'',''QQ：'+qquserEdit.Text+'密码错误,原因：密码错误'')');
    GetWindowRect(strtoint(nowhandelEdit.Text),rc);
    ForceForegroundWindow(strtoint(nowhandelEdit.Text));
    SetCursorPos(rc.Right-53,rc.Top+18);
    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
  end
  else if stepstr='zhanghubucunzai' then
  begin
    Execsql(editmainqqADOQuery,'update zhuhaoma set zhuangtai=''帐户不存在'',xianzhiyuanyin=''帐户不存在'' where qqhaoma='''+qquserEdit.Text+'''');
    Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''帐户不存在'',''QQ：'+qquserEdit.Text+'不存在'')');
    GetWindowRect(strtoint(nowhandelEdit.Text),rc);
    ForceForegroundWindow(strtoint(nowhandelEdit.Text));
    SetCursorPos(rc.Right-53,rc.Top+18);
    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
  end
  else if stepstr='zhanghudongjie' then
  begin
    //showmessage('update zhuhaoma set zhuangtai=''帐户被冻结'',xianzhiyuanyin=''帐户被冻结'' where qqhaoma='''+qquserEdit.Text+'''');
    Execsql(editmainqqADOQuery,'update zhuhaoma set zhuangtai=''帐户被冻结'',xianzhiyuanyin=''帐户被冻结'' where qqhaoma='''+qquserEdit.Text+'''');
    //showmessage('insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''帐户被冻结'',''QQ：'+qquserEdit.Text+'帐户被冻结'')');
    Execsql(editevenADOQuery,'insert into even(evendatetime,eventype,evencontent) values('''+formatdatetime('yyyy-mm-dd hh:nn:ss',now)+''',''帐户被冻结'',''QQ：'+qquserEdit.Text+'帐户被冻结'')');
    GetWindowRect(strtoint(nowhandelEdit.Text),rc);
    ForceForegroundWindow(strtoint(nowhandelEdit.Text));
    SetCursorPos(rc.Right-53,rc.Top+18);
    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
  end;
  sleep(3000);
  deletetempfile;
  charts.Free;
  sleep(strtoint(waittimeEdit.Text));
  Button3.Caption:='开始';
  Button3.Enabled:=true;
end;

procedure TdoForm.Button1Click(Sender: TObject);
var
rc:tRect;
begin
  GetWindowRect(strtoint(nowhandelEdit.Text),rc);
  //showmessage(inttostr(rc.Left)+';'+inttostr(rc.Top)+';'+inttostr(rc.Right)+';'+inttostr(rc.Bottom));
  //SetCursorPos(strtoint(edit5.Text),strtoint(edit6.Text));
  SetCursorPos(rc.Left+strtoint(edit5.Text),rc.Top+strtoint(edit6.Text));
  //SetCursorPos(rc.Right-strtoint(edit5.Text),rc.Top+strtoint(edit6.Text));
  //SetCursorPos(rc.Right-strtoint(edit5.Text),rc.Bottom-strtoint(edit6.Text));
  //SetCursorPos(rc.Left+strtoint(edit5.Text),rc.Bottom-strtoint(edit6.Text));
  //movewindow(strtoint(nowhandelEdit.Text),10,10,rc.Right-rc.Left,rc.Bottom-rc.Top,true);
end;

procedure TdoForm.Button2Click(Sender: TObject);
begin
  Memo3.Lines.Clear;
  EnumWindows(@EnumWindowsProc2,LongInt(self));
end;

procedure TdoForm.Button4Click(Sender: TObject);
var
rc:tRect;
begin
  GetWindowRect(strtoint(nowhandelEdit.Text),rc);
  Image1.Picture.Bitmap.Assign(CaptureScreen(strtoint(nowhandelEdit.Text),rc.Right-rc.Left-strtoint(edit9.Text),strtoint(edit10.Text),strtoint(edit9.Text)-strtoint(edit11.Text),strtoint(edit12.Text)-strtoint(edit10.Text)));
  //Image1.Picture.Bitmap.Assign(CaptureScreen(strtoint(nowhandelEdit.Text),strtoint(edit9.Text),strtoint(edit10.Text),strtoint(edit11.Text)-strtoint(edit9.Text),strtoint(edit12.Text)-strtoint(edit10.Text)));
  //Image1.Picture.Bitmap.Assign(CaptureScreen(strtoint(nowhandelEdit.Text),strtoint(edit9.Text),rc.Bottom-rc.Top-strtoint(edit10.Text),strtoint(edit11.Text)-strtoint(edit9.Text),strtoint(edit10.Text)-strtoint(edit12.Text)));
  Image1.Picture.Bitmap.SaveToFile(ExtractFilePath(Application.Exename)+edit15.Text+'.bmp');
end;

procedure TdoForm.FormCreate(Sender: TObject);
var
resfile:TResourceStream;
i:integer;
begin
  Set8087CW($133f);             //防止浮点异常
  apppath:=ExtractFilePath(Application.Exename);
  bsddyx:=not fileexists(apppath+'单独运行.txt');
  ADOConnection1.Close;
  ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+apppath+'addqq.mdb'+';Persist Security Info=False';
  ADOConnection1.Open;
  {if bsddyx then
  begin
    QQpathEdit.Text:='';
    nowhandelEdit.Text:='';
    qquserEdit.Text:='';
    qqpwdEdit.Text:='';
    waddqqMemo.Lines.Clear;
    checkinfoedit.Text:='';
  end;}
  self.DoubleBuffered:=true;
  bmpts:=tstringlist.Create;
  resfile:=TResourceStream.Create(HInstance,'bmp','txtfile');
  bmpts.LoadFromStream(resfile);
  //resfile.SaveToFile(apppath+'addqq.mdb');
  resfile.Free;
  //bmpts.LoadFromFile(ExtractFilePath(Application.Exename)+'\modebmp\bmp.txt');
  for i:=0 to bmpts.Count-1 do
    if i mod 2=0 then
    begin
      resfile:=TResourceStream.Create(HInstance,bmpts.Strings[i],'bmpfile');
      imagemodel:=Timage.Create(Self);
      imagemodel.Name:=bmpts.Strings[i];
      imagemodel.Picture.Bitmap.LoadFromStream(resfile);
      resfile.Free;
    end;
  for i:=0 to 9 do
  begin
    resfile:=TResourceStream.Create(HInstance,'zm'+inttostr(i),'bmpfile');
    imagemodel:=Timage.Create(Self);
    imagemodel.Name:='zm'+inttostr(i);
    imagemodel.Picture.Bitmap.LoadFromStream(resfile);
    resfile.Free;
  end;
end;

procedure TdoForm.Button8Click(Sender: TObject);
begin
  showmessage(getstep(0,bmpts.Count,strtoint(nowhandelEdit.Text)));
end;

procedure TdoForm.Button5Click(Sender: TObject);
var
hWindow: HWND;           { 窗体句柄}
dwProcessID: DWORD; { 进程ID }
hProcess: THandle;       { 进程句柄}
begin
  { 通过窗体句柄获取进程ID }
  GetWindowThreadProcessId(strtoint(nowhandelEdit.Text), dwProcessID);
  showmessage(Format('%u',[dwProcessID]));
  { 通过进程ID 获取进程句柄}
  hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, dwProcessID);
  showmessage(Format('%u',[hProcess]));
  { 结束该进程}
  //TerminateProcess(hProcess, 0);
end;

procedure TdoForm.Button6Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    QQpathEdit.Text:=OpenDialog1.FileName;
end;

procedure TdoForm.Button7Click(Sender: TObject);
begin
  SetWindowPos(strtoint(nowhandelEdit.Text), HWND_TOPMOST, 10,10, 100,200, SWP_NOSIZE);
end;

procedure TdoForm.FormDestroy(Sender: TObject);
var
i:integer;
begin
  for i:=0 to bmpts.Count-1 do
    if i mod 2=0 then
      Self.FindComponent(bmpts.Strings[i]).Free;
  for i:=0 to 9 do
    Self.FindComponent('zm'+inttostr(i)).Free;
  bmpts.Free;
end;

procedure TdoForm.Button11Click(Sender: TObject);
var
rc:tRect;
i:integer;
tempbmp:Tbitmap;
begin
  GetWindowRect(strtoint(nowhandelEdit.Text),rc);
  SetCursorPos(rc.Left+26,rc.Bottom-26);
  mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
  mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
  sleep(500);
  SetCursorPos(rc.Left+50,rc.Bottom-275);
  mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
  mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
  sleep(500);
  SetCursorPos(rc.Left+226,rc.Bottom-205);
  mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
  mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
  sleep(500);
  Memo3.Lines.Clear;
  EnumWindows(@EnumWindowsProc2,LongInt(self));
  for i:=0 to Memo3.Lines.Count-1 do
    if pos('好友管理器',Memo3.Lines[i])>0 then
      if pos(Memo3.Lines[i],Memo1.Text)=0 then
        nowhandelEdit.Text:=copy(Memo3.Lines[i],1,pos(';',Memo3.Lines[i])-1);
  GetWindowRect(strtoint(nowhandelEdit.Text),rc);
  while (rc.Left<>(screen.Width-(rc.Right-rc.Left)-30))or(rc.Top<>(screen.Height-(rc.Bottom-rc.Top)-30)) do
  begin
    SetWindowPos(strtoint(nowhandelEdit.Text), HWND_TOPMOST, screen.Width-(rc.Right-rc.Left)-30,screen.Height-(rc.Bottom-rc.Top)-30, 100,200, SWP_NOSIZE); //将QQ界面置于顶层并放在坐标10,10的位置
    GetWindowRect(strtoint(nowhandelEdit.Text),rc);
  end;
  Image2.Picture.Bitmap.Assign(CaptureScreen(strtoint(nowhandelEdit.Text),13,117,87,19));
  Image3.Picture.Bitmap.Assign(twovalue2(Image2.Picture.Bitmap,20));
  tempbmp:=Tbitmap.Create;
  //tempbmp.Width:=strtoint(edit11.Text)-strtoint(edit9.Text);
  //tempbmp.Height:=strtoint(edit12.Text)-strtoint(edit10.Text);
  //tempbmp.Canvas.CopyRect(rect(0,0,strtoint(edit11.Text)-strtoint(edit9.Text),strtoint(edit12.Text)-strtoint(edit10.Text)),image3.Picture.Bitmap.Canvas,rect(strtoint(edit9.Text),strtoint(edit10.Text),strtoint(edit11.Text),strtoint(edit12.Text)));
  tempbmp.Width:=image3.Picture.Bitmap.Width-53;
  tempbmp.Height:=10;
  tempbmp.Canvas.CopyRect(rect(0,0,image3.Picture.Bitmap.Width-53,10),image3.Picture.Bitmap.Canvas,rect(53,5,image3.Picture.Bitmap.Width,15));
  image1.Picture.Bitmap.Assign(tempbmp);
  showmessage(inttostr(readnumformbmp(tempbmp)));
  tempbmp.Free;
end;

procedure TdoForm.Button9Click(Sender: TObject);
var  
jubing : hwnd;//句柄
fprocessentry32 : TProcessEntry32; //结构类型的变量
zhenjia : Boolean;   //返回一个布尔值（用来判断是否找到进程信息）
processid : dword; //储存找到的进程ID
mingcheng : string; //储存找到的进程名称 end;
begin
  jubing := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);   //获得进程快照句柄
  fprocessentry32.dwSize := sizeof(fprocessentry32); //给TProcessEntry32结构的第一个参数赋值（也可以理解为把这个结构的第一个参数初始化）
  zhenjia := Process32First(jubing,fprocessentry32); //使用 Process32First函数取得第一个进程的信息
  while zhenjia = true do //如果 Process32First函数执行成功也就是说找到进程列表里的第一个进程时开始循环
  begin
    zhenjia := Process32Next(jubing,FprocessEntry32); //取得第下一个进程信息
    processid := fprocessentry32.th32ProcessID;
    mingcheng := fprocessentry32.szExeFile; //取得一个进程的名称
    if uppercase(mingcheng) = 'QQ.EXE' then //如果进程名等于这个字符串
      self.Memo1.lines.Add(mingcheng+inttostr(processid)); //把找到的进程显示出来
  end;
end;

procedure TdoForm.Button10Click(Sender: TObject);
begin
  image2.Picture.Bitmap.Assign(twovalue3(image1.Picture.Bitmap,240));
  //image2.Picture.Bitmap.Assign(twovalue2(image1.Picture.Bitmap,30));
end;

procedure TdoForm.BitBtn1Click(Sender: TObject);
var
p: PByteArray;
X: Integer;
Y: Integer;
colorint:array[0..255] of integer;
i:integer;
maxi:extended;
nowcolor,sg:integer;
tempbmp:tbitmap;
Series: TchartSeries;
begin
  //self.DoubleBuffered:=true;
  for i:=0 to 255 do
    colorint[i]:=0;
  tempbmp:=tbitmap.Create;                                //取图
  tempbmp.Assign(image1.Picture.Bitmap);
  {tempbmp.Canvas.Lock;
  tempbmp.Width  := inbmp.Width;
  tempbmp.Height := inbmp.Height;
  tempbmp.pixelformat := pf24bit;
  tempbmp.canvas.draw(0,0,inbmp);}
  for y := 0 to tempbmp.Height - 1 do                           //取灰度分布
  begin
      p := tempbmp.scanline[y];
      for x := 0 to tempbmp.Width - 1 do
      begin  //首先将图像灰度化
          nowcolor := Round(p[x * 3 + 2] * 0.3 + p[x * 3 + 1] * 0.59 + p[x
              * 3] * 0.11);
          colorint[nowcolor]:=colorint[nowcolor]+1;
      end;
  end;
  //tempbmp.Canvas.unLock;
  Series := TchartSeries.Create(Chart1);
{Series.Add(100, '头部', clRed);
Series.Add(200, '颈部', clGreen);
Chart1.AddSeries(Series);}

  for i:=0 to 255 do
  begin
    sg:=floor((colorint[i]/(tempbmp.Height*tempbmp.Width))*100);
    if sg>0 then
      Series.Add(sg,'颜色值:'+inttostr(i)+'，百分值:'+inttostr(sg), clRed);
  end;
  Chart1.AddSeries(Series);
    //colorint[i]:=0;
  tempbmp.Free;
end;

procedure TdoForm.BitBtn2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
end;

procedure TdoForm.Button12Click(Sender: TObject);
begin
  winexec(pchar(QQpathEdit.Text),0);
end;

procedure TdoForm.Button13Click(Sender: TObject);
begin
  if isyzm(image1.Picture.Bitmap) then
    showmessage('是')
  else
    showmessage('否');
end;

procedure TdoForm.Button14Click(Sender: TObject);
var
rc:tRect;
i:integer;
tempbmp:Tbitmap;
begin
  GetWindowRect(strtoint(nowhandelEdit.Text),rc);
  SetCursorPos(rc.Left+16,rc.Top+16);
  mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
  Randomize;
  SetCursorPos(60+Random(10),60+Random(5));
  Randomize;
  sleep(300+Random(300));
  Randomize;
  SetCursorPos(50+Random(20),40+Random(10));
  Randomize;
  sleep(300+Random(200));
  Randomize;
  SetCursorPos(40+Random(10),40+Random(20));
  Randomize;
  sleep(200+Random(100));
  Randomize;
  SetCursorPos(30+Random(10),30+Random(20));
  Randomize;
  sleep(200+Random(100));
  mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
end;

procedure TdoForm.Button15Click(Sender: TObject);
begin
  deletetempfile;
end;

end.
