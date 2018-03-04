function [ temp_ceps ] = powercepstrum(y,windowsize,noverlap,Ts)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

temp_cpsd = cpsd(y,y,windowsize,noverlap,[],Ts,'twosided','mimo');
temp = zeros(size(temp_cpsd,1),1);
for i = 1:size(temp_cpsd,1)
temp(i) = log(det(squeeze(temp_cpsd(i,:,:))));
end
temp_ceps = ifft(temp,'symmetric');

end

