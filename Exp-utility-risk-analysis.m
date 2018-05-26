function exp_mc_final(n,m)
	%%Team Members: Devarsh Jhaveri, Dinesh Kaimal, Mayank Mishra, Pulkit Jain
    %%This code will return the expected value for given arrays of a certain n(life-cycle) , a(cashflow) ,int(interest rate) and inflation
    %%n is the number of Life Cycle 
    %%m is the run length of the Monte Carlo Simulation.
    
    %%User is to select preference: RA for Risk Averse, RS for Risk Seeking, RN for Risk Neutral.
    prompt = 'What type of investor are you (Type RS for Risk Seeker ; Type RA for Risk Averse ;Type RN for Risk Neutral ? \n';
    x = input(prompt,'s');
    
    if(strcmp(x,'RS'))
        z = 2;
    elseif(strcmp(x,'RA'))
        z = 0.5;
    elseif(strcmp(x,'RN'))
        z = 1;
    else
        z = 0.5;
    end
     
    exp_v = zeros(1,m);             %%Initialization of the Expected Value Vector for 'm' Monte Carlo Simulations.
    exp_v_c = zeros(1,m);           %%Initialization of the Expected Value Vector at constant values for 'm' Monte Carlo Simulations.
    u = zeros(1,m);                 %%Initialization of the Utility Function Vector for 'm' Monte Carlo Simulations.
    u_c = zeros(1,m);               %%Initialization of the Utility Function Vector at constant values for 'm' Monte Carlo Simulations.
    
    avg_u = 0;                      %%Initialization of the Expected Utility
    avg_u_c = 0;                    %%Initialization of the Expected Utility at constant values
    
    clf('reset');
    
    for j = 1:m
        
        u_plot = zeros(1,n);        %%Initialization of the Utiliy Function Plot Vectors
        a = zeros(1,n);             %%Initialization of Cash-Flow Vector.
        a_c = zeros(1,n);           %%Initialization of Constant Cash-Flow Vector.
        int = zeros(1,n);           %%Initialization of Interest Rate Vector.
        inflation = zeros(1,n);     %%Initialization of Inflation Rate Vector.
        int_c = zeros(1,n);         %%Initialization of Constant Interest Rate Vector.
        inflation_c = zeros(1,n);   %%Initialization of Constant Inflation Rate Vector.
        
            for i = 1:n
                
                %%Values can be random
                %%Storing the values in the Cash-Flow, Interest Rate(in %) and Inflation (in %) Vectors
                a_c(i)    = 150;
                int_c(i)  = 5;
                inflation_c(i)  = 2.5;
                a(i)    = 120 + 60*rand;
                int(i)  = 3 + 2*rand;
                inflation(i)  = 2 + 0.5*rand;
                
            end
        
        %%Calculation of the Interest Rate and Inflation
        int = int/100;
        inflation = inflation/100;
        
        %Calculate the Constant Interest Rate and the Inflation
        int_c = int_c/100;
        inflation_c = inflation_c/100;
        
        v_prime = zeros(1,(n+1));
        v = zeros(1,(n+1));
        v_prime_c = zeros(1,(n+1));
        v_c = zeros(1,(n+1));
        
        
        %%Assigning the Net Present Value at Time Zero to be O
        v_prime(1) = 0;
        v(1)=0;
        v_prime_c(1) = 0;
        v_c(1)=0;
        
            %%Calculating the NPV at the end of the Life Cycle and the respective Utility Plot Vector
            for i = 2:(n+1)
                
                v_prime(i) = v(i-1)*(1+int(i-1)) + a(i-1);
                v(i) = v_prime(i)*(1-inflation(i-1));
                v_prime_c(i) = v_c(i-1)*(1+int_c(i-1)) + a_c(i-1);
                v_c(i) = v_prime_c(i)*(1-inflation_c(i-1));
                u_plot(i) = (v(i))^z;
                
            end
            
            %%Plotting the Utility Function w.r.t Time
            plot(u_plot);
            hold on;
            xlabel('Time period (Value increasing over time)');
            ylabel('Utility');
            title('Utility vs Value of investment');
            
            
            %%Calculating the Utility at the end of the life-cycle for 1 Monte Carlo Simulation.
            u(j) = (v(n+1))^z;
            u_c(j) = (v_c(n+1))^z;
            exp_v(j) = v(n+1);
            exp_v_c(j) = v_c(n+1);
    end
    
    %%Calculating the Expected Utility at the end of the life-cycle after 'm' Monte Carlo Simulations.
    avg_v = mean(exp_v);
    avg_u = mean(u);
    avg_v_c = mean(exp_v_c);
    avg_u_c = mean(u_c);
    
    
    
    formatSpec1 = 'Investment A with constant parameters has Expected Utility of %4.2f units\n';
    fprintf(formatSpec1,avg_u_c)
    formatSpec2 = 'Investment B with random parameters has Expected Utility of %4.2f units\n';
    fprintf(formatSpec2,avg_u)
    formatSpec3 = 'Choose Investment A with constant parameters with Expected Utility of %4.2f units\n';
    formatSpec4 = 'Choose Investment A with random parameters with Expected Utility of %4.2f units\n';

        %%Comparison of the expeted utility at constant values VS the expected utility (Risk Averse Person) with random values of the decision parameters.
        if((avg_u_c > avg_u) && (strcmp(x,'RA')))
            fprintf(formatSpec3,avg_u_c)
        elseif((avg_u_c < avg_u) && (strcmp(x,'RA')))    
            fprintf(formatSpec4,avg_u)
        elseif((avg_u_c == avg_u) && (strcmp(x,'RA')))    
            fprintf('\nChoose Investment A(guaranteed returns)/B (promise of higher or lower returns')
        end 
    
        
        %%Comparison of the expeted utility at constant values VS the expected utility (Risk Seeking Person) with random values of the decision parameters.
        if((avg_u_c > avg_u) && (strcmp(x,'RS')))
        fprintf(formatSpec3,avg_u_c)
        elseif((avg_u_c < avg_u) && (strcmp(x,'RS')))    
        fprintf(formatSpec4,avg_u)
        elseif((avg_u_c == avg_u) && (strcmp(x,'RS')))    
        fprintf('\nChoose Investment A(guaranteed returns)/B (promise of higher or lower returns')    
        end 
        
        
        %%Comparison of the expeted utility at constant values VS the expected utility (Risk Neutral Person) with random values of the decision parameters.
        if((avg_u_c > avg_u) && (strcmp(x,'RN')))
        fprintf(formatSpec3,avg_u_c)
        elseif((avg_u_c < avg_u) && (strcmp(x,'RN')))    
        fprintf(formatSpec4,avg_u)
        elseif((avg_u_c == avg_u) && (strcmp(x,'RN')))    
        fprintf('\nChoose Investment A(guaranteed returns)/Investment B (promise of higher or lower returns')    
        end 
        
 end