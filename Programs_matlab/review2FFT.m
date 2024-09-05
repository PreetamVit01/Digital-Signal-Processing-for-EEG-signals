clc
clear
close all
tic
data= load("C:\Users\preet\OneDrive\Desktop\BVB\DSP\original\3684992\E1_2.txt");
figure
plot(data(2:end,1));
title("Patient2-channel2");
N=length(data(2:end,1));
x=data(2:end,1);
X=[];
g=[];
h=[];
a=0;
b=0;

for n=1:N/2
    g(n)=x(n)+x(n+N/2);
end

for n=1:N/2
    b=x(n)-x(n+N/2);
    h(n)=b*exp(-j*2*pi*(n-1)/N);
end


for k=1:N/2
    for n=1:N/2
        a = a + g(n)*exp(-j*4*pi*(n-1)*(k-1)/N);
    end
    X(2*k-1)=a;
    a=0;
end

for k=1:N/2
    for n=1:N/2
        a = a + h(n)*exp(-j*4*pi*(n-1)*(k-1)/N);
    end
    X(2*k)=a;
    a=0;
end

mag_X = abs(X);
    phi_X = angle(X);
    z1 = fftshift(mag_X);
    z2 = fftshift(phi_X);

    figure;
    stem(z1);
    title('Magnitude of Patient2-channel2');

    figure
    stem(z2);
    title('phase of Patient2-channel2');
toc
