unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids,math;

type
    TForm1 = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    RadioGroup1: TRadioGroup;
    radiorobot: TRadioButton;
    radiopaczka: TRadioButton;
    radioprzeszkoda: TRadioButton;
    Button1: TButton;
    Button2: TButton;
    Checkboxsciezki: TCheckBox;
    Checkboxwierzcholki: TCheckBox;
    Checklista: TCheckBox;
    Checknaroz: TCheckBox;
    CheckRPP: TCheckBox;
    listwierzch: TListBox;
    sasiedz: TStringGrid;
    Checkdijkstrpoko: TCheckBox;
    Checknajdroga: TCheckBox;
    Checksasiedzi: TCheckBox;
    Checklistawierzcholkow: TCheckBox;
    Checkkolorkraw: TCheckBox;
    Checkryssciane: TCheckBox;
    Checkkasujsciane: TCheckBox;
    Label1: TLabel;
    listkrawgraf: TListBox;
    Checklistkrawgraf2: TCheckBox;
    sasiedzigraf2: TStringGrid;
    listkolej: TStringGrid;
    losplan: TButton;
    opcje: TCheckBox;
    dokonca: TButton;
    Label2: TLabel;
    stop: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Label3: TLabel;
    lepiejbox: TCheckBox;
    Label4: TLabel;
    lpedit: TLabel;
    Label6: TLabel;
    lredit: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    ListBox1: TListBox;


  procedure Button1Click(Sender: TObject);
  procedure Button2Click(Sender: TObject);
  procedure WmLButtonDown(var Msg: TMessage); message WM_LBUTTONDOWN;
  procedure WmRButtonDown(var Msg: TMessage); message WM_RBUTTONDOWN;
  procedure FormCreate(Sender: TObject);
  procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);


  procedure CheckboxwierzcholkiClick(Sender: TObject);
  procedure ChecklistaClick(Sender: TObject);
  procedure ChecknarozClick(Sender: TObject);
  procedure CheckRPPClick(Sender: TObject);
  procedure CheckboxsciezkiClick(Sender: TObject);
  procedure ChecklistwierzchClick(Sender: TObject);

  procedure wierzcholki();
  procedure rys();
  procedure krawedzie();
  procedure ustawwartwierzch();
  procedure dijkstra();
  procedure wypelnijlistsasiedz();
  function szuknajdojsc():integer;
  function sprczyjuzbyla( tab:array of integer;n:integer):boolean;
  procedure ruszaj();


    procedure ChecksasiedziClick(Sender: TObject);
    procedure ChecklistawierzcholkowClick(Sender: TObject);
    procedure CheckkolorkrawClick(Sender: TObject);
    procedure ChecknajdrogaClick(Sender: TObject);
    procedure Checklistkrawgraf2Click(Sender: TObject);
    procedure losplanClick(Sender: TObject);
    procedure opcjeClick(Sender: TObject);
    procedure dokoncaClick(Sender: TObject);
    procedure stopClick(Sender: TObject);
    procedure CheckdijkstrpokoClick(Sender: TObject);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure CheckkasujscianeClick(Sender: TObject);
    procedure CheckrysscianeClick(Sender: TObject);


  end;

var
  Form1: TForm1;


  n,pole,marg,xclick,yclick,lwierzchgraf,nies:integer;

  paczki:array of array of integer;
  przeszkody:array of array of integer;
  roboty:array of array of integer;
  robotylista:array of array of integer;
  sasiedzctwo:array of array of integer;
  wierzchlista:array of array of integer;
  twierzcholki:array of array of integer;
  krawlista:array of array of integer;
  zdoprzez:array of array of integer;
  paczkilista:array of array of integer;
  sasiedzgraf:array of array of integer;
  wierzchgraf:array of array of integer;
  krawgraf:array of array of integer;
  kolejnoscgraf:array of array of integer; {
  mrow: array of integer;
  najlepszamrow: array of integer;
  feromon:array of array of integer;
  delferomon:array of array of integer;
  wzietepaczki:array of array of boolean;
  zdo:array of array of integer;            }
  uzyte:array of array of integer;
  dokon:boolean;
  lp,lr:integer;



implementation

{$R *.dfm}
 procedure TForm1.Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState) ;
 var
  State: TKeyboardState;
 begin
      

   if Key=VK_control then
      if checkryssciane.Checked=false then
      begin
         checkkasujsciane.Checked:=false;
         checkryssciane.Checked:=true;
      end
      else
         checkryssciane.Checked:=false;

      if Key=VK_SHIFT then
        if checkkasujsciane.Checked=false then
        begin
         checkkasujsciane.Checked:=true;
         checkryssciane.Checked:=false;
        end
        else
         checkkasujsciane.Checked:=false;
 end;
