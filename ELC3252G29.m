
%%%%%%%%%%%%2-%%%%%%%%%%%%%%
M1=100; M2=100; K1=5; K3=5; K2=50; F1=100; F2=100;
B1= tf(1,[M1,0,0]);
B2= tf(K1,1);
B3= tf(K2, 1);
B4= tf([F1,0],1);
B5= tf(K2,1);
B6= tf(1,[M2,0,0]);
B7= tf(K2,1);
B8= tf(K3, 1);
B9= tf([F2,0],1);
B10= tf(K2,1);

BlockMat= append (B1,B2,B3,B4,B5,B6,B7,B8,B9,B10);
connect_map= [1,-2,-3,-4,10; 2,1,0,0,0; 3,1,0,0,0; 4,1,0,0,0; 5,1,0,0,0;
              6,-7,-8,-9,5; 7,6,0,0,0; 8,6,0,0,0; 9,6,0,0,0; 10,6,0,0,0];
input_loc= 1 ;
Output_loc1= 1;
Output_loc2= 6;
%X1/U
sys1= connect(BlockMat,connect_map,input_loc,Output_loc1);
figure();
p1= stepplot(sys1);
yticks(0:0.01:0.12);
figure();
pzmap(sys1);
[wn,zlabel]=damp (sys1);
disp(pole(sys1(1)));
%For stable discrete systems, all their poles must have a magnitude strictly smaller than one,
% that is they must all lie inside the unit circle. The poles in this example are a pair of complex conjugates, 
% and lie inside the unit circle. Hence, the system sys is stable.%
%all real parts are negative as well, therefore stable
% for confirmation
B= isstable(sys1);
if isequal(B,1)      
    disp("stable system");
else
    disp("unstable system");
end
%X2/U
sys2= connect(BlockMat,connect_map,input_loc,Output_loc2);
figure();
p2= stepplot(sys2);
yticks(0:0.01:0.12);
figure();
pzmap(sys2);
[wn2,zlabel2]=damp (sys2);
%%% under input force of 1N %%%
t = 0:0.02:150; U=1;
%%%% X1 %%%%
figure();
X1= lsim(sys1,U*ones(size(t)),t);
plot(t, X1);
title('X1 response to 1N Force');
ylabel("X1");
yticks(0:0.01:0.12);
%%%% X2 %%%%
figure();
X2= lsim(sys2,U*ones(size(t)),t);
plot(t, X2);
title('X2 response to 1N Force');
ylabel("X2");
yticks(0:0.01:0.12);
%%% Steady state values of X1 and X2 %%%
Steady_state_X1= mean(X1(6700:end));
Steady_state_X2= mean(X2(6100:end));
fprintf('Steady state value of X1 is %f\n', Steady_state_X1);
fprintf('Steady state value of X2 is %f\n', Steady_state_X2);

%%%%%%%%%% 5- %%%%%%%%%%%%
Xd=2;
sys3= feedback(sys2,1);
figure();
X2= lsim(sys3,Xd*ones(size(t)),t);
plot(t, X2);
yticks(0:0.02:0.25);
step_info = stepinfo(X2,t);
rise_time = step_info.RiseTime;
peak_time = step_info.PeakTime;
max_peak = step_info.Peak;
settling_time = step_info.SettlingTime;
ess = abs(Xd - X2(end));

fprintf('Rise time of X2 is %f\n', rise_time);
fprintf('Peak time of X2 is %f\n', peak_time);
fprintf('Max peak of X2 is %f\n', max_peak);
fprintf('Settling time of X2 is %f\n', settling_time);
fprintf('Steady state error of X2 is %f\n', ess);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P=1;
sys4 = tf(P,1);
sys5= feedback(sys4*sys2,1);
X2= lsim(sys5,Xd*ones(size(t)),t);

B= isstable(sys5);
if isequal(B,1)      
    fprintf('%s\n', '%%%%%%For P =1 %%%%%%');
    disp("stable system");
    step_info = stepinfo(X2,t);
    rise_time = step_info.RiseTime;
    peak_time = step_info.PeakTime;
    max_peak = step_info.Peak;
    settling_time = step_info.SettlingTime;
    ess = abs(Xd - X2(end));
    
    
    fprintf('Rise time of X2 is %f\n', rise_time);
    fprintf('Peak time of X2 is %f\n', peak_time);
    fprintf('Max peak of X2 is %f\n', max_peak);
    fprintf('Settling time of X2 is %f\n', settling_time);
    fprintf('Steady state error of X2 is %f\n', ess);
