% Script to simulate Replicator dynamics and draw its phase plot

clear all; clc; close all;
M=4; 					% Number of Centipede stages
T=10; 					% Number of one-shot centipedes played
p=3/5;					% proportion of payoff received by terminating player
Tf=15; 					% final time of simulating replicator dynamics

x0 = [0.65, 0.3, 0.05];    % initial state => [1,0,0]
x=RepDyn(x0,p,M,T,Tf); 
PhasePlot(p,M,T)