procedure TForm1.WmLButtonDown(var Msg: TMessage);
var
x,y,tmp,i,j:integer;
begin
    if (checkryssciane.Checked=true) or (checkkasujsciane.Checked=true) and (not(checkryssciane.Checked=true and checkkasujsciane.Checked=true)) then
  begin
  x:=trunc((((Msg.LParamLo)-marg) /pole)* n);
  y:=trunc((((Msg.LParamHi)-5) /pole)* n);
   begin
    if xclick>x then begin tmp:=x; x:=xclick; xclick:=tmp; end;
    if yclick>y then begin tmp:=y; y:=yclick; yclick:=tmp; end;
    for i:=xclick to x do
     for j:=yclick to y do
      begin
        if (roboty[i][j]=0) and (paczki[i][j]=0) then
        begin
         if (checkryssciane.Checked=true) then przeszkody[i][j]:=1 else przeszkody[i][j]:=0;
        end;
      end;
    checkryssciane.Checked:=false;
    checkkasujsciane.Checked:=false;
   end;
  end
  else
  begin
  x:=trunc(Msg.LParamLo)-marg;
  y:=trunc(Msg.LParamHi)-5;
  if(x<=pole-1)and(y<=(pole-1))and (x>=0) and (y>=0)then
  begin

    if(radiorobot.Checked=true) and  (paczki[trunc((x /pole)* n)][trunc((y /pole)* n)]=0) and (przeszkody[trunc((x /pole)* n)][trunc((y /pole)* n)]=0)then
    begin
      if roboty[trunc((x /pole)* n)][trunc((y /pole)* n)]=0  then
          begin
          roboty[trunc((x /pole)* n)][trunc((y /pole)* n)]:=1;
          lr:=lr+1;
          end
          else
          begin
          roboty[trunc((x /pole)* n)][trunc((y /pole)* n)]:=roboty[trunc((x /pole)* n)][trunc((y /pole)* n)]+1;
          if roboty[trunc((x /pole)* n)][trunc((y /pole)* n)]>8 then roboty[trunc((x /pole)* n)][trunc((y /pole)* n)]:=1;
          end;
     end;
    if(radiopaczka.Checked=true) and (przeszkody[trunc((x /pole)* n)][trunc((y /pole)* n)]=0) and (roboty[trunc((x /pole)* n)][trunc((y /pole)* n)]=0) then begin paczki[trunc((x /pole)* n)][trunc((y /pole)* n)]:=1; lp:=lp+1; end;
    if(radioprzeszkoda.Checked=true) and (paczki[trunc((x /pole)* n)][trunc((y /pole)* n)]=0) and (roboty[trunc((x /pole)* n)][trunc((y /pole)* n)]=0)then przeszkody[trunc((x /pole)* n)][trunc((y /pole)* n)]:=1 else if (przeszkody[trunc((x /pole)* n)][trunc((y /pole)* n)]=0) then lwierzchgraf:=lwierzchgraf+1;

  end;
 end;
  rys();
  xclick:=trunc((((Msg.LParamLo)-marg) /pole)* n);
  yclick:=trunc((((Msg.LParamHi)-5) /pole)* n);

end;
procedure TForm1.WmRButtonDown(var Msg: TMessage);
var
x,y:integer;
begin
  x:=(Msg.LParamLo)-marg+1;
  y:=(Msg.LParamHi)-5;

  if(x<=pole-1)and(y<=pole-1)and (x>=0) and (y>=0)then
  begin
    if(roboty[trunc((x /pole)* n)][trunc((y /pole)* n)]<>0)then lr:=lr-1;
    if(paczki[trunc((x /pole)* n)][trunc((y /pole)* n)]=1)then lp:=lp-1;
    roboty[trunc((x /pole)* n)][trunc((y /pole)* n)]:=0;
    paczki[trunc((x /pole)* n)][trunc((y /pole)* n)]:=0;
    przeszkody[trunc((x /pole)* n)][trunc((y /pole)* n)]:=0;
  end;
  rys();
end;

