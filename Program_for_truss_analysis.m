clear 
clc

fprintf('\n----------Program for 2D truss analysis----------');
node=input('\nEnter the co-ordinates of the nodes in the vector form:');
conn=input('\nEnter the start and end nodes of each element in the vector form:');
A=input('\nEnter cross-sectional area of the element:');
E=input('\nEnter modulus of elasticity of the element:');
dof=input('\nEnter the direction of nodes where freedom is allowed:');
nn=size(node,1);
ndof=2*nn;  
ne=size(conn,1);
F=zeros(2*nn,1);
extf=input('\n Number of external loads:');
while(extf>0)
    force=input('\n External load:');
    nd=input('\n at node(with direction):');
    F(nd)=force;
    extf=extf-1;
end
K=zeros(ndof,ndof);      
d=zeros(ndof,1);        
for i=1:size(conn)
    hold on
    plot([node(conn(i,1),1),node(conn(i,2),1)],[node(conn(i,1),2),node(conn(i,2),2)],Color="r",LineWidth=2);
end
for e=1:ne
    n1=conn(e,1);     
    n2=conn(e,2);    
    x1=node(n1,1);    
    y1=node(n1,2);    
    x2=node(n2,1);   
    y2=node(n2,2);     
    L=sqrt(((x2-x1))^2+((y2-y1)^2)); % Length of the respective truss
    l=(x2-x1)/L;    %cosine calculated for the truss
    m=(y2-y1)/L;    %sine calculated for the truss
    ke=((A*E)/L)*[l*l,m*l,-l*l,-m*l;m*l,m*m,-m*l,-m*m;-l*l,-m*l,l*l,m*l;-m*l,-m*m,m*l,m*m];
    sctr=[2*n1-1 2*n1 2*n2-1 2*n2];
    K(sctr,sctr)=K(sctr,sctr)+ke;
end
% displacements at each node
d(dof)=K(dof,dof)\F(dof);
fprintf('\n----------Nodal Displacements----------');
fprintf('\nNo.  X-Direction     Y-Direction');
for i=1:nn
    fprintf('\n%5d  %8.3e   %8.3e',i,d(2*i-1),d(2*i));
end

%Reactions at nodes
f=K*d;
fprintf('\n----------Reactions----------');
fprintf('\nNo.  X-Direction     Y-Direction');
for i=1:nn
    fprintf('\n%5d  %8.3e   %8.3e',i,f(2*i-1),f(2*i));
end
fprintf('\n----------Elemental strain & stress----------');
fprintf('\nNo.  Strain  Stress');
for e=1:ne
    
    n1=conn(e,1);
    n2=conn(e,2);
    x1=node(n1,1);
    y1=node(n1,2);
    x2=node(n2,1);
    y2=node(n2,2);
    L=sqrt(((x2-x1))^2+((y2-y1)^2));
    l=(x2-x1)/L;    
    m=(y2-y1)/L;
    B=(1/L)*[-l -m l m];
    sctr=[2*n1-1 2*n1 2*n2-1 2*n2];
    Strain=B*d(sctr);
    Stress=E*Strain;
    
    fprintf('\n%5d  %8.3e   %8.3e',e,Strain,Stress);
end