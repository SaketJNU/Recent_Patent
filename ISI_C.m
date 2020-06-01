   %% Code for ISI
    %% Saket Kumar on 2nd July 2013
    
    close all; clear all; clc;
    
    beta        = 0.1;    
    mu          = 0.01; 
    sigma       = 0.05; 
    lambda1     = 0.01; 
    lambda2     = 1;
    V_t         =  1;
    SP          = 10000;                          % Spike Count
    
    [Spike, Agg_ISI,iteration] = Hypo_New(beta, lambda1,lambda2, mu, sigma, V_t,SP);
    
    time = 0:0.5:1000;
    [freq,n]  = hist(Agg_ISI,time);
    figure(2);
   plot(time,freq./trapz(freq));