procedure TForm1.rys();
var
i,j:integer;
prostokat1:TRect;
A,B,C:Tpoint;
begin
       n:=strtoint(Edit1.text);
       if n=0 then n:=1;
      lpedit.Caption := inttostr(lp);
      lredit.Caption := inttostr(lr);
      SetLength(roboty, n ,n);
      SetLength(paczki, n ,n);
      SetLength(twierzcholki, n ,n);
      SetLength(przeszkody, n ,n);
      uzyte:=0;
      SetLength(uzyte, n ,n);

      pole:=ClientHeight-20;
    prostokat1:=Rect(0,0,ClientWidth,ClientHeight);
    Canvas.Brush.Color:=clWhite;
    canvas.Pen.Color:=rgb(255,255,255);
    Canvas.FillRect(prostokat1);
    marg:=round((ClientWidth-140-pole)/2);
        canvas.Pen.Color:=rgb(0,0,0);
    if nies<>999999999 then nies:=999999999;

        // rysowanie szachownicy
        if n<100 then
       for i:=0 to n do
     begin
      Canvas.MoveTo(marg,round(5+i*(pole/n)));
      Canvas.LineTo(marg+pole,round(5+(i*(pole/n))));
      Canvas.MoveTo(round(marg+(i*(pole/n))),5);
      Canvas.lineTo(round(marg+(i*(pole/n))),pole+5);
     end
     else
     begin
      Canvas.MoveTo(marg,round(5+n*(pole/n)));
      Canvas.LineTo(marg+pole,round(5+(n*(pole/n))));
      Canvas.MoveTo(round(marg+(n*(pole/n))),5);
      Canvas.lineTo(round(marg+(n*(pole/n))),pole+5);
      Canvas.MoveTo(marg,5);
      Canvas.LineTo(marg+pole,5);
      Canvas.MoveTo(marg,5);
      Canvas.lineTo(marg,pole+5);
     end;
    //tu
    canvas.brush.Color:=rgb(0,0,0);

    if Checkboxsciezki.Checked then
     for i:=0 to high(krawlista) do
     begin
      if checkkolorkraw.Checked=true then
      begin
       canvas.Pen.Width:=2;
       if krawlista[i][4]=1 then canvas.pen.Color:=rgb(200,255,200);
       if krawlista[i][4]=2 then canvas.pen.Color:=rgb(150,225,150);
       if krawlista[i][4]=3 then canvas.pen.Color:=rgb(50,225,100);
       if krawlista[i][4]=4 then canvas.pen.Color:=rgb(50,200,50);
      end;
      Canvas.MoveTo(round(marg+(wierzchlista[(krawlista[i][0])][0])*(pole/n)+(pole/n)/2),round(5+wierzchlista[(krawlista[i][0])][1]*(pole/n)+(pole/n)/2+1));
      Canvas.lineTo(round(marg+(wierzchlista[(krawlista[i][1])][0])*(pole/n)+(pole/n)/2),round(5+wierzchlista[(krawlista[i][1])][1]*(pole/n)+(pole/n)/2+1));

      canvas.Pen.Color:=rgb(0,0,0);
     end;
      canvas.Pen.Width:=1;
     for i:=0 to n-1 do
     begin
      for j:=0 to n-1 do
      begin
  //    Canvas.TextOut(round(marg+i*(pole/n))+1,round(5+j*(pole/n))+1, inttostr(uzyte[i][j]));

      {  if (uzyte[i][j]<>0) then
        begin
         Canvas.MoveTo(round(i*(pole/n)),round(j*(pole/n)));
         Canvas.lineTo(round((i*(pole/n))+(pole/n)),round((j*(pole/n))+(pole/n)));
        end;}

        if (paczki[i][j]=1) or (przeszkody[i][j]=1) then
        begin
          prostokat1:=Rect(           round(marg+(i*(pole/n)+(pole/n)/8)),
                                      round(5+j*(pole/n)+(pole/n)/8),
                                      round(marg+i*(pole/n)+(pole/n)*7/8),
                                      round(5+j*(pole/n)+(pole/n)*7/8)    );


          if paczki[i][j]=1 then Canvas.Brush.Color:=rgb(0,183,0);
          if przeszkody[i][j]=1 then Canvas.Brush.Color:=rgb(183,56,36);
          canvas.Rectangle(prostokat1);
        end;
        if roboty[i][j]<>0 then
        begin
          Canvas.Brush.Color:=rgb(183,0,0);
        case roboty[i][j] of
                1:
        begin
          A:=Point(round(marg+i*(pole/n)),round(5+j*(pole/n)));
          B:=Point(round(marg+i*(pole/n)+(pole/n)/2),round(5+j*(pole/n)+(pole/n)+1));
          C:=Point(round(marg+(i*(pole/n)+(pole/n))),round(5+j*(pole/n)));
        end;

        2:
        begin
                A:=Point(round(marg+(i*(pole/n)+(pole/n)/2)),round(5+j*(pole/n)));
          B:=Point(round(marg+i*(pole/n)+(pole/n)),round(5+j*(pole/n)+(pole/n)/2));
          C:=Point(round(marg+i*(pole/n)),round(5+j*(pole/n)+(pole/n)));
        end;
        3:
        begin
          A:=Point(round(marg+(i*(pole/n)+(pole/n))),round(5+j*(pole/n)));
          B:=Point(round(marg+i*(pole/n)),round(5+j*(pole/n)+(pole/n)/2));
          C:=Point(round(marg+i*(pole/n)+(pole/n)),round(5+j*(pole/n)+(pole/n)));

        end;
        4:
        begin
          A:=Point(round(marg+i*(pole/n)),round(5+j*(pole/n)));
          B:=Point(round(marg+i*(pole/n)+(pole/n)),round(5+j*(pole/n)+(pole/n)/2));
          C:=Point(round(marg+(i*(pole/n)+(pole/n)/2)),round(5+j*(pole/n)+(pole/n)));
        end;
        5:
        begin
          A:=Point(round(marg+i*(pole/n)+(pole/n)/2),round(5+j*(pole/n)));
          B:=Point(round(marg+i*(pole/n)),round(5+j*(pole/n)+(pole/n)));
          C:=Point(round(marg+(i*(pole/n)+(pole/n))),round(5+j*(pole/n)+(pole/n)));
        end;
        6:
        begin
          A:=Point(round(marg+i*(pole/n)+(pole/n)),round(5+j*(pole/n)));
          B:=Point(round(marg+i*(pole/n)),round(5+j*(pole/n)+(pole/n)/2));
          C:=Point(round(marg+(i*(pole/n)+(pole/n)/2)),round(5+j*(pole/n)+(pole/n)));
        end;
        7:
        begin
          A:=Point(round(marg+i*(pole/n)),round(5+j*(pole/n)));
          B:=Point(round(marg+i*(pole/n)+(pole/n)),round(5+j*(pole/n)+(pole/n)/2));
          C:=Point(round(marg+(i*(pole/n))),round(5+j*(pole/n)+(pole/n)));
        end;
        8:
        begin
          A:=Point(round(marg+i*(pole/n)+(pole/n)),round(5+j*(pole/n)+(pole/n)));
          B:=Point(round(marg+i*(pole/n)),round(5+j*(pole/n)+(pole/n)/2));
          C:=Point(round(marg+(i*(pole/n)+(pole/n)/2)),round(5+j*(pole/n)));
        end;

        end;
         canvas.Polygon([A,B,C]);
        end;

      end;
     end;
      //rysowanie polaczonych wierzcholkow
     listwierzch.clear();
     for i:=0 to high(wierzchlista) do
     begin

      listwierzch.Items[i]:='i='+inttostr(i)+' x,y: '+inttostr(wierzchlista[i][0])+','+inttostr(wierzchlista[i][1])+' Q/S: '+inttostr(wierzchlista[i][2])+' odl:'+floattostr(wierzchlista[i][3]/10)+' poprzednik: '+inttostr(wierzchlista[i][4]);
     if (checknajdroga.Checked=true)and(lp>0) then    //rys najkrotszej drogi
     begin
      Canvas.Pen.Color := rgb(255,0,0);
      if n<100 then canvas.Pen.Width:=4;
      Canvas.MoveTo(round(marg+(wierzchlista[i][0])*(pole/n)+(pole/n)/2),round(5+wierzchlista[i][1]*(pole/n)+(pole/n)/2+1));
      if wierzchlista[i][4] <> -1 then Canvas.lineTo(round(marg+(wierzchlista[wierzchlista[i][4]][0])*(pole/n)+(pole/n)/2),round(5+wierzchlista[wierzchlista[i][4]][1]*(pole/n)+(pole/n)/2+1));
     end;
      Canvas.Pen.Color := rgb(0,0,0);
      canvas.Pen.Width:=1;
    if Checkboxwierzcholki.Checked then  //rysownie wierzcholkow
    begin
      if(wierzchlista[i][2]=1) then canvas.brush.Color:=rgb(150,100,255)else canvas.brush.Color:=rgb(255,100,150);
      canvas.Ellipse( round(marg+wierzchlista[i][0]*(pole/n)+(pole/n)/3),
                          round(5+wierzchlista[i][1]*(pole/n)+(pole/n)/3),
                          round(marg+wierzchlista[i][0]*(pole/n)+(pole/n)*2/3),
                          round(5+wierzchlista[i][1]*(pole/n)+(pole/n)*2/3)     );
        canvas.Brush.Color:=rgb(255,255,255);
       Canvas.TextOut(round(marg+wierzchlista[i][0]*(pole/n))+1,round(5+wierzchlista[i][1]*(pole/n))+1, inttostr(i));
    end;
    end;
