Springtype2=
omega=1300;
r2=[1.24, 1.9, 2.9]; %cm
trigR2=[1.04,1.71,2.71]; % in line with direction of slit, to horizontal with anchor slit on wheel
D2= linspace(0, 3.08, 3); %cm
%% Spring Properties
s1.L = 28.0/10; %mm --> cm
s1.W = 8.4/10; %mm --> cm
s1.k = 0.332*9.81/(4.1 - s1.L); % m*g/x ; 

s2.L = 16.8/10; %mm --> m
s2.W = 7.2/10; %mm --> m
s2.k = 0.332*9.81/(4.2 - s2.L); % m*g/x ; 

s3.L = 24.7/10; %mm --> m
s3.W = 6.6/10; %mm --> m
s3.k = 0.332*9.81/(4.1 - s3.L); % m*g/x ; convert cm to m

s4.L = 9.6/10; %mm --> m
s4.W = 6.3/10; %mm --> m
s4.k = 0.332*9.81/(2.6 - s4.L); % m*g/x ; convert cm to m

s5.L = 13.6/10; %mm --> m
s5.W = 5.1/10; %mm --> m
s5.k = 0.332*9.81/(2.4 - s5.L); % m*g/x ; convert cm to m

s6.L = 10.2/10; %mm --> m
s6.W = 4.9/10; %mm --> m
s6.k = 0.332*9.81/(1.2 - s6.L); % m*g/x ; convert cm to m

s7.L = 34.2/10; %mm --> cm
s7.W = 4.5/10; %mm --> cm
s7.k = 0.332*9.81/(5.0 - s7.L); % m*g/x ; convert cm to m

s8.L = 66.6/10; %mm --> m
s8.W = 3.8/10; %mm --> m
s8.k = 0.332*9.81/(0.3); % m*g/x ; convert cm to m (approximate deflection)

s9.L = 13.0/10; %mm --> m
s9.W = 7.6/10; %mm --> m
s9.k = 0.332*9.81/(3.9 - s9.L); % m*g/x ; convert cm to m

s10.L = 17.0/10; %mm --> m
s10.W = 7.1/10; %mm --> m
s10.k = 0.332*9.81/(5.0- s9.L); % m*g/x ; convert cm to m

L = [s1.L s2.L s3.L s4.L s5.L s6.L s7.L s8.L s9.L s10.L];
k = [s1.k s2.k s3.k s4.k s5.k s6.k s7.k s8.k s9.k s10.k];

massbolt= 7.74; %grams 
massnut= 3.20;%grams
massacrylicm1=1.82; %grams


RadiusCOM2Engaged=[2.38,2.37,2.37;2.66,2.67,2.67;3.2,3.24,3.28];
MomentArmcom2=[1.14,1.16,1.17;1.68,1.72,1.75;2.49,2.56,2.62]; %cm
%Spring1:
for D2iter=(1:3)
    for r2iter=(1:3)
        for nutsiter=(1:3)
            RB2= D2(D2iter)+2.75;%cm
            %Spring2:
            a=sqrt(r2(r2iter))/2;
            anglespring2axlepointhorizontal=atan((a+0.26)/a);
            anglespringhorizontalpointanchor=atan((RB2-a-.26)/a);
            AngleSpring2=anglespring2axlepointhorizontal+anglespringhorizontalpointanchor;
            %Centripetal1
            AngleCentripetal2=acos(MomentArmcom2(r2iter,nutsiter)/RadiusCOM2Engaged(r2iter,nutsiter));
            M2= massbolt+massnut*nutsiter+massacrylicm2; %grams
            
            ExtensionSpring2 = sqrt((RB2-a-.26)^2+a^2);
            ForceSpring2= ExtensionSpring2*k(Springtype2);
            CentripetalForce2=(M2*RadiusCOM2Engaged(r2iter,nutsiter)*omega^2)/10000000;
            NetTorqueM2(D2iter,r2iter,nutsiter)= -ForceSpring2*cos(90-AngleSpring2)+ CentripetalForce2*cos(AngleCentripetal2);
            absNetTorqueM2(D1iter,r2iter,nutsiter)=abs(NetTorqueM2(D2iter,r2iter,nutsiter));
        end
    end
end
NetTorqueM2;
[v,loc] = min(NetTorqueM2(:));
[ii,jj,kk,l] = ind2sub(size(NetTorqueM2),loc);
[vabs,loc] = min(absNetTorqueM2(:));
[iiabs,jjabs, kkabs, kabs] = ind2sub(size(absNetTorqueM2),loc);
pos=[iiabs,jjabs,kkabs]
NetTorqueM2(iiabs,jjabs,kkabs)
