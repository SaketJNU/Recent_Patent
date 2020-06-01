%% Code for calculating Inter-spike-interval 
%% Input Parameters:: spike_train : Spike train in 0 and 1 form, t_step :: Simulation Time Step


function [Inter] = ISI_Code(spike_train,t_step)

         Interv = zeros(1,sum(spike_train));     % will be used in ISI Distribution
         Inter = zeros(1,sum(spike_train));

    V1 = spike_train;  L = length(V1); 

    if sum(spike_train) > 1
    k=0; Vt1= V1; Vt2 = V1; 
    Vt1(1) = [];    Vt2(L) = [];
    VV = Vt1 - Vt2;     Vt1 = []; Vt2 = [];

    for i = 1 : L-1
         if VV(i)==1
             k=k+1;
             Interv(k) = i;
         end
    end
    
    len = length(Interv);
   
        V11 = Interv;
        V12 = Interv;  
        V11(1) = [];    V12(len) = [];
   
                Inter = V11 - V12;
                Inter = Inter*t_step;
                
    else
    Inter = [];
    end
end
