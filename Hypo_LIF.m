%% Code to simulate LIF model with hypo-exponential delay kernel
%% Code BY:: Saket Kuamr
%% Date:: 12th November 2014

%function [V, X, Y, Time, spike] = Hypo_LIF()
function Hypo_LIF()

        t_step = 0.01;
        Sim_Time = 100000;
        N = 1 + Sim_Time/t_step;
        Time = 0:t_step:Sim_Time;
        %%
        beta = 0.5;
        lambda1 = 0.1;
        lambda2 = 0.09;
        mu = 0.1;
        sigma = 0.05;
        %%
        Th = 1;
        V = zeros(1,N);
        X = zeros(1,N);
        Y = zeros(1,N);
        V(1) = 0;       X(1) = 0;       Y(1) = 0;
        betaB = (beta*lambda1*lambda2)/(lambda2 - lambda1);
        spike = zeros(1,N);
        for i = 2:N
            V_deriv = -betaB*(X(i-1) - Y(i-1)) + mu;
            X_deriv = -lambda1*X(i-1) + V(i-1);
            Y_deriv = -lambda2*Y(i-1) + V(i-1);
            
            V(i) = V(i-1) + t_step*V_deriv +sigma*randn*sqrt(t_step);
            X(i) = X(i-1) + t_step*X_deriv; 
            Y(i) = Y(i-1) + t_step*Y_deriv; 
            if V(i) >= Th
                V(i) = 0;
                X(i) = 0;
                Y(i) = 0;
                spike(i) = 1;
            end
            
        end
        
           % plot(Time,V);
      
     %% Code to plot ISI
            [Inter] = ISI_Code(spike,t_step);
     
            TT = 0:0.1:300;       
            [ freq ] = hist(Inter,TT);
            freq = freq./trapz(freq);
            figure(2);
            plot(TT,freq);
end