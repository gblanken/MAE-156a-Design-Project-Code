Springtype1=2
omega=1400;
r1= linspace(.5,2,3); %cm

D1= linspace(0, 3.08, 3); %cm
%% Spring Properties
s1.L = 28.0/10; %mm --> cm
s1.W = 8.4/10; %mm --> cm
s1.k = 1000*0.332*9.81/(4.1 - s1.L); % m*g/x ; 

s2.L = 16.8/10; %mm --> m
s2.W = 7.2/10; %mm --> m
s2.k = 1000*0.332*9.81/(4.2 - s2.L); % m*g/x ; 

s3.L = 24.7/10; %mm --> m
s3.W = 6.6/10; %mm --> m
s3.k = 1000*0.332*9.81/(4.1 - s3.L); % m*g/x ; convert cm to m

s4.L = 9.6/10; %mm --> m
s4.W = 6.3/10; %mm --> m
s4.k = 1000*0.332*9.81/(2.6 - s4.L); % m*g/x ; convert cm to m

s5.L = 13.6/10; %mm --> m
s5.W = 5.1/10; %mm --> m
s5.k = 1000*0.332*9.81/(2.4 - s5.L); % m*g/x ; convert cm to m

s6.L = 10.2/10; %mm --> m
s6.W = 4.9/10; %mm --> m
s6.k = 1000*0.332*9.81/(1.2 - s6.L); % m*g/x ; convert cm to m

s7.L = 34.2/10; %mm --> cm
s7.W = 4.5/10; %mm --> cm
s7.k = 1000*0.332*9.81/(5.0 - s7.L); % m*g/x ; convert cm to m

s8.L = 66.6/10; %mm --> m
s8.W = 3.8/10; %mm --> m
s8.k = 1000*0.332*9.81/(0.3); % m*g/x ; convert cm to m (approximate deflection)

s9.L = 13.0/10; %mm --> m
s9.W = 7.6/10; %mm --> m
s9.k = 1000*0.332*9.81/(3.9 - s9.L); % m*g/x ; convert cm to m

s10.L = 17.0/10; %mm --> m
s10.W = 7.1/10; %mm --> m
s10.k = 1000*0.332*9.81/(5.0- s9.L); % m*g/x ; convert cm to m

L = [s1.L s2.L s3.L s4.L s5.L s6.L s7.L s8.L s9.L s10.L];
k = [s1.k s2.k s3.k s4.k s5.k s6.k s7.k s8.k s9.k s10.k];

massbolt= 7.74; %grams 
massnut= 3.20;%grams
massacrylicm1=1.82; %grams


% Radius from motor axle to COM, position, #nuts
RadiusCOM1Engaged=[3.74,3.73,3.72;4.12,4.13,4.13;4.57,4.59,4.6];
 % Moment Arm about Trigger Axle, position along slot,#nuts,
MomentArmcom1=[1.27, 1.27,1.27; 1.65,1.66,1.67;2.16,2.19,2.1]; %cm
%Spring1:
for D1iter=(1:3)
    for r1iter=(1:3)
        for nutsiter=(1:3)
            RB1= D1(D1iter)+5.37;
            AngleSpring1=(180-90-atan(1.19/(0.5+r1(r1iter))))+(180-90-atan((RB1-1.19)/(0.5+r1(r1iter))));
            ExtensionSpring1 = (RB1-1.19)*cos(atan((RB1-1.19)/(0.5+r1(r1iter))))-L(Springtype1);
            ForceSpring1= ExtensionSpring1*k(Springtype1);
            %Centripetal1
            AngleCentripetal1=acos(MomentArmcom1(r1iter,nutsiter)/RadiusCOM1Engaged(r1iter,nutsiter));
            M1= massbolt+massnut*nutsiter+massacrylicm1; %grams
            CentripetalForce1=((M1*RadiusCOM1Engaged(r1iter,nutsiter)*omega^2))/10000000+M1*.098;
            NetTorqueM1(D1iter,r1iter,nutsiter)= -ForceSpring1*cos(90-AngleSpring1)+ CentripetalForce1*cos(90-AngleCentripetal1);
            absNetTorqueM1(D1iter,r1iter,nutsiter)=abs(NetTorqueM1(D1iter,r1iter,nutsiter));
        end
    end
end
NetTorqueM1;
[v,loc] = min(NetTorqueM1(:));
[ii,jj,kk,l] = ind2sub(size(NetTorqueM1),loc);
[vabs,loc] = min(absNetTorqueM1(:));
[iiabs,jjabs, kkabs, kabs] = ind2sub(size(absNetTorqueM1),loc);
pos=[iiabs,jjabs,kkabs]
NetTorqueM1(iiabs,jjabs,kkabs)
