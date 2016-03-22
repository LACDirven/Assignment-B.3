clc
close all
clear all

%% T-s Saturation curve water
i = 1;
for T = 0:400
    sL_T(i) = XSteam('sL_T', T);
    sV_T(i) = XSteam('sV_T',T);
    i = i + 1;
end

T = [0:400];

figure(1)
hold on
plot(sL_T,T,sV_T,T)

%% First point of Flash Power Plant

T1 = 240;
p1 = 50;
h1 = XSteam('h_pt',p1,T1) 
s1 = XSteam('s_pT',p1,T1)

figure(1)
plot(s1,T1,'o')

%% Plot isenthalp from first point
i = 1;
for p = p1:-1:1
    T_isen(i) = XSteam('T_ph',p,h1);
    s_isen(i) = XSteam('s_ph',p,h1);
    i = i + 1;
end

figure(1)
plot(s_isen,T_isen)

%% Fourth point of Flash Power Plant

p4 = 1;
sV_p4 = XSteam('sV_p',p4);
sL_p4 = XSteam('sL_p',p4);
s4 = 0.8 * (sV_p4 - sL_p4) + sL_p4;
T4 = XSteam('T_ps',p4,s4);

figure(1)
plot(s4,T4,'o')

%% Third point of Flash Power Plant

p3 = p4;
s3 = s4;
x_ps = XSteam('x_ps',p3,s3);

i = 1;
while x_ps < 0.9998
    p3 = p3 + 0.1;
    x_ps = XSteam('x_ps',p3,s3);
    i = i + 1;
end

T3 = XSteam('T_ps',p3,s3)

%% Plot isobars

s = [0:0.1:6.5];

i = 1;
for S = s
    T50(i) = XSteam('T_ps',50,S);
    T33(i) = XSteam('T_ps',33,S);
    T1(i) = XSteam('T_ps',1,S);
    
    i = i + 1;
end

figure(1)
plot(s,T50,s,T33,s,T1)

