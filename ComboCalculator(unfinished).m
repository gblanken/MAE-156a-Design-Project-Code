%%GOAL: GET THIS WORKIN WITH SYMBOLIC EQUATIONS, currently designed around
%%producing a combination with a minimum sum torques value for each

massbolt= 7.74/1000; %grams
massnut= 3.20/1000;%grams
massacrylicm1=1.82; %grams
massacrylicm2=2.62; %grams
r1= linspace(.5,2,3); %cm
r2=[1.24, 1.9, 2.9]; %cm


trigR2=[1.04,1.71,2.71] % in line with direction of slit, to horizontal with anchor slit on wheel

Springtype1=[];
SpringType2=[];

Nuts1=linspace(1,3); 
Nuts2=linspace(1,3);
Nuts3=linspace(1,3);    

SpringunextendedLengths= []
SpringKValues=[]

M1= massbolt+massnut*Nuts1+massacrylicm1; %grams
M2= massbolt+massnut*Nuts2+massacrylicm2; %grams
M3= massbolt+massnut*Nuts3+massSlider; %grams 



D1= linspace(0, 3.08, 3); %cm
D2= linspace(0, 3.08, 3); %cm   
D3=linspace(0, 2.48,3); %cm
 % Moment Arm about Trigger Axle, position along slot,#nuts,
MomentArmcom1=[1.27, 1.65, 2.16;
    1.27 , 1.66, 2.19;
    1.27, 1.67, 2.21]; %cm

MomentArmcom2=[1.14, 1.68, 2.49;
    1.16, 1.72, 2.56;
    1.17, 1.75, 2.62]; %cm

% Radius from motor axle to COM, nuts,position 

RadiusCOM1Engaged=[3.74, 4.12, 4.57; 
    3.73, 4.13, 4.59;
    3.72, 4.13 ,4.60];

RadiusCOM2Engaged=[2.38,2.66, 3.2; 
    2.37 ,2.67 ,3.24;
    2.37, 2.67, 3.28];

RB1= D1+5.37;%cm
RB2= D2+2.75;%cm
%RB3= D3+3.06+Pos3;%cm For Spring 3 length calculations

%Triggy stuff
%Spring1:
AngleSpring1=(180-90-atan(1.19/(0.5+r1)))+(180-90-atan((RB1-1.19)/(0.5+r1)))

%Spring2:
a=sqrt(trigR2)/2
anglespring2axlepointhorizontal=atan((a+0.26)/a)
anglespringhorizontalpointanchor=atab((RB2-a-.26)/a)
AngleSpring2=anglespring2axlepointhorizontal+anglespringhorizontalpointanchor

%Centripetal1
AngleCentripetal1=acos(MomentArmcom1/RadiusCOM1Engaged)
AngleCentripetal2=acos(MomentArmcom2/RadiusCOM2Engaged)

ExtensionSpring1= -
ExtensionSpring2=
%NetForce3=
NetTorqueM1= ForceSpring1*cos(AngleSpring1)+ CentripetalForce1*(AngleCentripetal1)
NetTorqueM2= ForceSpring2*cos(AngleSpring2)+ CentripetalForce2*(AngleCentripetal2)
