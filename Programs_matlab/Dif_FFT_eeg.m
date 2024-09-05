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