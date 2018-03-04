close all;
clear all;

rng('default');

%% Generate random stable minimum-phase discrete time dynamical system

n = 5; % Amount of poles/zeros per transfer matrix entry. Has to be even, as poles and zeros appear in complex conjugate pairs
l = 3; % Amount of inputs and outputs

gain = randn(l); % Generate a random gain matrix
isstable = 0;    % Initialize boolean to check whether system is minimum-phase

while isstable == 0   % Check whether the transmission zeros are minimum-phase

%sys = minreal(zpk(generatepoles(n,l,l),generatepoles(n,l,l),gain,1)); % Generate system with poles and zeros generated via function generatepoles
sys = drss(n,l,l);
isstable = 1-any(abs(tzero(sys))>1);

end

%% Compute cepstrum from data

N = 2^16;    % Initialize length of signals

windowsize = [];   % If preferred, possibility to change the default values of the arguments of the function cpsd
noverlap = [];

t = 0:1:N-1;                     % Define a time interval
input = randn(N,l).*randn(1,l);              % Generate white noise input data
output = lsim(sys, input, t);    % Simulate output

input_ceps = powercepstrum(input,windowsize,noverlap,1); % Estimate the cepstrum of the input
output_ceps = powercepstrum(output,windowsize,noverlap,1); % Estimate the cepstrum of the output

%% Calculate theoretical cepstrum

[zeroes,nrank] = tzero(sys); % Get the transmission zeros of the system
poles = pole(sys);           % Get poles of the system

ceps_theoretical = zeros(size(output_ceps,1)/2,1);

ceps_theoretical(1) = log(det(zpk(sys).k));
for k = 1:2^10
   ceps_theoretical(k+1) = real(sum(poles.^(k))/(k) - sum(zeroes.^(k))/(k)); % Calculate cepstrum coefficients
end

%% Plot cepstra to compare
cutoff = 50;
figure
plot(t(1:cutoff),ceps_theoretical(1:cutoff))
hold
%plot(output_ceps(1:cutoff))
%plot(input_ceps(1:cutoff))
plot(t(1:cutoff),output_ceps(1:cutoff)-input_ceps(1:cutoff))

%% Plot difference between theoretical cepstrum and computational cepstrum

figure
plot((ceps_theoretical(1:cutoff)-(output_ceps(1:cutoff)-input_ceps(1:cutoff))))

%% Write CSV-file to generate figures in paper (uncomment if needed)

csvwrite('theoreticalcepstrum.csv',[t(1:size(ceps_theoretical,1))', ceps_theoretical]);
csvwrite('computationalcepstrum.csv',[t(1:size(output_ceps,1))', output_ceps-input_ceps]);