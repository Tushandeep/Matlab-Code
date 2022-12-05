clc;
clear;
close all; 
load('100m.mat');
f1=5; y=val;
f2=20;
fs=1000;
wn=[f1 f2]*2/fs;n=3;
[b,a]=butter(n,wn);
ecg_h=filtfilt(b,a,y);
ecg_h=ecg_h/max(abs(ecg_h));
subplot(5,1,1);
plot((1:length(ecg_h))/fs,ecg_h,'g');
xlabel('time(s)');
ylabel('amp(mv)');
axis tight;
title('Bandpass Filtered Output');
h=1/8*fs*[-1 -2 0 2 1];
ecg_d=conv(ecg_h,h);
subplot(5,1,2);
plot((1:length(ecg_d))/fs,ecg_d,'b');
xlabel('time(s)');
axis tight;
title('Filtered with Derivative Filter');
ecg_s=ecg_d.^2;
subplot(5,1,3);
plot((1:length(ecg_s))/fs,ecg_s, 'r');
xlabel('time(s)');
ylabel('amp(mv)');
axis tight;
title('Squared'); 
ecg_m=conv(ecg_s,ones(1,round(0.0400*fs))/round(0.0450*fs)); 
subplot(5,1,4);
plot((1:length(ecg_m))/fs,ecg_m, 'k');
xlabel('time(s)');
ylabel('amp(mv)');
axis tight;
title('Averaged'); 
[pks,locs]=findpeaks(ecg_m,'minpeakdistance',round(0.65*fs)); 
n=length(locs);
a=zeros(1,n);
for i=1:n
[c,w]=max(ecg_h(locs(i)+150:locs(i)+50));
 a(i)=locs(i)-150;
end
subplot(5,1,5);
title('Raw ECG signal');
xlabel('time(s)');
ylabel('amp(mv)');
hold on
plot((1:length(y))/fs,y);
subplot(5,1,5);
for i=1:length(locs)
hold on
plot((locs(i)/1000)-0.2,pks(i)/1000,'r*'); 
end