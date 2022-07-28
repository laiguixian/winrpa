unit funcs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, dialogs, DB, ADODB, Masks{, VCLUnZip, VCLZip}, jpeg, Graphics, {RzTreeVw
  ,}IdSMTP,IdAttachmentFile, IdMessage,math,registry,HttpApp,ShlObj,ComObj;

Function Opensql(adoquery:Tadoquery;sqlstr:string):boolean;           //��ѯsql
Function Execsql(adoquery:Tadoquery;sqlstr:string):boolean;           //ִ��sql
procedure DeleteMe;  //�Զ�����
//function ZipFileAndPath(const ASrcFilenamelist:Tstringlist;const ASrcFilepath,ADestFilename: string; const APassword: string): Boolean;    //ѹ���ļ����ɺ��ļ���
function DeleteDirectory(NowPath: string;deletepath:boolean): Boolean; // ɾ������Ŀ¼        NowPath: Ҫɾ����Ŀ¼,deletepath���Ƿ�ɾ��Ŀ¼�ļ���
//function ZipToFile(zipFileName:string;FileDir:string):boolean;                                //��ѹ���ļ���ѹ
procedure GetFileListEx(FilePath, ExtMask: string; FileList: TStrings; SubDirectory: Boolean=True);//��ȡ�ض�Ŀ¼�µ�ĳ���ļ����б�
function WhatFile(const FileName: string): string;                       //�ж�ͼƬ��ʽ
function BmpToJpg(temp, path: String; ACQ: Integer): Boolean; stdcall;  //bmpתΪjpg
//function findtreenode(checktree:TRzchecktree;nodename:string):integer;  //��������Ѱ��Ttreenode
function randomizesl(var ressl:Tstringlist;sl:Tstringlist):boolean;  //��stringlist����ַ���˳�������������
function getlistfromstr(var getlist:Tstringlist;strspan:string;sourcestr:string):boolean;//���ָ������ַ�������б���ȡ����  getlist����ȡ���������ڵ��б�  strspan���ָ���  sourcestr��������ַ���
//function sendmail(smtptxt,mailuser,mailpassword,smtpporttxt,recuser,attachfile,mailsubject,bodytext:string):boolean; //�����ʼ�
function CompatibleWindows7: Boolean; //����Windows7
function countstep01(var stepname,picname:string;var stepnum,leftpoint:integer;adoquery:Tadoquery;countpoint,stepn,picn:integer):boolean;  //����ȼ�  stepname������ĵȼ����� picname������ĵȼ�ͼƬ����  stepnum������ĵȼ�ͼƬ���� leftpoint��ʣ��ķ���  adoquery:����Ĳ�ѯ�ؼ� countpoint:������ܷ��� stepn:ÿ��һ�������ȼ�����ķ��� picn:ÿ��һ���ȼ�������һ���ĸ���    �˷������Ա�
function countstep02(var stepname,picname:string;var nextpoint,leftpoint:integer;adoquery:Tadoquery;countpoint,num0,stepn:integer):boolean;  //����ȼ�  stepname������ĵȼ����� picname������ĵȼ�ͼƬ����  nextpoint��������´���������ķ��� leftpoint��ʣ��ķ���  adoquery:����Ĳ�ѯ�ؼ� countpoint:������ܷ��� num0:������������� stepn:�Ȳ����еķ���    �˷�Ϊ����ϵͳ
//procedure DelCookie; //ɾ��cookie
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

