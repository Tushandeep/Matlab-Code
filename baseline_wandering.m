clc;
clear;
close all;
t=0:0.01:36-.01;
y=10*t; load("100m.mat"); 
d=val(1:3600);
subplot(4,1,1);
plot(d);
grid on;
subplot(4,1,2);
plot(t,y);
grid on;
subplot(4,1,3);
d_noise=d+y;
plot(d_noise);
grid on;
subplot(4,1,4);
%filter design
fs=1000;
fn=fs/2;
wp=1/fn;
ws=100/fn;
rp=8;
rs=20;
[n,wn]=buttord(wp,ws,rp,rs); 
[b,a]=butter(n,wn,'high'); 
out=filter(b,a,d_noise);
plot(out);
grid on;