end;
procedure TForm1.wierzcholki();
var
i,j:integer;
g,d,p,l:Boolean;
begin
g:=true;
d:=true;
p:=true;
l:=true;
    for i:=0 to n-1 do
    for j:=0 to n-1 do
       twierzcholki[i][j]:=0;

  for i:=0 to n-1 do
  begin
    for j:=0 to n-1 do
     begin
       if roboty[i][j]<>0 then begin twierzcholki[i][j]:=1; end;
       if paczki[i][j]=1 then twierzcholki[i][j]:=1;
       if (przeszkody[i][j]=1) then
       begin
          g:=true;
          d:=true;
          p:=true;
          l:=true;
         if (i=0) or (i=n-1) or (j=0) or (j=n-1) then
         begin
          if((i=0) or (przeszkody[i-1][j]=1) ) then g:=false;
          if((i=n-1) or (przeszkody[i+1][j]=1)) then d:=false;
          if((j=0) or (przeszkody[i][j-1]=1)) then l:=false;
          if((j=n-1) or (przeszkody[i][j+1]=1)) then p:=false;
         end;
          if not((i=0) or (i=n-1) or (j=0) or (j=n-1)) then
           begin
            if ((przeszkody[i][j-1]=1) and (przeszkody[i][j+1]=1)) then begin g:=false; d:=false; l:=false; p:=false; end;
            if ((przeszkody[i+1][j]=1) and (przeszkody[i-1][j]=1)) then begin l:=false; p:=false; l:=false; p:=false; end;
            if ((przeszkody[i-1][j-1]=1) and (przeszkody[i+1][j+1]=1)) then begin g:=false; d:=false; l:=false; p:=false; end;
            if ((przeszkody[i+1][j-1]=1) and (przeszkody[i-1][j+1]=1)) then begin g:=false; d:=false; l:=false; p:=false; end;
           end;
           if Checknaroz.Checked then
           begin
          if(g=true) then if(przeszkody[i-1][j]=0) then twierzcholki[i-1][j]:=1;
          if(d=true) then if(przeszkody[i+1][j]=0) then twierzcholki[i+1][j]:=1;
          if(l=true) then if(przeszkody[i][j-1]=0) then twierzcholki[i][j-1]:=1;
          if(p=true) then if(przeszkody[i][j+1]=0) then twierzcholki[i][j+1]:=1;
          end;
          if(g=true) and (p=true)  then if(przeszkody[i-1][j+1]=0)and(przeszkody[i-1][j]=0)and(przeszkody[i][j+1]=0) then twierzcholki[i-1][j+1]:=1;
          if(g=true) and (l=true)  then if(przeszkody[i-1][j-1]=0)and(przeszkody[i-1][j]=0)and(przeszkody[i][j-1]=0) then twierzcholki[i-1][j-1]:=1;
          if(d=true) and (p=true)  then if(przeszkody[i+1][j+1]=0)and(przeszkody[i+1][j]=0)and(przeszkody[i][j+1]=0) then twierzcholki[i+1][j+1]:=1;
          if(d=true) and (l=true)  then if(przeszkody[i+1][j-1]=0)and(przeszkody[i+1][j]=0)and(przeszkody[i][j-1]=0) then twierzcholki[i+1][j-1]:=1;
       end;
    end;
  end;
  setlength(wierzchlista,0,5);
  for i:=0 to n-1 do
    for j:=0 to n-1 do
      if(twierzcholki[i][j]=1)then
      begin
      setlength(wierzchlista,high(wierzchlista)+2,5);
       wierzchlista[high(wierzchlista)][0]:=i;
       wierzchlista[high(wierzchlista)][1]:=j;

       {if paczki[i][j]=1 then
       begin
       setlength(paczkilista,high(paczkilista)+2,2);
       paczkilista[high(paczkilista)][0]:=i;
       paczkilista[high(paczkilista)][1]:=j;
       //listpaczek
       end;        }
     end;

