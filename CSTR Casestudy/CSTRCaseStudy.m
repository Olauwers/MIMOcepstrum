%% CSTR Case-study

controller = 0; %Set to one to turn on the controller

if controller == 1
    load('data_cstr_10kpoints_fouling.mat')
else
    load('data_cstr_10kpoints_fouling_OL.mat')
end

% outputs
out_Ca = measured_variables.signals.values(:,1);
out_T = measured_variables.signals.values(:,2);

% inputs
in_Tc = measured_variables.signals.values(:,3);
in_q = measured_variables.signals.values(:,4);

% set fault occurence time point and the interval around it that we omit from the data
fault = 5000;
interval = 100;

%% Calculate input and output cepstra before and after the fault

Ts = 60;           % Sampling Timestep
windowsize = 2^6;   % Initialize some default parameters for the cepstrum calculation
noverlap = [];

% normal operating behaviour
innormal_ceps = powercepstrum([in_Tc(1:fault-interval),in_q(1:fault-interval)],windowsize,noverlap,Ts);
outnormal_ceps = powercepstrum([out_Ca(1:fault-interval),out_T(1:fault-interval)],windowsize,noverlap,Ts);

% faulty operating behaviour (fouling)
infault_ceps = powercepstrum([in_Tc(fault+interval:end),in_q(fault+interval:end)],windowsize,noverlap,Ts);
outfault_ceps = powercepstrum([out_Ca(fault+interval:end),out_T(fault+interval:end)],windowsize,noverlap,Ts);

%% Plot cepstra, compare normal with faulty behaviour

%input
figure
plot(innormal_ceps)
hold  
plot(infault_ceps)

%output
figure
plot(outnormal_ceps)
hold  
plot(outfault_ceps)

%system
figure
plot(outnormal_ceps-innormal_ceps)
hold  
plot(outfault_ceps-infault_ceps)

%% Write CSV-file to generate figures in paper (uncomment if needed)

if controller == 1
    csvwrite('CL_innormal.csv',[(0:1:size(innormal_ceps,1)-1)', innormal_ceps]);
    csvwrite('CL_infault.csv',[(0:1:size(infault_ceps,1)-1)', infault_ceps]);
    csvwrite('CL_outnormal.csv',[(0:1:size(innormal_ceps,1)-1)', outnormal_ceps]);
    csvwrite('CL_outfault.csv',[(0:1:size(infault_ceps,1)-1)', outfault_ceps]);
    csvwrite('CL_totnormal.csv',[(0:1:size(innormal_ceps,1)-1)', outnormal_ceps-innormal_ceps]);
    csvwrite('CL_totfault.csv',[(0:1:size(infault_ceps,1)-1)', outfault_ceps-infault_ceps]);
else
    csvwrite('OL_innormal.csv',[(0:1:size(innormal_ceps,1)-1)', innormal_ceps]);
    csvwrite('OL_infault.csv',[(0:1:size(infault_ceps,1)-1)', infault_ceps]);
    csvwrite('OL_outnormal.csv',[(0:1:size(innormal_ceps,1)-1)', outnormal_ceps]);
    csvwrite('OL_outfault.csv',[(0:1:size(infault_ceps,1)-1)', outfault_ceps]);
    csvwrite('OL_totnormal.csv',[(0:1:size(innormal_ceps,1)-1)', outnormal_ceps-innormal_ceps]);
    csvwrite('OL_totfault.csv',[(0:1:size(infault_ceps,1)-1)', outfault_ceps-infault_ceps]);
end