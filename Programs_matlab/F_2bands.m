clear all
close all
clc
%part 1
fileID = fopen('Subject_2.txt','r');
this_line=0;
var1={};
while this_line ~=-1
this_line=fgetl(fileID);
if this_line ~=-1
    var1=[var1;this_line];
end 
end
var2=var1(250);    %enter row number you want to analyze 
dlmwrite('myFile.txt',var2,'delimiter','','roffset',1);
fileID = fopen('myFile.txt','r');
commas = char(44);
sizeA = [1 Inf];
[A] = fscanf(fileID,['%d' commas],sizeA);
fs=500;
A=A';
Z=A(129,1);

if Z==0
fprintf('patient wake\n')
else
 fprintf('patient is in Anesthetized\n')
end
%part 2
j=fft(A);
oo=length(j);
L=(0:oo-1)*(fs/oo);
subplot(331)
stem(L,20*log((j)))
title('spectrum of origional data')
xlabel('frequacy(Hz)-->')
ylabel('amplitude(db)-->')

%%%filters
%part 3
%%delta

Fp=.5;
Fs=3.75;
Rp=0.057501127785;
wn=[Fp, Fs]/(fs/2);
fs=500;
Rs=0.0001;
[Or,F,po,w] = firpmord(wn, [1 0], [Rp, Rs]);
b1 = firpm(Or, F, po, w);
F1 = dfilt.dffir(b1);
x1=filter(F1,A);
subplot(332)
ts=1;
t=0:ts:128;
stem(t,x1,'r')
title('delta time domain')
xlabel('time(S)-->')
ylabel('amplitude(db)-->')

j=fft(x1);
oo=length(j);
L=(0:oo-1)*(fs/oo);
subplot(333)
stem(L,20*log((j)));
title('delta spectrum')
xlabel('frequacy(Hz)-->')
ylabel('amplitude(db)-->')

%theta
Fs1=3.75;
fp1=4;
fp2=7;
fs2=7.75;
Rs1=.001;
Rs2=.0001;
Rp=0.057501127785;
wn=[Fs1 fp1 fp2 fs2]/(fs/2);
[Or, F, po, w] = firpmord(wn, [0 1 0], [Rs1, Rp,Rs2]);
b1 = firpm(Or, F, po, w);
F1 = dfilt.dffir(b1);
x1=filter(F1,A);
subplot(334)
ts=1;
t=0:ts:128;
stem(t,x1,'r')
title('theta in time domain')
xlabel('time(S)-->')
ylabel('amplitude(db)-->')

j=fft(x1);
oo=length(j);
L=(0:oo-1)*(fs/oo);
subplot(335)
stem(L,20*log((j)))
title('theta spectrum')
xlabel('frequacy(Hz)-->')
ylabel('amplitude(db)-->')


%alpha
Fs1=7.75;
fp1=8;
fp2=13;
fs2=13.5;
Rs1=.001;
Rs2=.0001;
Rp=0.057501127785;
wn=[Fs1 fp1 fp2 fs2]/(fs/2);
[Or, F, po, w] = firpmord(wn, [0 1 0], [Rs1, Rp,Rs2]);
b1 = firpm(Or, F, po, w);
F1 = dfilt.dffir(b1);
x1=filter(F1,A);
subplot(336)
ts=1;
t=0:ts:128;
stem(t,x1,'r')
title('Alpha in time domain')
xlabel('time(S)-->')
ylabel('amplitude(db)-->')

j=fft(x1);
oo=length(j);
L=(0:oo-1)*(fs/oo);
subplot(337)
stem(L,20*log((j)))
title('Alpha spectrum')
xlabel('frequacy(Hz)-->')
ylabel('amplitude(db)-->')

%beta

Fs1=13.5;
fp1=14;
fp2=29.5;
fs2=30;
Rs1=.001;
Rs2=.0001;
Rp=0.057501127785;
wn=[Fs1 fp1 fp2 fs2]/(fs/2);
[Or, F, po, w] = firpmord(wn, [0 1 0], [Rs1, Rp,Rs2]);
b1 = firpm(Or, F, po, w);
F1 = dfilt.dffir(b1);
x1=filter(F1,A);
subplot(338)
ts=1;
t=0:ts:128;
stem(t,x1,'r')
title('beta in time domain')
xlabel('time(S)-->')
ylabel('amplitude(db)-->')

j=fft(x1);
oo=length(j);
L=(0:oo-1)*(fs/oo);
subplot(339)
stem(L,20*log((j)))
title('beta spectrum')
xlabel('frequacy(Hz)-->')
ylabel('amplitude(db)-->')
