clc;
clear;
close all;
load("100m.mat");

%PLOT ECG
a=val(1:476);
subplot(4,1,1)
title('ECG signal');
xlabel('Samples');
ylabel('Amplitude (\muV)');
hold on;
grid on;
plot(a)

%Sin wave of freq 50 Hz
t=1:476;
f=50;
m=50*sin(2*3.14*f*t);
subplot(4,1,2)
title('Sine Wave Noise');
xlabel('Samples');
ylabel('Amplitude (\muV)');
hold on;
plot (t,m)

% Noisy ECG plot
n=m+a;
subplot (4,1,3)
title('Noisy ECG signal');
xlabel('Samples');
ylabel('Amplitude (\muV)');
hold on;
plot(n)

% IIR Notch filter design
wo=50/(2000/2);
bw=wo/5;
[d,e]=iirnotch(wo,bw);

% Removal of sin noise using notch filter
os= filter(d,e,n);
subplot(4,1,4)
title('Filtered ECG signal');
xlabel('Samples');
ylabel('Amplitude (\muV)');
hold on;
plot(os)
hold on;
fvtool(d,e); % For filter visualization