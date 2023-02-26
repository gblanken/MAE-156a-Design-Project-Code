clear; clc; close all
%% Mass Properties
mb = 7.74/1000; % mass of bolt --- convert g to kg
mn = 3.20/1000; % mass of nut --- convert g to kg

%% Mass Moment
omega = [1600 1300]*2*pi/60; %RPM --> rad/s

m1 = mb + mn;%28/1000; %kg
rc1 = [3.84 4.97]/100; %cm --> m
r1 = [1.29 2.33]/100; %cm --> m
theta1 = [114.94 65.56]; %deg

m2 = mb + mn;%28/1000; %kg
rc2 = [2.07 3.18]/100; %cm --> m
r2 = [0.91 2.90]/100; %cm --> m
theta2 = [88.73 42.91]; %deg

%Preallocation
Fc1 = zeros(length(theta2),1);
M1 = zeros(length(theta2),1);
Fc2 = zeros(length(theta2),1);
M2 = zeros(length(theta2),1);
for i = 1:2
    %Index 1 is M1 all the way in; index 2 is M1 all the way out
    
    Fc1(i) = m1*omega(1)^2*rc1(i);
    M1(i) = Fc1(i)*r1(i)*sind(theta1(i));
    
    Fc2(i) = m2*omega(2)^2*rc2(i); %kg*m/s^2 == N
    M2(i) = Fc2(i)*r2(i)*sind(theta2(i)); %Nm

end
%table(Fc1,Fc2)
table(M1,M2)

%% Spring Properties
s1.L = 28.0/1000; %mm --> m
s1.W = 8.4/1000; %mm --> m
s1.k = 0.332*9.81/(4.1/100 - s1.L); % m*g/x ; convert cm to m

s2.L = 16.8/1000; %mm --> m
s2.W = 7.2/1000; %mm --> m
s2.k = 0.332*9.81/(4.2/100 - s2.L); % m*g/x ; convert cm to m

s3.L = 24.7/1000; %mm --> m
s3.W = 6.6/1000; %mm --> m
s3.k = 0.332*9.81/(4.1/100 - s3.L); % m*g/x ; convert cm to m

s4.L = 9.6/1000; %mm --> m
s4.W = 6.3/1000; %mm --> m
s4.k = 0.332*9.81/(2.6/100 - s4.L); % m*g/x ; convert cm to m

s5.L = 13.6/1000; %mm --> m
s5.W = 5.1/1000; %mm --> m
s5.k = 0.332*9.81/(2.4/100 - s5.L); % m*g/x ; convert cm to m

s6.L = 10.2/1000; %mm --> m
s6.W = 4.9/1000; %mm --> m
s6.k = 0.332*9.81/(1.2/100 - s6.L); % m*g/x ; convert cm to m

s7.L = 34.2/1000; %mm --> m
s7.W = 4.5/1000; %mm --> m
s7.k = 0.332*9.81/(5.0/100 - s7.L); % m*g/x ; convert cm to m

s8.L = 66.6/1000; %mm --> m
s8.W = 3.8/1000; %mm --> m
s8.k = 0.332*9.81/(0.3/100); % m*g/x ; convert cm to m (approximate deflection)

s9.L = 13.0/1000; %mm --> m
s9.W = 7.6/1000; %mm --> m
s9.k = 0.332*9.81/(3.9/100 - s9.L); % m*g/x ; convert cm to m

s10.L = 17.0/1000; %mm --> m
s10.W = 7.1/1000; %mm --> m
s10.k = 0.332*9.81/(5.0/100 - s9.L); % m*g/x ; convert cm to m

L = [s1.L s2.L s3.L s4.L s5.L s6.L s7.L s8.L s9.L s10.L];
k = [s1.k s2.k s3.k s4.k s5.k s6.k s7.k s8.k s9.k s10.k];

rs1 = [4.31 7.85]/100; %cm --> m
theta_s1 = [140.36 96.84]; %deg
rs2 = [1.96 3.76]/100; %cm --> m
theta_s2 = [143.35 121.63]; %deg

%Preallocation
x1 = zeros(length(rs1),length(L));
Fs1 = zeros(length(rs1),length(L));
Ms1 = zeros(length(rs1),length(L));
x2 = zeros(length(rs1),length(L));
Fs2 = zeros(length(rs1),length(L));
Ms2 = zeros(length(rs1),length(L));
for j = 1:length(L)
    %Index == spring #
    for i = 1:2
        %Index 1 is M1 all the way in; index 2 is M1 all the way out
        k1 = k(j);
        s1 = L(j);
        
        k2 = k(j);
        s2 = L(j);
    
        x1(i,j) = rs1(i) - s1;
        Fs1(i,j) = k1*x1(i,j);
        Ms1(i,j) = Fs1(i,j)*r1(i)*sind(theta_s1(i));

        x2(i,j) = rs2(i) - s2;
        Fs2(i,j) = k2*x2(i,j);
        Ms2(i,j) = Fs2(i,j)*r2(i)*sind(theta_s2(i));
    end

end
Ms1
x1
Ms2
x2

figure (1)
hold on
xline(M1(1),'b')
xline(M1(2),'b')
xline(0,'r')
plot(Ms1(:,1)',[0.01 0.01])
plot(Ms1(:,2)',[0.02 0.02])
plot(Ms1(:,3)',[0.03 0.03])
plot(Ms1(:,4)',[0.04 0.04])
plot(Ms1(:,5)',[0.05 0.05])
plot(Ms1(:,6)',[0.06 0.06])
plot(Ms1(:,7)',[0.07 0.07])
plot(Ms1(:,8)',[0.08 0.08])
plot(Ms1(:,9)',[0.09 0.09])
plot(Ms1(:,10)',[0.10 0.10])
legend('','','','Spring 1','Spring 2','Spring 3','Spring 4','Spring 5','Spring 6','Spring 7','Spring 8','Spring 9','Spring 10')
hold off

figure (2)
hold on
xline(M2(1),'b')
xline(M2(2),'b')
xline(0,'r')
plot(Ms2(:,1)',[0.01 0.01])
plot(Ms2(:,2)',[0.02 0.02])
plot(Ms2(:,3)',[0.03 0.03])
plot(Ms2(:,4)',[0.04 0.04])
plot(Ms2(:,5)',[0.05 0.05])
plot(Ms2(:,6)',[0.06 0.06])
plot(Ms2(:,7)',[0.07 0.07])
plot(Ms2(:,8)',[0.08 0.08])
plot(Ms2(:,9)',[0.09 0.09])
plot(Ms2(:,10)',[0.10 0.10])
legend('','','','Spring 1','Spring 2','Spring 3','Spring 4','Spring 5','Spring 6','Spring 7','Spring 8','Spring 9','Spring 10')
hold off