end;
procedure TForm1.krawedzie();
var
i,j,k,l,x,y,a,m,p,r,pomx,pomy:integer;
o:real;
begin
SetLength(krawlista, 0, 0);
SetLength(sasiedzctwo, high(wierzchlista)+2,  high(wierzchlista)+2);
  for p:=0 to high(wierzchlista) do
          for r:=0 to high(wierzchlista) do
           if p<>r then
            begin
              sasiedzctwo[p][r]:=nies;
              sasiedzctwo[r][p]:=nies;
            end;

  for p:=0 to high(wierzchlista) do
  begin
          for r:=0 to high(wierzchlista) do
           begin
            i:=wierzchlista[p][0];
            j:=wierzchlista[p][1];
            k:=wierzchlista[r][0];
            l:=wierzchlista[r][1];
                  //----spr czy nie ma przeszkod lub pktów pomiedzy pktami

                  if(p<>r) then
                  begin
                    pomx:=i;
                    pomy:=j;
                    if k>i then x:=(k-i) else x:=(i-k);
                    if l>j then y:=(l-j) else y:=(j-l);
                    if(x>y) then a:=x else a:=y;
                    for m:=0 to a do
                      begin
                     {  if (pomx<>k) and (pomy<>k)then
                        begin
                         if(pomx<k)and (pomy<l)then begin twierzcholki[k-1][l-1]:=1; end;
                         if(pomx<k)and (pomy>l)then begin twierzcholki[k-1][l+1]:=1; end;
                         if(pomx>k)and(pomy<l)then begin twierzcholki[k+1][l-1]:=1; end;
                         if(pomx>k)and(pomy>l)then begin twierzcholki[k+1][l+1]:=1; end;
                         o:=o+0.5;
                        end;}
                        if (pomx<k) and (pomy<l) and (przeszkody[pomx+1][pomy]=1) and (przeszkody[pomx][pomy+1]=1) then break;
                        if (pomx<k) and (pomy>l) and (przeszkody[pomx+1][pomy]=1) and (przeszkody[pomx][pomy-1]=1) then break;
                        if (pomx>k) and (pomy<l) and (przeszkody[pomx-1][pomy]=1) and (przeszkody[pomx][pomy+1]=1) then break;
                        if (pomx>k) and (pomy>l) and (przeszkody[pomx-1][pomy]=1) and (przeszkody[pomx][pomy-1]=1) then break;
                        begin
                        if(pomx<k)then begin pomx:=pomx+1;  end;
                        if(pomx>k)then begin pomx:=pomx-1;  end;
                        if(pomy<l)then begin pomy:=pomy+1;  end;
                        if(pomy>l)then begin pomy:=pomy-1;  end;
                        end;
                        if(przeszkody[pomx][pomy]=1) then break;
                        if((twierzcholki[pomx][pomy]=1)and not((pomx=k)and (pomy=l))) then break;
                        if (pomx=k) and (pomy=l) then
                        begin
                        o:=(sqrt(x*x+y*y)*10);
                        SetLength(krawlista, (high(krawlista)+2), 5);
                        krawlista[high(krawlista)][0]:=p;  //x pirwsz
                        krawlista[high(krawlista)][1]:=r;  //y pierwsz
                        krawlista[high(krawlista)][2]:=k;  //x drug
                        krawlista[high(krawlista)][3]:=l;  //y drug
                        krawlista[high(krawlista)][4]:=round(o); //dlugosc
                        sasiedzctwo[p][r]:=trunc(o);
                        //sasiedzctwo[r][p]:=o;
                        ListBox1.Items[high(krawlista)] := 'z '+inttostr(wierzchlista[krawlista[high(krawlista)][0]][0])+','+inttostr(wierzchlista[krawlista[high(krawlista)][0]][1])+' do '+inttostr(wierzchlista[krawlista[high(krawlista)][1]][0])+','+inttostr(wierzchlista[krawlista[high(krawlista)][1]][1])+' d³: '+floattostr((o/10));
                        break;
                        end;
                  end;

                end;
              end;
           end;
end;
procedure TForm1.ustawwartwierzch();
var
i:integer;
begin
for i:=0 to high(wierzchlista) do
   begin
       wierzchlista[i][2]:=1;  //Q=1 v S=0
       wierzchlista[i][3]:=nies;  //odleg³osc do pktu
       wierzchlista[i][4]:=-1;  //poprzednik
   end;
end;
function TForm1.szuknajdojsc():integer;
var
m,l,o:integer;
begin
m:=nies;
     for l:=0  to high(wierzchlista) do //szuk najmniejszego d(o)
     begin
       if (wierzchlista[l][3]<m) and (wierzchlista[l][2]=1) then begin m:=wierzchlista[l][3]; o:=l; end//o=index pktu najmnieszego dojscia
     end;
 result:=o;
end;



procedure TForm1.dijkstra();
var
i,j,k,l,m,o,p,r,pom,pom2,    najkr,tam,krok,s,high2:integer;
str:string;
begin

setlength(robotylista,0,0);
    pom2:=0;
    Setlength(krawgraf,0,0);//lwierzchgraf*(lwierzchgraf-1) div 2,5);
    kolejnoscgraf:=0;
    setlength(kolejnoscgraf,0,0);
    setlength(wierzchgraf,0,0);
    listkrawgraf.Clear();
{etlength(sasiedzgraf,high(wierzchlista)+1,high(wierzchlista)+1);
setlength(wierzchgraf,high(wierzchlista)+1);
setlength(krawgraf,high(wierzchlista)+1);
setlength(kolejnoscgraf,high(wierzchlista),high(wierzchlista)+1);    }
for i:=0 to high(sasiedzgraf) do
  for j:=0 to high(sasiedzgraf) do
  begin
    sasiedzgraf[i][j]:=nies;
    sasiedzgraf[i][j]:=nies;
  end;

