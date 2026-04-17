clc
clear all;
close all;

load parameters
tam=size(x_hist(:,1),1); % Number of available data samples

% x_hist(:,1) corresponds to rotor resistance data, while x_hist(:,2) 
% corresponds to rotor reactance data. Therefore, either column should be 
% selected depending on the parameter for which the slip region partitioning is to be performed.
y=x_hist(:,1); y=y/max(y);
x=(1:tam)';

% The window size must be selected such that the data within each window 
% can be adequately approximated by a linear model
tj=4; % Moving window half-width
param = zeros(tam,2); % Initialization of the vector storing local linear coefficients

% Estimation of local linear parameters using a moving window approach
for c=(1+tj):(tam-tj)
  S=polyfit(x((c-tj):(c+tj)),y((c-tj):(c+tj)),1);
  param(c,1:2)=S;
end

% Replication of boundary coefficients to handle edge regions
param(1:tj,1:2)=repmat(param(tj+1,1:2),tj,1);
param(tam-tj+1:tam,1:2)=repmat(param(tam-tj,1:2),tj,1);

% Clustering of data points based on local linear coefficients (K-means)
% If running in GNU Octave, it is necessary to load the statistics package
% to enable the use of the kmeans function
%pkg load statistics
[idx, C] = kmeans(param, 3);
c1=find(idx==1);
c2=find(idx==2);
c3=find(idx==3);

% Visualization of clustering results
plot(s_hist(x),y,'k.-'),
hold on,plot(s_hist(x(c1,1)),y(c1,1),'og'),grid on,
hold on,plot(s_hist(x(c2,1)),y(c2,1),'om'),grid on,
hold on,plot(s_hist(x(c3,1)),y(c3,1),'oc'),grid on,
