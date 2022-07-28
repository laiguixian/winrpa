unit funcs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, dialogs, DB, ADODB, Masks{, VCLUnZip, VCLZip}, jpeg, Graphics, {RzTreeVw
  ,}IdSMTP,IdAttachmentFile, IdMessage,math,registry,HttpApp,ShlObj,ComObj;

Function Opensql(adoquery:Tadoquery;sqlstr:string):boolean;           //查询sql
Function Execsql(adoquery:Tadoquery;sqlstr:string):boolean;           //执行sql
procedure DeleteMe;  //自动销毁
//function ZipFileAndPath(const ASrcFilenamelist:Tstringlist;const ASrcFilepath,ADestFilename: string; const APassword: string): Boolean;    //压缩文件，可含文件夹
function DeleteDirectory(NowPath: string;deletepath:boolean): Boolean; // 删除整个目录        NowPath: 要删除的目录,deletepath：是否删除目录文件夹
//function ZipToFile(zipFileName:string;FileDir:string):boolean;                                //把压缩文件解压
procedure GetFileListEx(FilePath, ExtMask: string; FileList: TStrings; SubDirectory: Boolean=True);//获取特定目录下的某类文件名列表
function WhatFile(const FileName: string): string;                       //判断图片格式
function BmpToJpg(temp, path: String; ACQ: Integer): Boolean; stdcall;  //bmp转为jpg
//function findtreenode(checktree:TRzchecktree;nodename:string):integer;  //根据名称寻找Ttreenode
function randomizesl(var ressl:Tstringlist;sl:Tstringlist):boolean;  //将stringlist里的字符串顺序重新随机排列
function getlistfromstr(var getlist:Tstringlist;strspan:string;sourcestr:string):boolean;//按分隔符将字符串里的列表提取出来  getlist：提取出来保存在的列表  strspan：分隔符  sourcestr：输入的字符串
//function sendmail(smtptxt,mailuser,mailpassword,smtpporttxt,recuser,attachfile,mailsubject,bodytext:string):boolean; //发送邮件
function CompatibleWindows7: Boolean; //兼容Windows7
function countstep01(var stepname,picname:string;var stepnum,leftpoint:integer;adoquery:Tadoquery;countpoint,stepn,picn:integer):boolean;  //计算等级  stepname：输出的等级名称 picname：输出的等级图片名称  stepnum：输出的等级图片数量 leftpoint：剩余的分数  adoquery:输入的查询控件 countpoint:输入的总分数 stepn:每升一个初级等级所需的分数 picn:每升一个等级所需上一级的个数    此法类似淘宝
function countstep02(var stepname,picname:string;var nextpoint,leftpoint:integer;adoquery:Tadoquery;countpoint,num0,stepn:integer):boolean;  //计算等级  stepname：输出的等级名称 picname：输出的等级图片名称  nextpoint：输出的下次升级所需的分数 leftpoint：剩余的分数  adoquery:输入的查询控件 countpoint:输入的总分数 num0:最初级分数上限 stepn:等差数列的分数    此法为考试系统
//procedure DelCookie; //删除cookie
{ use DateUtils
function   IncYear(const   AValue:   TDateTime;
    const   ANumberOfYears:   Integer   =   1):   TDateTime;
//   function   IncMonth   is   in   SysUtils
function   IncWeek(const   AValue:   TDateTime; 
    const   ANumberOfWeeks:   Integer   =   1):   TDateTime; 
function   IncDay(const   AValue:   TDateTime;
    const   ANumberOfDays:   Integer   =   1):   TDateTime; 
function   IncHour(const   AValue:   TDateTime; 
    const   ANumberOfHours:   Int64   =   1):   TDateTime; 
function   IncMinute(const   AValue:   TDateTime; 
    const   ANumberOfMinutes:   Int64   =   1):   TDateTime; 
function   IncSecond(const   AValue:   TDateTime;
    const   ANumberOfSeconds:   Int64   =   1):   TDateTime;
function   IncMilliSecond(const   AValue:   TDateTime; 
    const   ANumberOfMilliSeconds:   Int64   =   1):   TDateTime;

比如， 分钟相加 的话 使用 IncMinute，加30分钟分钟
   edit1.text ：= DatetimetoStr(IncMinute(datetimepicker.time,30));

}
{
ExtractFileDrive：返回完整文件名中的驱动器，如"C:"
ExtractFilePath：返回完整文件名中的路径，最后带“/”，如"C:/test/"
ExtractFileDir：返回完整文件名中的路径，最后不带“/” ,如"C:/test"
ExtractFileName:返回完整文件名中的文件名称 (带扩展名)，如"mytest.doc"
ExtractFileExt 返回完整文件名中的文件扩展名（带.），如".doc"
}
implementation

