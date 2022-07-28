unit regmainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
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
procedure TForm1.BitBtn1Click(Sender: TObject);
var
i:integer;
lsstr,sr1,sr2,sr3,sr:string;
begin
  for i:=1 to length(Edit1.Text) do
    if Edit1.Text[i]<>'-' then
      lsstr:=lsstr+Edit1.Text[i];
  Memo1.Text:='GDFRg'+lsstr+'DFDSFDSDFSAEFAFDGASRSDFDSGG';
  asm
  db $EB,$10,'VMProtect begin',0
  end;
  lsstr:='';
  sr1:='13579';
  sr2:='2468';
  sr3:='012789MNOPQ3456RSTUVWABCDEFGHIJKLXYZ';
  sr:=formatdatetime('yymmdd',now);
  for i:=1 to length(Edit1.Text) do
    if Edit1.Text[i]<>'-' then
      lsstr:=lsstr+Edit1.Text[i];
  Randomize;//初始化随机种子
  lsstr:=lsstr+copy(sr3,random(length(sr3))+1,1);
  lsstr:=lsstr+copy(sr,2,1);
  Randomize;//初始化随机种子
  lsstr:=lsstr+copy(sr3,random(length(sr3))+1,1);
  lsstr:=lsstr+copy(sr,3,1);
  Randomize;//初始化随机种子
  lsstr:=lsstr+copy(sr3,random(length(sr3))+1,1);
  lsstr:=lsstr+copy(sr,6,1);
  if ComboBox1.Text='月卡' then
    lsstr:=copy(sr1,random(length(sr1))+1,1)+lsstr
  else if ComboBox1.Text='年卡' then
    lsstr:=copy(sr2,random(length(sr2))+1,1)+lsstr;
  Randomize;//初始化随机种子
  lsstr:=copy(sr3,random(length(sr3))+1,1)+lsstr;
  lsstr:=copy(sr,1,1)+lsstr;
  Randomize;//初始化随机种子
  lsstr:=copy(sr3,random(length(sr3))+1,1)+lsstr;
  lsstr:=copy(sr,5,1)+lsstr;
  Randomize;//初始化随机种子            
  lsstr:=copy(sr3,random(length(sr3))+1,1)+lsstr;
  lsstr:=copy(sr,4,1)+lsstr;
  lsstr:=lsstr+Edit2.Text;
  lsstr:=ghhte(lsstr);
  Memo1.Text:=lsstr;
  asm
  db $EB,$0E,'VMProtect end',0
  end;
end;

end.
