clc;
clear;
close all;
t=0:0.01:36-.01; 
load("100m.mat"); 
compressed = [];
k = 2;
compressed(1) = val(1);
i = 1;
while i<=length(val) - 2
    m1 = val(i+1) - val(i);
    m2 = val(i+2) - val(i+1);
    if(m1*m2 < 0)
        compressed(k) = val(i+1);
        k = k+1;
        i = i+1;
else
        compressed(k) = val(i+2);
        k = k+1;
        i = i+2;
    end 
end
subplot(2,1,1);
plot(val);
subplot(2,1,2);
plot(compressed);