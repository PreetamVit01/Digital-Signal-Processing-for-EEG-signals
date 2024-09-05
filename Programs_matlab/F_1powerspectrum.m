clear all
close all
clc
%part 1
Fs=128;          %sampling frequency as we are using just 128 samplesper second
fileID = fopen('Subject_1.txt','r');        %open Subject_1.txt file in read mode
this_line=0;
var1={};         %initilization of array 
while this_line ~=-1    %read till end of line of array
this_line=fgetl(fileID);   %returns the next line of the specified file, removing the newline characters
if this_line ~=-1         %when end of line occure 
    var1=[var1;this_line]; %conncetinatte of new line with all the pervious lines and loading into matlab array this will result all the text file in into arrays indexes each line make one index 
end 
end
var2=var1(220);    %slect the specfied line whose spectrum you wanted to observe. this will slect specfied index of 129*1 array
dlmwrite('myFile.txt',var2,'delimiter','','roffset',1);   %this will write the specfied index of array into a text file   
fileID = fopen('myFile.txt','r');     %again we open the created file in read mode  
commas = char(44);    %as our textfileis sperated by commas so we need the ACII of commas to delete them from text
sizeA = [1 Inf];   %give the size of array
[A] = fscanf(fileID,['%d' commas],sizeA);  %make array of decimal data type with specfied size and revome commas  from text
% %%%filters
%part 3
%%power spectrum of delta

fp1=0;   %pass band frequecy of delta 
fs1=3.75; %stop band frequency of delta
Rs1=.0001; %stop band ripples of delta
Rp1=0.057501127785; %pass band ripples of delta
wn1=[fp1 fs1]/(Fs/2); %retrun the normalize frequency
[N1, F1, A1, W1] = firpmord(wn1, [0 1], [Rp1,Rs1]); %see the descripption of fuction 
b1 = firpm(N1, F1, A1, W1); %return coffcients of fir filter
Hd1 = dfilt.dffir(b1); %design a filter for the cofficents
x1=filter(Hd1,A); %flterdata with the designed filter

L=10;   
Q1 = 2^nextpow2(L);   %number of fft piints  
j1 = fft(x1,Q1)/L;     %take fourier transform 
Sam1=j1(1:Q1/2);        %take Q/2 samples of J   
N1=128;       %number of samples to find avreage power 
PSD1=periodogram(Sam1);        %power spectrumm denesity 
avg1=sum(PSD1)/N1              %averag power of delta
f1 = (0:length(PSD1)-1)/(Fs/length(PSD1)); %frequency verctor
subplot(221)
plot(f1,PSD1)
title('delta power spectrum')
xlabel('frequacy(Hz)-->')
ylabel('amplitude(db)-->')

%theta
Fs21=3.75;
Fp21=4;
Fp22=7;
Fs22=7.75;
Rs21=.001;
Rs22=.0001;
Rp21=0.057501127785;
wn2=[Fs21 Fp21 Fp22 Fs22]/(Fs/2);
[N2, F2, A2, W2] = firpmord(wn2, [0 1 0], [Rs21, Rp21,Rs22]);
b2 = firpm(N2, F2, A2, W2);
Hd2 = dfilt.dffir(b2);
x2=filter(Hd2,A);

L=10;
Q2 = 2^nextpow2(L);   
j2 = fft(x2,Q2)/L;
Sam2=j2(1:Q2/2);
PSD2=periodogram(Sam2);        %power spectrumm denesity 
avg2=sum(PSD2)/N1               %averag power of theta
f2 = (0:length(PSD2)-1)/(Fs/length(PSD2));
subplot(222)
plot(f2,PSD2)
title('theta power spectrum')
xlabel('frequacy(Hz)-->')
ylabel('amplitude-->')

%alpha
Fs31=7.75;
fp31=8;
fp32=13;
fs32=13.5;
Rs31=.001;
Rs32=.0001;
Rp3=0.057501127785;
wn3=[Fs31 fp31 fp32 fs32]/(Fs/2);
[N3, F3, A3, W3] = firpmord(wn3, [0 1 0], [Rs31, Rp3,Rs32]);
b3 = firpm(N3, F3, A3, W3);
Hd3 = dfilt.dffir(b3);
x3=filter(Hd3,A);

L=10;
Q3 = 2^nextpow2(L); % Next power of 2 from length of x3
j3 = fft(x3,Q3)/L;
Sam3=j3(1:Q3/2);
PSD3=periodogram(Sam3);        %power spectrumm denesity 
avg3=sum(PSD3)/N1               %averag power of alpha
f3 = (0:length(PSD3)-1)/(Fs/length(PSD3));
subplot(223)
plot(f3,PSD3)
title('Alpha power spectrum')
xlabel('frequacy(Hz)-->')
ylabel('amplitude(db)-->')

% % % %beta

Fs41=13.5;
fp41=14;
fp42=29.5;
fs42=30;
Rs41=.001;
Rs42=.0001;
Rp4=0.057501127785;
wn4=[Fs41 fp41 fp42 fs42]/(Fs/2);
[N4, F4, A4, W4] = firpmord(wn4, [0 1 0], [Rs41, Rp4,Rs42]);
b4 = firpm(N4, F4, A4, W4);
Hd4 = dfilt.dffir(b4);
x4=filter(Hd4,A);

L=10;
Q4= 2^nextpow2(L); 
j4 = fft(x4,Q4)/L;
Sam4=j4(1:Q4/2);
PSD4=periodogram(Sam4);        %power spectrumm denesity 
avg4=sum(PSD4)/N1               %averag power of beta
f4 = (0:length(PSD4)-1)/(Fs/length(PSD4));
subplot(224)
plot(f4,PSD4)
title('beta power spectrum')
xlabel('frequacy(Hz)-->')
ylabel('amplitude(db)-->')
if(avg1>41.0777)&&(avg2>.5779)&&(avg3>.2715)&&(avg4>1.8993)
    fprintf('wake')
else 
   fprintf(' Anesthetized\n') 
end
