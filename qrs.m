clc;
clear;
t=0:.01:36-.01;
y=10*t; load("100m.mat"); d=val(1:3600);
subplot(2,1,1); time1=(1/300):(1/300):12; 
plot(time1,d/1000); 
xlabel('Sample'); 
ylabel('Voltage(microVolt)'); Mx = max(d);

Mx = 0.92*Mx;
e = zeros(1,3599);
for i=1:3599
    e(i)=d(i+1)-d(i);
end

peaks=zeros(1,3598);
for i=1:3598
    if e(i)>0
        if e(i+1)<0
            if d(i)>= Mx
                 peaks(i) = d(i);
%finding S
                 for j=i:3598
                     if e(j)<0
                         if e(j+1)>0
                             peaks(j)= d(j);
                             break
                         else 
                             peaks(j) = d(j);
                         end 
                     end
                end
%finding q
                 for k = i:-1:2
                     if e(k)>0
                         if e(k-1)<0
                             peaks(k) = d(k);
                             break
                         else 
                             peaks(k) = d(k);
                         end 
                     end
                 end 
            end
        end 
    end
end

base = d(1);
for i= 1:3598
    if peaks(i)==0
        peaks(i) = peaks(i)+base;
    end 
end
time=(3/300):(1/300):12; %(starting point):(interval):(upto) 
subplot(2,1,2);
plot(time,peaks/1000);
xlabel('Sample');
ylabel('Voltage(microVolt)');