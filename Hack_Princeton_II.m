%% Creates a N*M grid

N=6; M=7;
x=linspace(1,N,N);
y=linspace(1,M,M);
[X,Y]=meshgrid(x,y);
plot(X(:)-.5,Y(:)-.5,'o')
hold on
axis([0,N,0,M])


x=linspace(0,N,200);
y=linspace(0,M,200);
z=ones(1,200);
for k=0:M
    plot(x,k*z,'k','LineWidth',4)
end

for k=0:N
    plot(k*z,y,'k','LineWidth',4)
end

%% Initialization
num_edg=(N-1)*M+(M-1)*N; %Number of edges in secondary grid
C=linspace(1,N*M,N*M)'; % Cell to which each node belongs. At the beginning
                        % each node is in a different cell.

% Construct list of edges ([nodeA nodeB])
S=zeros(num_edg,2);
for j=0:M-1   % Adds horizontal edges to the list
    for k=1:N-1
        S(k+(N-1)*j,1)=k+N*j;
        S(k+(N-1)*j,2)=k+N*j+1;
    end
end
d=M*(N-1);
for j=1:N     % Adds vertical edges to the list.
    for k=1:M-1
        S(d+k+(M-1)*(j-1),1)=j+(M-1)*(k-1);
        S(d+k+(M-1)*(j-1),2)=j+(M-1)*k;
    end
end

%% Edge-removing loop
a=max(C);
while a>1 %While there is more than one cell
rnd=ceil(rand(1)*size(S,1));
edge=S(rnd,:); %Pick a random secondary edge.

cellA=C(edge(1));  %Cell of node A.
cellB=C(edge(2));  %Cell of node B.
if (cellA-cellB) ~=0  %If they are from different cells.
    idx=find(C==max(cellA,cellB));
    C(idx)=min(cellA,cellB);  % Unite nodes in each of the two cells
    %Coordinates (row,column) of nodes A and B
    cA=mod(edge(1),N)+N*(mod(edge(1),N)==0); 
    cB=mod(edge(2),N)+N*(mod(edge(2),N)==0); 
    rA=floor((edge(1)-1)/N)+1; 
    rB=floor((edge(2)-1)/N)+1;
    %Remove corresponding primary edge.
    if abs(edge(1)-edge(2))==1 %Horizontal edge
        plot(cA*ones(200,1),linspace(rA-1,rA,200),'w','LineWidth',4)
    else %Vertical edge
       plot(linspace(cA-1,cA,200),rA*ones(200,1),'w','LineWidth',4)
    end
    S(rnd,:)=[];   %Remove edge from list.
end
a=max(C);
end

%% Find centroid of remaining edges
% Input parameters:
h=M; %Hight of rectangle
l=N; %Half lenght of rectangle

K=size(S,1);
CEN=zeros(K,3);
for k=1:K
    edge=S(k,:);
    cA=mod(edge(1),N)+N*(mod(edge(1),N)==0); 
    cB=mod(edge(2),N)+N*(mod(edge(2),N)==0); 
    rA=floor((edge(1)-1)/N)+1; 
    rB=floor((edge(2)-1)/N)+1;
     if abs(edge(1)-edge(2))==1 %Horizontal edge
        CEN(k,1)=cA*l/N; CEN(k,2)=(rA-.5)*h/M; CEN(k,3)=1; 
    else %Vertical edge
       CEN(k,1)=(cA-.5)*l/N; CEN(k,2)=rA*h/M;
     end
    plot(CEN(k,1),CEN(k,2),'or')
end

%Third component of CEN indicates if it is horizontal (1) or vertical (0)