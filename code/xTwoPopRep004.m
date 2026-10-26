clear all; clc; close all;
M=4; 					% Number of Centipede stages
T=10; 					% Number of one-shot centipedes played
p=3/4;					% proportion of payoff received by terminating player
Tf=1; 					% final time of simulating replicator dynamics

x0=[0.025 0.95 0.025];
y0=[0.05 0.9 0.05];
x0=x0/sum(x0);
y0=y0/sum(y0);
[x,y]=RepDyn2Pop(x0,y0,p,M,T,Tf); 

