% Script to simulate Markov dynamics and draw its state transition graph

clear all; clc; close all;
M=4; 					% Number of Centipede stages
T=10; 					% Number of one-shot centipedes played
p=3/4;					% proportion of payoff received by terminating player
N=10;					% population size
Tm=10;					% final time of simulating Markov dynamics
s0=[8 1 1];				% initial Markov state

P=StateTransitionGraph(p,M,T,N);
s=MarkDyn(s0,p,M,T,N,P,Tm);