else
    fprintf('%s\n', '%%%%%%For P =1 %%%%%%');
    disp("unstable system");
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P=10;
sys4 = tf(P,1);
sys5= feedback(sys4*sys2,1);
X2= lsim(sys5,Xd*ones(size(t)),t);

B= isstable(sys5);
if isequal(B,1)      
    fprintf('%s\n', '%%%%%%For P =10 %%%%%%');
    disp("stable system");
    step_info = stepinfo(X2,t);
    rise_time = step_info.RiseTime;
    peak_time = step_info.PeakTime;
    max_peak = step_info.Peak;
    settling_time = step_info.SettlingTime;
    ess = abs(Xd - X2(end));
    
    
    fprintf('Rise time of X2 is %f\n', rise_time);
    fprintf('Peak time of X2 is %f\n', peak_time);
    fprintf('Max peak of X2 is %f\n', max_peak);
    fprintf('Settling time of X2 is %f\n', settling_time);
    fprintf('Steady state error of X2 is %f\n', ess);
else
    fprintf('%s\n', '%%%%%%For P =10 %%%%%%');
    disp("unstable system");
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P=100;
sys4 = tf(P,1);
sys5= feedback(sys4*sys2,1);
X2= lsim(sys5,Xd*ones(size(t)),t);

B= isstable(sys5);
if isequal(B,1)      
    fprintf('%s\n', '%%%%%%For P =100 %%%%%%');
    disp("stable system");
    step_info = stepinfo(X2,t);
    rise_time = step_info.RiseTime;
    peak_time = step_info.PeakTime;
    max_peak = step_info.Peak;
    settling_time = step_info.SettlingTime;
    ess = abs(Xd - X2(end));
    
    
    fprintf('Rise time of X2 is %f\n', rise_time);
    fprintf('Peak time of X2 is %f\n', peak_time);
    fprintf('Max peak of X2 is %f\n', max_peak);
    fprintf('Settling time of X2 is %f\n', settling_time);
    fprintf('Steady state error of X2 is %f\n', ess);
else
    fprintf('%s\n', '%%%%%%For P =100 %%%%%%');
    disp("unstable system");
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P=1000;
sys4 = tf(P,1);
sys5= feedback(sys4*sys2,1);
X2= lsim(sys5,Xd*ones(size(t)),t);

B= isstable(sys5);
if isequal(B,1)      
    fprintf('%s\n', '%%%%%%For P =1000 %%%%%%');
    disp("stable system");
    step_info = stepinfo(X2,t);
    rise_time = step_info.RiseTime;
    peak_time = step_info.PeakTime;
    max_peak = step_info.Peak;
    settling_time = step_info.SettlingTime;
    ess = abs(Xd - X2(end));
    
    
    fprintf('Rise time of X2 is %f\n', rise_time);
    fprintf('Peak time of X2 is %f\n', peak_time);
    fprintf('Max peak of X2 is %f\n', max_peak);
    fprintf('Settling time of X2 is %f\n', settling_time);
    fprintf('Steady state error of X2 is %f\n', ess);
else
    fprintf('%s\n', '%%%%%%For P =1000 %%%%%%');
    disp("unstable system");
end
%%%%%%%%%%%%%%%%%%%%% 10- %%%%%%%%%%%%%%%%%%%%
kp = 100;
ki = 10;

sys4 = tf([kp ki], [1 0]);
sys5 = feedback(sys4*sys2,1);
X2= lsim(sys5,Xd*ones(size(t)),t);

B= isstable(sys5);
if isequal(B,1) 
    ess = abs(Xd - X2(end));
    fprintf('Steady state error of X2 is %f\n', ess);
else
    fprintf('%s\n', '%%%%%%For P =1000 %%%%%%');
    disp("unstable system");
end
figure();
plot(t, X2);
%yticks(0:1:0.25);