���磬 ������� �Ļ� ʹ�� IncMinute����30���ӷ���
   edit1.text ��= DatetimetoStr(IncMinute(datetimepicker.time,30));

}
{
ExtractFileDrive�����������ļ����е�����������"C:"
ExtractFilePath�����������ļ����е�·����������/������"C:/test/"
ExtractFileDir�����������ļ����е�·������󲻴���/�� ,��"C:/test"
ExtractFileName:���������ļ����е��ļ����� (����չ��)����"mytest.doc"
ExtractFileExt ���������ļ����е��ļ���չ������.������".doc"
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

{function ZipFileAndPath(const ASrcFilenamelist:Tstringlist;const ASrcFilepath,ADestFilename: string; const APassword: string): Boolean;    //ѹ���ļ����ɺ��ļ���
var
  VCLZip: TVCLZip;
begin
  VCLZip := TVCLZip.Create(nil);
  with VCLZip do
  try
    try
      ZipName:=ADestFilename;
      RootDir:=ASrcFilepath;    //�ļ�������·��
      OverwriteMode:=Always;//���Ǹ���
      AddDirEntriesOnRecurse:=true;
      DoAll:=true;//ѹ�������ļ�
      RelativePaths:=true;//�Ƿ񱣳�Ŀ¼�ṹ
      if length(APassword)>0 then
        Password := APassword;
      RecreateDirs := True;
      StorePaths := true;
      MultiZipInfo.MultiMode   :=   mmNone;
      FilesList.Text:=ASrcFilenamelist.Text;
      //�ļ�����Ҫѹ�����ļ������Ҫȫ������ֱ����'*.*' ����ֱ�Ӱ�RootDir����Ϊ�ļ���·��������������û���ļ���
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

function DeleteDirectory(NowPath: string;deletepath:boolean): Boolean; // ɾ������Ŀ¼        NowPath: Ҫɾ����Ŀ¼,deletepath���Ƿ�ɾ��Ŀ¼�ļ���
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
    removedir(NowPath); //�����Ҫɾ���ļ��������
  result := True;
end;

procedure GetFileListEx(FilePath, ExtMask: string; FileList: TStrings; SubDirectory: Boolean=True);//��ȡ�ض�Ŀ¼�µ�ĳ���ļ����б�
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

{function ZipToFile(zipFileName:string;FileDir:string):boolean;                                //��ѹ���ļ���ѹ
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

//  1.PngͼƬ�ļ�����8�ֽڣ�89 50 4E 47 0D 0A 1A 0A����Ϊ .PNG....��
//2.JpgͼƬ�ļ�����2�ֽڣ�FF D8��
//3.GifͼƬ�ļ�����6�ֽڣ�47 49 46 38 39|37 61 ����Ϊ GIF89(7)a��
//4.BmpͼƬ�ļ�����2�ֽڣ�42 4D����Ϊ BM��

function WhatFile(const FileName: string): string;                       //�ж��ļ���ʽ
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

function BmpToJpg(temp, path: String; ACQ: Integer): Boolean; stdcall;  //bmpתΪjpg
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

{function findtreenode(checktree:TRzchecktree;nodename:string): integer;  //��������Ѱ��Ttreenode
var
i:integer;
begin
  for i:=0 to checktree.Items.Count-1 do
  begin
    if checktree.Items[i].Text=nodename then
      Result:=i;
  end;
end;}

function randomizesl(var ressl:Tstringlist;sl:Tstringlist):boolean;  //��stringlist����ַ���˳�������������
var
i,j:integer;
aladd,standstr:string;
resuts:Tstringlist;
allin:boolean;
begin
 try
   result:=false;
   //Application.MessageBox(upd.GetText, 'ԭʼ',MB_OK);
   allin:=false;
   aladd:='';
   standstr:='';
   resuts:=Tstringlist.Create;
   resuts.Clear;
   for i:=0 to sl.Count-1 do
     standstr:=standstr+inttostr(i)+',';
   //Application.MessageBox(pchar(standstr), '��׼�ַ�',MB_OK);
   randomize;
   j:=random(sl.Count);
   while not allin do
   begin
     allin:=true;
     for i:=0 to sl.Count-1 do
       if (pos(inttostr(i)+',',aladd)=0) then
       begin
         //Application.MessageBox(pchar(inttostr(i)), '��ǰ���',MB_OK);
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
     //Application.MessageBox(pchar(aladd), '�ۼ��ַ�',MB_OK);
   end;
   ressl.Clear;
   for i:=0 to resuts.Count-1 do
     ressl.Add(resuts.Strings[i]);
   resuts.Free;
   //Application.MessageBox(resuts.GetText, '�����',MB_OK);
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
    smtp.Username := mailuser; //�û���
    smtp.Password := mailpassword; //����
    smtp.Port:=strtoint(smtpporttxt);
    msgsend := TIdMessage.Create(nil);
    msgsend.Recipients.EMailAddresses := recuser; //�ռ��˵�ַ(����һ���Ļ��ö��Ÿ���)
    msgsend.From.Address := mailuser+'@qq.com'; //�Լ��������ַ   1115858607@qq.com
    msgsend.Subject := mailsubject; //�ʼ�����
    msgsend.Body.Text := bodytext; //�ʼ�����
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

function countstep01(var stepname,picname:string;var stepnum,leftpoint:integer;adoquery:Tadoquery;countpoint,stepn,picn:integer):boolean;  //����ȼ�  stepname������ĵȼ����� picname������ĵȼ�ͼƬ����  stepnum������ĵȼ�ͼƬ���� leftpoint��ʣ��ķ���  adoquery:����Ĳ�ѯ�ؼ� countpoint:������ܷ��� stepn:ÿ��һ�������ȼ�����ķ��� picn:ÿ��һ���ȼ�������һ���ĸ���
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

function countstep02(var stepname,picname:string;var nextpoint,leftpoint:integer;adoquery:Tadoquery;countpoint,num0,stepn:integer):boolean;  //����ȼ�  stepname������ĵȼ����� picname������ĵȼ�ͼƬ����  nextpoint��������´���������ķ��� leftpoint��ʣ��ķ���  adoquery:����Ĳ�ѯ�ؼ� countpoint:������ܷ��� num0:������������� stepn:�Ȳ����еķ���    �˷�Ϊ����ϵͳ
var
i,nowpoint:integer;
begin
  try
    if countpoint<num0 then
    begin
      stepname:='�����';
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
        //showmessage('�˳�ѭ��');
        break;
      end;
      //showmessage('����ѭ��');
      adoquery.Next;
    end;
    nextpoint:=nowpoint;
  except
    showmessage('�ȼ��������');
  end;
end;
function CompatibleWindows7: Boolean;
var
reg:Tregistry;
begin
  Result:=False;
  reg:=tregistry.create;
  with reg do //����д��ע�������
  begin
   RootKey:=HKEY_CURRENT_USER;
   if OpenKey('Control Panel\International',True) then
     if ReadString('Locale')<>'00000804' then
     begin
       WriteString('Locale','00000804');
       showmessage('���ڲ���ϵͳ�����⣬��Ҫ�������Ժ����������������У�');
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
