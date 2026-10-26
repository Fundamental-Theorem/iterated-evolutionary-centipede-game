% Script to simulate Replicator dynamics and draw its phase plot

clear all; clc; close all;
M=4; 					% Number of Centipede stages
T=10; 					% Number of one-shot centipedes played
p=3/5;					% proportion of payoff received by terminating player
Tf=15; 					% final time of simulating replicator dynamics

x0=rand(3,1);			% initial state
x0=x0/sum(x0);
x=RepDyn(x0,p,M,T,Tf); 
%PhasePlot(p,M,T)

