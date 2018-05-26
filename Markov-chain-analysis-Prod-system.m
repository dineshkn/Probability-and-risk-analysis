#Markov chain analysis to estimate effect of parameters on production system throughput and long run inventory on hand

N=3; r = 1;m = 100;
l = 4; % Arrival Rate of jobs
u = 5; % Service Rate of jobs
t = 60;% Starting rate of m/c


zb = zeros(1,10);
xb = zeros(1,10);
ut = zeros(1,10);

for t = 10:10:100
Q = zeros(2*N+2*m+1,2*N+2*m+1);
	for i = 1:(2*N+2*m+1)
	  for j = 1:(2*N+2*m+1)
            if(i < N+m+1 && j == i+1)	
            Q(i,j) = l;
            elseif(i > N && i < N+m+2 && j == i+N+m)
	     	Q(i,j) = t;
	     	elseif(i == N+m+2 && j == 1)
	     	Q(i,j) = u;
	        elseif(i > N+m+2 && j == i-1)
	     	Q(i,j) = u;	
	        elseif(i >= N+m+2 && j == i+1)
	        Q(i,j) = l;	
            end
	end
    end
for i = 1:(2*N+2*m+1)
   for j = 1:(2*N+2*m+1)
        if(i == j)
              Q(i,j) = -sum(Q(i,:));
        end
   end
end

SS = expm(Q*100);
SS = SS(1,:);

Vec = zeros(1,2*N+2*m+1);
for k = 1:(2*N+2*m+1)
    if(k ~= 1 && k < N+m+2)
    	Vec(k) = k-1;
    elseif(k > N+m+1)
    	Vec(k) = k-(N+m+1);
    end
end    	

%Calculate long run avg no of jobs
invb = 0;

for s = 1:(2*N+2*m+1)
	invb = invb + (Vec(s)*SS(s));
end

utl = 0;

%Calculate utilization
utl = sum(SS(N+m+2:end));

zb(r) = invb;
xb(r) = t;
ut(r) = utl;
r = r+1;
end

plot(xb,zb)
xlabel('Rate at which machine starts up for processing'); 
ylabel('Avg no of jobs in system');
title('Long run avg no of jobs in system vs \alpha');
figure;

plot(xb,ut)
xlabel('Rate at which machine starts up for processing');
ylabel('Utilization of machine');
title('Machine utilization vs \alpha');