{function GetCookiesFolder:string;
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
  FillChar(FOS, SizeOf(FOS), 0); //记录清零
  with FOS do
  begin
    wFunc := FO_DELETE;//删除
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
    ShellDeleteFile(dir+'\*.txt'+#0);        //网上很多代码这里没有加最后的#0，在xp下经测试会报错
  except
    abort;
  end;
end;}

Function Opensql(adoquery:Tadoquery;sqlstr:string):boolean;
begin
  try
    Result:=false;
    with adoquery do
    begin
      close;
      sql.Clear;
      sql.Add(sqlstr);
      open;
    end;
    Result:=true;
  except
    Result:=false;
  end;
end;

Function Execsql(adoquery:Tadoquery;sqlstr:string):boolean;
begin
  try
    Result:=false;
    with adoquery do
    begin
      close;
      sql.Clear;
      sql.Add(sqlstr);
      //showmessage(sql.GetText);
      execsql;
      close;
    end;
    Result:=true;
  except
    Result:=false;
  end;
end;

{function ZipFileAndPath(const ASrcFilenamelist:Tstringlist;const ASrcFilepath,ADestFilename: string; const APassword: string): Boolean;    //压缩文件，可含文件夹
var
  VCLZip: TVCLZip;
begin
  VCLZip := TVCLZip.Create(nil);
  with VCLZip do
  try
    try
      ZipName:=ADestFilename;
      RootDir:=ASrcFilepath;    //文件夹所在路径
      OverwriteMode:=Always;//总是覆盖
      AddDirEntriesOnRecurse:=true;
      DoAll:=true;//压缩所有文件
      RelativePaths:=true;//是否保持目录结构
      if length(APassword)>0 then
        Password := APassword;
      RecreateDirs := True;
      StorePaths := true;
      MultiZipInfo.MultiMode   :=   mmNone;
      FilesList.Text:=ASrcFilenamelist.Text;
      //文件夹内要压缩的文件，如果要全部，可直接用'*.*' 而且直接把RootDir设置为文件夹路径，但是这样就没有文件夹
      Recurse := True;
      Zip;
      Result := True;
    except
      Result := False;
    end;
  finally
    Free;
  end;
end;  }

function DeleteDirectory(NowPath: string;deletepath:boolean): Boolean; // 删除整个目录        NowPath: 要删除的目录,deletepath：是否删除目录文件夹
var
  search: TSearchRec;
  ret: integer;
  key: string;
begin
  if NowPath[Length(NowPath)] <> '\' then
    NowPath := NowPath + '\';
  key := NowPath + '*.*';
  ret := findFirst(key, faanyfile, search);
  while ret = 0 do
  begin
    if ((search.Attr and fadirectory) = fadirectory) then
    begin
      if (search.Name <> '.') and (search.name <> '..') then
        DeleteDirectory(NowPath + search.name,true);
    end
    else
    begin
      if ((search.Attr and fadirectory) <> fadirectory) then
      begin
        deletefile(NowPath + search.name);
      end;
    end;
    ret := FindNext(search);
  end;
  findClose(search);
  if deletepath then
    removedir(NowPath); //如果需要删除文件夹则添加
  result := True;
end;

procedure GetFileListEx(FilePath, ExtMask: string; FileList: TStrings; SubDirectory: Boolean=True);//获取特定目录下的某类文件名列表
function Match(FileName: string; MaskList: TStrings): boolean;
var
    i: Integer;
begin
    Result := False;
    for i := 0 to MaskList.Count - 1 do
    begin
      if MatchesMask(FileName, MaskList[i]) then
      begin
        Result := True;
        break;
      end;
    end;
end;
var
FileRec: TSearchrec;
MaskList: TStringList;
begin
if DirectoryExists(FilePath) then
begin
    if FilePath[Length(FilePath)] <> '\' then FilePath := FilePath + '\';
    if FindFirst(FilePath + '*.*', faAnyfile, FileRec) = 0 then
    begin
      MaskList := TStringList.Create;
      try
        ExtractStrings([';'], [], PChar(ExtMask), MaskList);
        FileList.BeginUpdate;
        repeat
          if ((FileRec.Attr and faDirectory) <> 0) and SubDirectory then
          begin
            if (FileRec.Name <> '.') and (FileRec.Name <> '..') then
              GetFileListEx(FilePath + FileRec.Name + '\', ExtMask, FileList);
          end
          else
          begin
            if Match(FilePath + FileRec.Name, MaskList) then
              FileList.Add(FilePath + FileRec.Name);
          end;
        until FindNext(FileRec) <> 0;
        FileList.EndUpdate;
      finally
        MaskList.Free;
      end;
    end;
    FindClose(FileRec);
end;
end;

{function ZipToFile(zipFileName:string;FileDir:string):boolean;                                //把压缩文件解压
var
VCLUnZip:TVCLUnZip;
begin
  Result := False;
  VCLUnZip := TVCLUnZip.Create(nil);
  with VCLUnZip do
  begin
    ZipName:=zipFileName;
    ReadZip;
    Destdir := FileDir;
    RecreateDirs := True;
    FilesList.Add('*.*');
    DoAll := True;
    OverwriteMode := Always;
    Password := 'tDr201212zjy';
  end;
  VCLUnZip.UnZip;
  VCLUnZip.Free;
  Result := true;
end;}

//  1.Png图片文件包括8字节：89 50 4E 47 0D 0A 1A 0A。即为 .PNG....。
//2.Jpg图片文件包括2字节：FF D8。
//3.Gif图片文件包括6字节：47 49 46 38 39|37 61 。即为 GIF89(7)a。
//4.Bmp图片文件包括2字节：42 4D。即为 BM。

function WhatFile(const FileName: string): string;                       //判断文件格式
var
  MS: TMemoryStream;
  Buffer: array[0..1] of Byte;
begin
  result:='';
  MS := TMemoryStream.Create;
  try
    MS.LoadFromFile(FileName);
    MS.Read(Buffer, 2);
    if (Buffer[0] = $FF) and (Buffer[1] = $D8)then
       result:='.jpg'
    else if (Buffer[0] = $42) and (Buffer[1] = $4D)then
       result:='.bmp'
    else if (Buffer[0] = $89) and (Buffer[1] = $50)then
       result:='.png'
    else if (Buffer[0] = $46) and (Buffer[1] = $4C)then
       result:='.flv';
  finally
    MS.Free;
  end;
end;

function BmpToJpg(temp, path: String; ACQ: Integer): Boolean; stdcall;  //bmp转为jpg
var
  MyJpeg: TJpegImage;
  Bmp: TBitmap;
begin
  result := false;
  if FileExists(temp) then
  begin
    Bmp:= TBitmap.Create;
    MyJpeg:= TJpegImage.Create;
    Bmp.LoadFromFile(temp);
    MyJpeg.Assign(Bmp);
    MyJpeg.CompressionQuality := ACQ;
    MyJpeg.Compress;
    MyJpeg.SaveToFile(Path);
    MyJpeg.free;
    Bmp.free;
    if FileExists(path) then
      result := True;
  end;
end;

{function findtreenode(checktree:TRzchecktree;nodename:string): integer;  //根据名称寻找Ttreenode
var
i:integer;
begin
  for i:=0 to checktree.Items.Count-1 do
  begin
    if checktree.Items[i].Text=nodename then
      Result:=i;
  end;
end;}

function randomizesl(var ressl:Tstringlist;sl:Tstringlist):boolean;  //将stringlist里的字符串顺序重新随机排列
var
i,j:integer;
aladd,standstr:string;
resuts:Tstringlist;
allin:boolean;
begin
 try
   result:=false;
   //Application.MessageBox(upd.GetText, '原始',MB_OK);
   allin:=false;
   aladd:='';
   standstr:='';
   resuts:=Tstringlist.Create;
   resuts.Clear;
   for i:=0 to sl.Count-1 do
     standstr:=standstr+inttostr(i)+',';
   //Application.MessageBox(pchar(standstr), '标准字符',MB_OK);
   randomize;
   j:=random(sl.Count);
   while not allin do
   begin
     allin:=true;
     for i:=0 to sl.Count-1 do
       if (pos(inttostr(i)+',',aladd)=0) then
       begin
         //Application.MessageBox(pchar(inttostr(i)), '当前序号',MB_OK);
         allin:=false;
       end;
     if allin then
       break;
     if (pos(inttostr(j)+',',aladd)=0)and(pos(inttostr(j)+',',standstr)>0) then
     begin
       resuts.Add(sl.Strings[j]);
       aladd:=aladd+inttostr(j)+',';
     end;
     randomize;
     j:=random(sl.Count);
     //Application.MessageBox(pchar(aladd), '累加字符',MB_OK);
   end;
   ressl.Clear;
   for i:=0 to resuts.Count-1 do
     ressl.Add(resuts.Strings[i]);
   resuts.Free;
   //Application.MessageBox(resuts.GetText, '处理后',MB_OK);
   result:=true;
 except
 result:=false;
 end;
end;
function getlistfromstr(var getlist:Tstringlist;strspan:string;sourcestr:string):boolean;
var
i,j,k,strspanlen:integer;
lsstr:string;
begin
  try
    Result:=false;
    getlist.Clear;
    strspanlen:=length(strspan);
    i:=1;
    k:=1;
    while i<=length(sourcestr) do
    begin
      if sourcestr[i]=strspan[1] then
      begin
        lsstr:='';
        for j:=i to i+strspanlen-1 do
          lsstr:=lsstr+sourcestr[j];
        if lsstr=strspan then
        begin
          getlist.Add(copy(sourcestr,k,i-k));
          k:=i+strspanlen;
          i:=i+strspanlen-1;
        end;
      end;
      i:=i+1;
    end;
    Result:=true;
    if getlist.Count<=0 then
      Result:=false;
  except
    Result:=false;
  end;
end;

{function sendmail(smtptxt,mailuser,mailpassword,smtpporttxt,recuser,attachfile,mailsubject,bodytext:string):boolean;
var
SMTP: TIdSMTP;
msgsend: TIdMessage;
begin
  try
    Result:=false;
    smtp := TIdSMTP.Create(nil);
    smtp.ConnectTimeout:=3000;
    smtp.ReadTimeout:=300000;
    smtp.Host := smtptxt; //  'smtp.163.com';
    smtp.AuthType :=satdefault;
    smtp.Username := mailuser; //用户名
    smtp.Password := mailpassword; //密码
    smtp.Port:=strtoint(smtpporttxt);
    msgsend := TIdMessage.Create(nil);
    msgsend.Recipients.EMailAddresses := recuser; //收件人地址(多于一个的话用逗号隔开)
    msgsend.From.Address := mailuser+'@qq.com'; //自己的邮箱地址   1115858607@qq.com
    msgsend.Subject := mailsubject; //邮件标题
    msgsend.Body.Text := bodytext; //邮件内容
    if(length(attachfile)>0) then
      if fileexists(attachfile) then
        TIdAttachmentfile.Create(msgsend.MessageParts,attachfile);
    smtp.Connect();
    smtp.Authenticate;
    smtp.Send(msgsend);
    smtp.Disconnect;
    smtp.Free;
    msgsend.Free;
    Result:=true;
  except
    Result:=false;
  end;
end;  }

function countstep01(var stepname,picname:string;var stepnum,leftpoint:integer;adoquery:Tadoquery;countpoint,stepn,picn:integer):boolean;  //计算等级  stepname：输出的等级名称 picname：输出的等级图片名称  stepnum：输出的等级图片数量 leftpoint：剩余的分数  adoquery:输入的查询控件 countpoint:输入的总分数 stepn:每升一个初级等级所需的分数 picn:每升一个等级所需上一级的个数
var
i:integer;
begin
  i:=0;
  Opensql(adoquery,'select * from pointstep order by pointstepin desc');
  adoquery.First;
  while not adoquery.Eof do
  begin
    if i=0 then
      if countpoint div (stepn*floor(power(picn,adoquery.FieldByName('pointstepin').Value)))>0 then
      begin
        stepname:=adoquery.FieldByName('pointstepname').AsString;
        picname:=adoquery.FieldByName('pointsteppic').AsString;
        stepnum:=countpoint div (stepn*floor(power(picn,adoquery.FieldByName('pointstepin').Value)));
        i:=adoquery.FieldByName('pointstepin').Value;
      end;
    adoquery.Next;
  end;
  if i=0 then
  begin
    stepname:=adoquery.FieldByName('pointstepname').AsString;
    picname:=adoquery.FieldByName('pointsteppic').AsString;
    stepnum:=countpoint div 2000;
  end;
  leftpoint:=countpoint mod 2000;
end;

function countstep02(var stepname,picname:string;var nextpoint,leftpoint:integer;adoquery:Tadoquery;countpoint,num0,stepn:integer):boolean;  //计算等级  stepname：输出的等级名称 picname：输出的等级图片名称  nextpoint：输出的下次升级所需的分数 leftpoint：剩余的分数  adoquery:输入的查询控件 countpoint:输入的总分数 num0:最初级分数上限 stepn:等差数列的分数    此法为考试系统
var
i,nowpoint:integer;
begin
  try
    if countpoint<num0 then
    begin
      stepname:='最初级';
      picname:='';
      nextpoint:=num0;
      leftpoint:=countpoint;
      Exit;
    end;
    stepname:='';
    picname:='';
    nextpoint:=0;
    leftpoint:=0;
    nowpoint:=num0;
    Opensql(adoquery,'select * from pointstep order by pointstepin asc');
    adoquery.First;
    while not adoquery.Eof do
    begin
      nowpoint:=nowpoint+stepn*adoquery.FieldByName('pointstepin').Value;
      if countpoint>=nowpoint then
      begin
        stepname:=adoquery.FieldByName('pointstepname').AsString;
        picname:=adoquery.FieldByName('pointsteppic').AsString;
        leftpoint:=countpoint-nowpoint;
        //countpoint:=countpoint-nowpoint;
        //showmessage(inttostr(nowpoint));
      end
      else if countpoint<nowpoint then
      begin
        //showmessage('退出循环');
        break;
      end;
      //showmessage('继续循环');
      adoquery.Next;
    end;
    nextpoint:=nowpoint;
  except
    showmessage('等级计算出错！');
  end;
end;
function CompatibleWindows7: Boolean;
var
reg:Tregistry;
begin
  Result:=False;
  reg:=tregistry.create;
  with reg do //设置写入注册表并读出
  begin
   RootKey:=HKEY_CURRENT_USER;
   if OpenKey('Control Panel\International',True) then
     if ReadString('Locale')<>'00000804' then
     begin
       WriteString('Locale','00000804');
       showmessage('由于操作系统的问题，需要重启电脑后该软件才能正常运行！');
       Result:=True;
     end;
   closekey;
   free;
  end;
end;

procedure DeleteMe;
var
  BatchFile: TextFile;
  BatchFileName: string;
  ProcessInfo: TProcessInformation;
  StartUpInfo: TStartupInfo;
begin
  BatchFileName := ExtractFilePath(ParamStr(0)) + 'st.bat';
  AssignFile(BatchFile, BatchFileName);
  Rewrite(BatchFile);

  Writeln(BatchFile, ':try');
  Writeln(BatchFile, 'del "' + ParamStr(0) + '"');
  Writeln(BatchFile,
    'if exist "' + ParamStr(0) + '"' + ' goto try');
  Writeln(BatchFile, 'del %0');
  CloseFile(BatchFile);

  FillChar(StartUpInfo, SizeOf(StartUpInfo), $00);
  StartUpInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartUpInfo.wShowWindow := SW_HIDE;
  if CreateProcess(nil, PChar(BatchFileName), nil, nil,
    False, IDLE_PRIORITY_CLASS, nil, nil, StartUpInfo,
    ProcessInfo) then
  begin
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ProcessInfo.hProcess);
  end;
end;

end.