for i:=0 to high(wierzchlista) do
if {(roboty[wierzchlista[i][0]][wierzchlista[i][1]]<>0)then//or}(paczki[wierzchlista[i][0]][wierzchlista[i][1]]=1)then
 begin //droga z w[i]
  ustawwartwierzch();
  wierzchlista[i][3]:=0;               //dojscie(vo) <- 0


  for k:=0 to high(wierzchlista) do //az Q = 0
   begin
     o:=szuknajdojsc();
     wierzchlista[o][2]:=0;    // Vo z Q do S
     for l:=0 to high(wierzchlista) do //wszystkie krawedzie ktore ³aca pkt z innym
     begin


       if {(wierzchlista[l][2]=1) and} (wierzchlista[l][3]>sasiedzctwo[o][l]+wierzchlista[o][3])and(sasiedzctwo[o][l]<>nies) then
       begin
         wierzchlista[l][3]:=sasiedzctwo[o][l]+wierzchlista[o][3]; //odl do pktu
         wierzchlista[l][4]:=o;                                    //poprzednik

         application.ProcessMessages;
         if Checkdijkstrpoko.Checked=true then
         begin
         rys();
         sleep(200);
         end;
       end;
     end;
   end;
//--------------------------przewidywanie ruchu---------------------------------
  najkr:=nies;
  pom:=0;
  tam:=-1;
  pom2:=-1;
  for k:=0 to high(wierzchlista) do
  begin
    if (wierzchlista[k][3]<najkr) and (roboty[wierzchlista[k][0]][wierzchlista[k][1]]<>0) then begin najkr:=wierzchlista[k][3]; tam:=k; end;
    //if paczki[wierzchlista[k][0]][wierzchlista[k][1]]=1 then tam:=k
  end;
  {pom:=tam;

  while wierzchlista[pom][4]>=0 do
    begin

       if wierzchlista[pom][4]>=0 then pom2:=pom; pom:=wierzchlista[pom][4];
    end;
    Edit2.text:=inttostr(pom2);
    tam:=pom2;}

     if ((lp<=lr) or (lr=1)) or (lepiejbox.Checked=true) then
   if (tam=-1) then
    begin
    najkr:=nies;
     for s:=0 to high(robotylista) do
     begin
      if robotylista[s][5]>wierzchlista[robotylista[s][6]][3] then begin   pom2:=s; end;
     end;
     if pom2<>-1 then
     begin
      tam:=robotylista[pom2][6];
       najkr:=wierzchlista[robotylista[pom2][6]][3];
       roboty[robotylista[pom2][0]][robotylista[pom2][1]]:=robotylista[pom2][4];
        uzyte[robotylista[pom2][2]][robotylista[pom2][3]]:=0;
        robotylista[pom2][7]:=0;
      pom:=1;
     end
    end;


    if (tam<>-1) and (tam<>i) then
    if (roboty[wierzchlista[tam][0]][wierzchlista[tam][1]]<>0)  then  // zabezpieczenie gdy nie ma do zbierania przed klonowaniem

    begin
    if pom=0 then begin setlength(robotylista,high(robotylista)+2,8); high2:=high(robotylista); end else high2:=pom2;
  //  if not(przeszkody[robotylista[high(robotylista)][3]][robotylista[high(robotylista)][4]]=1) then przeszkody[wierzchlista[tam][0]][wierzchlista[tam][1]]:=0;


    robotylista[high2][0]:=wierzchlista[tam][0];//gdzie by³ x
    robotylista[high2][1]:=wierzchlista[tam][1];//gdzie by³ y
     robotylista[high2][4] :=  roboty[robotylista[high(robotylista)][0]][robotylista[high(robotylista)][1]]; //spin robota
    robotylista[high2][5]:=najkr;               //ile bedzie mial bo paczki
    robotylista[high2][6]:=tam;                 //index wierzchlista wybranego robota
    roboty[wierzchlista[tam][0]][wierzchlista[tam][1]]:=0;
    robotylista[high2][7]:=1;
    { robotylista[high2][2]:=wierzchlista[i][0];
     robotylista[high2][3]:=wierzchlista[i][1];}

    if wierzchlista[tam][0] > wierzchlista[wierzchlista[tam][4]][0] then  robotylista[high2][2]:=wierzchlista[tam][0]-1;
    if wierzchlista[tam][0] < wierzchlista[wierzchlista[tam][4]][0] then  robotylista[high2][2]:=wierzchlista[tam][0]+1;
    if wierzchlista[tam][1] > wierzchlista[wierzchlista[tam][4]][1] then  robotylista[high2][3]:=wierzchlista[tam][1]-1;
    if wierzchlista[tam][1] < wierzchlista[wierzchlista[tam][4]][1] then  robotylista[high2][3]:=wierzchlista[tam][1]+1;

    if wierzchlista[tam][0] = wierzchlista[wierzchlista[tam][4]][0] then  robotylista[high2][2]:=wierzchlista[tam][0];
    if wierzchlista[tam][1] = wierzchlista[wierzchlista[tam][4]][1] then  robotylista[high2][3]:=wierzchlista[tam][1];

    //uzyte[wierzchlista[tam][0]][wierzchlista[tam][1]]:=0;
    //zapis uzytych miejsc   z uwzglednieniem w³asciciela
if uzyte[robotylista[high2][2]][robotylista[high2][3]]=0 then uzyte[robotylista[high2][2]][robotylista[high2][3]]:=high2+1;

  { if (uzyte[robotylista[high2][2]][robotylista[high2][3]]=-1) then
   begin
   robotylista[high2][2]:=robotylista[high2][0];
   robotylista[high2][3]:=robotylista[high2][1];
   end;
   }
  // przeszkody[robotylista[high(robotylista)][3]][robotylista[high(robotylista)][4]]:=2;
   // Edit2.text  :=  Edit2.text + 'z:'+inttostr(robotylista[high(robotylista)][0])+','+inttostr(robotylista[high(robotylista)][1])+' do:'+inttostr(robotylista[high(robotylista)][2])+','+inttostr(robotylista[high(robotylista)][3]);
    end;

//----------------------
 end;

end;
procedure TForm1.wypelnijlistsasiedz();
var
i,j:integer;
begin

         sasiedz.RowCount:=high(wierzchlista)+1;
         sasiedz.ColCount:=high(wierzchlista)+1;
  for i:=0 to high(wierzchlista) do
  begin
     for j:=0 to high(wierzchlista) do
       begin
         sasiedz.Cells[i,j]:=inttostr(sasiedzctwo[i][j]);
       end;
  end;
end;
function TForm1.sprczyjuzbyla(tab:array of integer;n:integer):boolean;
var
i:integer;
begin
 for i:=0 to high(wierzchgraf) do
 begin
  if tab[i]=n then result:=true;
 end;
 result:=false;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
i,j:integer;
begin
 // rys();
   if CheckRPP.checked=true then
   begin
    roboty[2][2]:=1;
    przeszkody[4][4]:=1;
    paczki[6][6]:=1;
    {
    roboty[0][0]:=1;
    przeszkody[0][1]:=1;
    paczki[4][9]:=1;
    paczki[5][8]:=1;}
   end;
  wierzcholki();
  krawlista:=0;
  krawedzie();

  if not((lr=0)or(lp=0)) then
  begin
    wypelnijlistsasiedz();
     //--------------tablice dijktry
       Setlength(sasiedzgraf,high(wierzchlista)+1,high(wierzchlista)+1);
       //------------------------

  dijkstra();
  ruszaj();
  end;
  rys();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     listwierzch.Clear();
     roboty:=0;
     przeszkody:=0;
     krawlista:=0;
     paczki:=0;
     listbox1.Clear();
     sasiedzctwo:=0;
     lp:=0;
     lr:=0;
     twierzcholki:=0;
   rys();
     Button1Click(Form1);
end;
procedure TForm1.ruszaj();
var
i:integer;
p:boolean;
begin
for i:=0 to high(robotylista) do
begin
 p:=false;
if (robotylista[i][0]= robotylista[i][2]) and (robotylista[i][1]> robotylista[i][3]) and (robotylista[i][4]=5) then p:=true;
if (robotylista[i][0]= robotylista[i][2]) and (robotylista[i][1]< robotylista[i][3]) and (robotylista[i][4]=1)  then p:=true;
if (robotylista[i][0]> robotylista[i][2]) and (robotylista[i][1]= robotylista[i][3]) and (robotylista[i][4]=3)  then p:=true;
if (robotylista[i][0]< robotylista[i][2]) and (robotylista[i][1]= robotylista[i][3]) and (robotylista[i][4]=7)  then p:=true;
if (robotylista[i][0]< robotylista[i][2]) and (robotylista[i][1]> robotylista[i][3]) and (robotylista[i][4]=6)  then p:=true;
if (robotylista[i][0]< robotylista[i][2]) and (robotylista[i][1]< robotylista[i][3]) and (robotylista[i][4]=8)  then p:=true;
if (robotylista[i][0]> robotylista[i][2]) and (robotylista[i][1]> robotylista[i][3]) and (robotylista[i][4]=4)  then p:=true;
if (robotylista[i][0]> robotylista[i][2]) and (robotylista[i][1]< robotylista[i][3]) and (robotylista[i][4]=2)  then p:=true;
 //p:=true;
if p=true then
begin
  if  (uzyte[robotylista[i][2]][robotylista[i][3]]=i+1) and (roboty[robotylista[i][2]][robotylista[i][3]]=0) then
   begin
     uzyte[robotylista[i][0]][robotylista[i][1]]:=0;
     roboty[robotylista[i][2]][robotylista[i][3]]:=robotylista[i][4];
   end
  else
  begin
  roboty[robotylista[i][0]][robotylista[i][1]]:=robotylista[i][4];
 end;
{ end //;
 else    //if(uzyte[robotylista[i][2]][robotylista[i][3]]<>i+1) then
 begin
 //if not(uzyte[robotylista[i][2]][robotylista[i][3]]=i+1) then edit2.text:=edit2.text+inttostr(robotylista[i][6])+'   ';
roboty[robotylista[i][0]][robotylista[i][1]]:=robotylista[i][4];
 end;}
if paczki[robotylista[i][2]][robotylista[i][3]]=1 then begin paczki[robotylista[i][2]][robotylista[i][3]]:=0; lp:=lp-1; end;
end
else
begin
Edit2.Text:=Edit2.Text+' ju¿'+inttostr(i);
if (robotylista[i][0]= robotylista[i][2]) and (robotylista[i][1]> robotylista[i][3]) then roboty[robotylista[i][0]][robotylista[i][1]]:=5;
if (robotylista[i][0]= robotylista[i][2]) and (robotylista[i][1]< robotylista[i][3]) then roboty[robotylista[i][0]][robotylista[i][1]]:=1;
if (robotylista[i][0]> robotylista[i][2]) and (robotylista[i][1]= robotylista[i][3]) then roboty[robotylista[i][0]][robotylista[i][1]]:=3;
if (robotylista[i][0]< robotylista[i][2]) and (robotylista[i][1]= robotylista[i][3]) then roboty[robotylista[i][0]][robotylista[i][1]]:=7;
if (robotylista[i][0]< robotylista[i][2]) and (robotylista[i][1]> robotylista[i][3]) then roboty[robotylista[i][0]][robotylista[i][1]]:=6;
if (robotylista[i][0]< robotylista[i][2]) and (robotylista[i][1]< robotylista[i][3]) then roboty[robotylista[i][0]][robotylista[i][1]]:=8;
if (robotylista[i][0]> robotylista[i][2]) and (robotylista[i][1]> robotylista[i][3]) then roboty[robotylista[i][0]][robotylista[i][1]]:=4;
if (robotylista[i][0]> robotylista[i][2]) and (robotylista[i][1]< robotylista[i][3]) then roboty[robotylista[i][0]][robotylista[i][1]]:=2;
end;

end;
end;
procedure TForm1.CheckboxsciezkiClick(Sender: TObject);
begin
rys();
end;

procedure TForm1.CheckboxwierzcholkiClick(Sender: TObject);
begin
rys();

end;

procedure TForm1.ChecklistaClick(Sender: TObject);
begin
if Checklista.Checked then
listbox1.Visible := true
else
listbox1.Visible := false;
end;

procedure TForm1.ChecknarozClick(Sender: TObject);
begin
Button1Click(Form1)
end;

procedure TForm1.CheckRPPClick(Sender: TObject);
begin

Button2Click(Form1);
Button1Click(Form1);

end;
procedure TForm1.ChecklistwierzchClick(Sender: TObject);
begin
if (Checklistawierzcholkow.Checked=true) then listwierzch.Visible:=true else listwierzch.Visible:=false;
end;

procedure TForm1.ChecksasiedziClick(Sender: TObject);
begin
if checksasiedzi.Checked=true then begin sasiedz.Visible:=true; {sasiedzigraf2.Visible:=true; listkolej.Visible:=true; }end else begin  listkolej.Visible:=false; sasiedz.Visible:=false; sasiedzigraf2.Visible:=false; end;
end;

procedure TForm1.ChecklistawierzcholkowClick(Sender: TObject);
begin
if checklistawierzcholkow.Checked=true then listwierzch.Visible:=true else listwierzch.Visible:=false;
end;

procedure TForm1.CheckkolorkrawClick(Sender: TObject);
begin
CheckboxsciezkiClick(Form1);
end;

procedure TForm1.ChecknajdrogaClick(Sender: TObject);
begin
rys();
end;

procedure TForm1.Checklistkrawgraf2Click(Sender: TObject);
begin
if Checklistkrawgraf2.Checked=true then listkrawgraf.Visible:=true else listkrawgraf.Visible:=false;
end;

procedure TForm1.losplanClick(Sender: TObject);
var
i,xp,yp:integer;

begin
if (n<=25) and (strtoint(Edit3.Text)<=100) and ((strtoint(Edit3.Text)>=0)) then
begin
 Randomize();
Button2Click(Form1);

for i:=0 to trunc(n*n*strtoint(Edit3.Text)*0.01)+2 do
 begin

  xp:=random(n);
  yp:=random(n);
  lr:=2;
  lp:=1;
  case i of
  1: if (przeszkody[xp][yp]=0) and (paczki[xp][yp]=0) then roboty[xp][yp]:=1;
  3: if (przeszkody[xp][yp]=0) and (paczki[xp][yp]=0) then roboty[xp][yp]:=1;
  2: if (przeszkody[xp][yp]=0) and (roboty[xp][yp]=0) then paczki[xp][yp]:=1;

  else
  if (roboty[xp][yp]=0) and(paczki[xp][yp]=0)then
  przeszkody[xp][yp]:=1;

 end;
end; 
rys();
end;
end;

procedure TForm1.opcjeClick(Sender: TObject);
begin
if opcje.Checked = true then
begin
Checkboxwierzcholki.Visible:=true;
Checkboxsciezki.Visible:=true;
//Checknaroz.Visible:=true;
Checkdijkstrpoko.Visible:=true;
Checknajdroga.Visible:=true;
//CheckRPP.Visible:=true;
Checksasiedzi.Visible:=true;
Checklistawierzcholkow.Visible:=true;
Checklista.Visible:=true;
//Checkkolorkraw.Visible:=true;
//Checklistkrawgraf2.Visible:=true;
lepiejbox.Visible:=true;
Edit3.Visible:=true;
Edit4.Visible:=true;
Label5.Visible:=true;
Label3.Visible:=true;
end
else
begin
Checkboxwierzcholki.Visible:=false;
//Checklistkrawgraf2.Visible:=false;
//Checkkolorkraw.Visible:=false;
Checklista.Visible:=false;
Checklistawierzcholkow.Visible:=false;
Checksasiedzi.Visible:=false;
Checknajdroga.Visible:=false;
Checkboxsciezki.Visible:=false;
//Checknaroz.Visible:=false;
Checkdijkstrpoko.Visible:=false;
//CheckRPP.Visible:=false;
lepiejbox.Visible:=false;

Edit3.Visible:=false;
Edit4.Visible:=false;
Label5.Visible:=false;
Label3.Visible:=false;
end;
end;

procedure TForm1.dokoncaClick(Sender: TObject);
var
i,j,il:integer;
begin

dokon:=true;
dokonca.Visible:=false;
button2.Enabled:=false;
button1.Enabled:=false;
losplan.Enabled:=false;
stop.Visible:=true;
while (lp<>0) and (dokon=true) do
begin
          application.ProcessMessages;
sleep(strtoint(Edit4.Text));
Button1Click(Form1);
end;

button2.Enabled:=true;
button1.Enabled:=true;
losplan.Enabled:=true;

dokonca.Visible:=true;
stop.Visible:=false;

end;



procedure TForm1.stopClick(Sender: TObject);
begin
dokon:=false;

dokonca.Visible:=true;
stop.Visible:=false;
end;



procedure TForm1.CheckdijkstrpokoClick(Sender: TObject);
begin
if Checkdijkstrpoko.Checked=true then
    Checknajdroga.Checked:=true
    else
    Checknajdroga.Checked:=false;
end;
procedure TForm1.FormCreate(Sender:TObject);
begin;
rys();
end;




procedure TForm1.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
   if strtoint(Edit1.text)>1 then
  begin
     Edit1.text:=inttostr(strtoint(Edit1.text)-1);
    rys();
    end;
end;

procedure TForm1.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin

   Edit1.text:=inttostr(strtoint(Edit1.text)+1);
   rys();
end;

procedure TForm1.CheckkasujscianeClick(Sender: TObject);
begin
if Checkkasujsciane.Checked=true then
if Checkryssciane.Checked= true then  Checkryssciane.Checked:=false;
end;

procedure TForm1.CheckrysscianeClick(Sender: TObject);
begin
if Checkryssciane.Checked=true then
if Checkkasujsciane.Checked= true then  Checkkasujsciane.Checked:=false;

end;

end.
