clc
clear
close all
data=table2array(readtable('features_raw.csv'));
name=string({'Fp1','AF3'});
for i=1:length(name)
    figure
    plot(data(:,i));
    title(name(i));
end
for z=1:length(name)
    N=length(data(:,z+1));
    x=data(:,z+1);
    X=[];
    xx=0;
    for k=0:N-1
        for n=0:N-1
            xx=xx+x(n+1)* exp(-1i*2*pi*n*k/N);
        end
        X=[X xx];
        xx=0;
    end
    mag_X = abs(X);
    phi_X = angle(X);
    z1 = fftshift(mag_X);
    z2 = fftshift(phi_X);

    figure;
    subplot(2, 1, 1);
    stem(z1);
    title('Magnitude of '+name(z));
  
    subplot(2, 1, 2);
    stem(z2);
    title('phae of '+name(z));


end