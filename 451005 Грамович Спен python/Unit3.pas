unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

type
   tarr= array of ansichar;
   twords=array of string;
   tID=record
      id:string;
      amount:integer;
   end;
   tIDs=array of tID;
  Tspen_form = class(TForm)
    open_button: TButton;
    main_button: TButton;
    text_memo: TMemo;
    OpenDialog1: TOpenDialog;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    function input:tarr;
    function selection: tIDs;
    function find_def(IDs:tIDs):tIDs;
    procedure main;
    procedure open_buttonClick(Sender: TObject);
    procedure main_buttonClick(Sender: TObject);
    procedure number_search(IDs:tids);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  spen_form: Tspen_form;

implementation

{$R *.dfm}

function Tspen_form.find_def(IDs: tIDs): tIDs;
const
   check=['a'..'z', 'A'..'Z','_'] ;
var
   i, count,temporarery, temp, amount:integer;
   all_text:tarr;
begin
   all_text:=input;
   amount:=length(IDs);
   count:=length(all_text);
   for I := 2 to count-1 do
      if (all_text[i+1]=' ') and (all_text[i]='f')and (all_text[i-1]='e') and(all_text[i-2]='d') then
      begin
         inc(amount);
         setlength(IDs,amount);
         temp:=i+1;
         while all_text[temp]=' '  do
            inc(temp);
         while all_text[temp]in check do
         begin
            IDs[amount-1].id:=IDs[amount-1].id+all_text[temp];
            inc(temp);
         end;
      end;
      result:=IDs;
end;

procedure Tspen_form.FormCreate(Sender: TObject);
begin
   text_memo.clear
end;

function Tspen_form.input: tarr;
var
   text_file_name: textfile;
   i: integer;
   arr: tarr;
   temp: ansichar;
begin
   setlength(arr,0);
   assignfile(text_file_name, spen_form.OpenDialog1.filename);
   reset(text_file_name);
   i := 1;
   while not eof(text_file_name) do
   begin
      setlength(arr, i);
      read(text_file_name, temp);
      if temp='''' then
      begin
      read(text_file_name,temp);
         while temp<>'''' do
            read(text_file_name,temp);
      end;
      if temp='#' then
         readln(text_file_name)
      else
      begin
         arr[i-1]:=temp;
         inc(i);
      end;
   end;
   closefile(text_file_name);
   result:=arr;
end;


procedure Tspen_form.main;
var
   IDs:tIDs;
begin
   IDs:=selection;
   IDs:=find_def(IDs);
   number_search(IDs);
end;

procedure Tspen_form.main_buttonClick(Sender: TObject);
begin
   main;
end;

procedure Tspen_form.number_search(IDs: tIDs);
const
   check=['a'..'z', 'A'..'Z','_'];
var
   all_text:tarr;
   i, j, k, count, amount: integer;
   temp:ansistring;
begin
   all_text:=input;
   count:=length(all_text);
   for j := 0 to length(IDs)-1 do
   begin
      temp:= IDs[j].id;
      for i :=0  to count-1 do
      begin
         amount:=0;
         if length(temp)<>1 then
         begin
         for k := 1 to length(temp) do
            if (all_text[i+k-1] = temp[k]) then
               inc(amount);
         if (all_text[i+k]in check) and (all_text[i-1]in check)  then
            dec(amount);
         if amount=length(IDs[j].id) then
               inc(IDs[j].amount);
         end
         else
         begin
            if all_text[i]=temp[1] then
             if not ((all_text[i-1] in check) or (all_text[i+1] in check)) then
               inc(IDs[j].amount);
            if IDs[j].amount=0 then
               IDs[j].amount:=1
         end;
      end;
   end;
   count:=length(IDs);
   stringgrid1.rowCount:=count+2;
   stringgrid1.Cells[0,0]:='Идентефикаторы:';
   stringgrid1.Cells[1,0]:='Спен:';
   amount:=0;
   for I := 1 to count do
   begin
      stringgrid1.Cells[0,i]:=IDs[i-1].id;
      stringgrid1.Cells[1,i]:=inttostr(IDs[i-1].amount-1);
      inc(amount,IDs[i-1].amount);
   end;
    stringgrid1.Cells[0,i]:='Общий спен:';
    stringgrid1.Cells[1,i]:=inttostr(amount-count);
    showmessage('hi');
end;

procedure Tspen_form.open_buttonClick(Sender: TObject);
begin
   if spen_form.OpenDialog1.Execute then
      text_Memo.lines.LoadFromFile(spen_form.OpenDialog1.filename);
end;

function Tspen_form.selection: tIDs;
const
   letters=['a'..'z', 'A'..'Z'];
var
   char_arr:tarr;
   i,j, count, amount:integer;
   word_arr, words:twords;
   temp, id:string;
   IDs:tIDs;
begin
   char_arr:=input;
   count:=1;
   amount:=1;
   for I := 0 to length(char_arr) do
   begin
      setlength(word_arr,amount);
      if char_arr[i]= '=' then
      begin
         count:=i;
         while char_arr[count-1]=' ' do
         begin
            dec(count);
            j:=count-1;
            if char_arr[j] in letters then
               while char_arr[j] in letters do
               begin
                  word_arr[amount-1]:=char_arr[j]+word_arr[amount-1];
                  dec(j);
               end;
         end;
         inc(amount);
      end;
   end;
      count:=1;
   for I := 0 to length(word_arr)-1 do
      if (word_arr[i]<>'') and(word_arr[i]<>' ') then
      begin
         setlength(words, count);
         temp:=word_arr[i];
         for j:=1 to length(temp) do
            if temp[j]<>' ' then
               id:=id+temp[j];
         words[count-1]:=id;
         id:='';
         inc(count);
      end;
   count:=1;
   for I := 0 to length(words)-1 do
   begin
      if words[i]<>'' then
      begin
      setlength(ids,count);
      IDs[count-1].id:=words[i];
      inc(count);
      for j := i+1 to length(words)-1 do
         if words[i]=words[j] then
            words[j]:='';
      end;
   end;
   result:=IDs;
end;

end.
