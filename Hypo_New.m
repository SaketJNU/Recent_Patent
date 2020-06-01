%% Code to Compute Inter-Spike-Interval Distribution for LIF Model with Hypoexponential Distributed Delay Kernel
%% Saket Kumar on 14th September June 2015
function [Spike, Agg_ISI,iteration] = Hypo_New(beta, lambda1,lambda2, mu, sigma, V_t,SP)

        %beta = 0.15;         lambda1 = 0.01;        lambda2 = 1;        mu = 0.02;        sigma = 0.03;        V_t =  1; 
        betaB = (beta*lambda1*lambda2)/(lambda2 - lambda1);  
        
    
    t_step = 0.01;
     
    V_rest = 0.01;              % Resting Potential
    V_ini  = 0.01;                 % Initial Potential after spike
    
    
    Spike = 0;
     SpikeCount = 0;
  V_1 = V_rest;
  X1 =0 ; Y1 =0; 
     iteration = 1;
    while SpikeCount < SP
     
        V_2 = V_1 - (betaB*(X1 - Y1) - mu)*t_step +  sigma*randn*sqrt(t_step);
        X2 = X1 - (lambda1*X1 - V_1)*t_step;
        Y2 = Y1 - (lambda2*Y1 - V_1)*t_step;
     if V_2 >= V_t
        V_1 = V_ini;
        X1 = 0;
        Y1 = 0;
        %Spike = [Spike, 1]; SpikeCount = SpikeCount + 1;
        Spike = [Spike, iteration*t_step]; SpikeCount = SpikeCount + 1;
    else
        %Spike = [Spike, 0 ];
        V_1 = V_2; X1 = X2; Y1 = Y2; 
    end
            iteration = iteration + 1;
    end
    
    Spike(1)= [];
    Agg_ISI = ISI_Code(Spike);   
    
end


%% Function to calculate inter-spike-interval distribution

function [Inter] = ISI_Code(spike_train)

 if length(spike_train) > 1
    
        len = length(spike_train);
   
        V11 = spike_train;
        V12 = spike_train;  
        V11(1) = [];    V12(len) = [];
   
                Inter = V11 - V12;
                %Inter = Inter*t_step;
                
    else
    Inter = [];
 end 
    
end


