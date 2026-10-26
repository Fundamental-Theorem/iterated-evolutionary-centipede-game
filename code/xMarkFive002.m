% Script to simulate Markov dynamics and draw its state transition graph

clear all; close all; clc;
M=4; 					% Number of Centipede stages
T=10; 					% Number of one-shot centipedes played
p=3/4;					% proportion of payoff received by terminating player
N=20;					% population size
Tm=100;					% final time of simulating Markov dynamics
s0=[5 5 5 3 2];				% initial Markov state

P=StateTransitionsFive(p,M,T,N);
s=MarkDynFive(s0,p,M,T,N,P,Tm); 

% Set Figure
K = size(s, 2);
figure('Position', [200, 200, 800, 500]); % Ορίζουμε μέγεθος παραθύρου
hBar = bar(s(:, 1), 'FaceColor', 'flat'); 

% Set a different color
hBar.CData(1,:) = [0.5529411764705883, 0.03137254901960784, 0.00392156862745098]; % Μπάρα 1: Μπλε-Σιέλ
hBar.CData(2,:) = [0.7490196078431373, 0.023529411764705882, 0.011764705882352941]; % Μπάρα 2: Κόκκινο
hBar.CData(3,:) = [0.9568627450980393, 0.8352941176470589, 0.5529411764705883]; % Μπάρα 3: Πράσινο
hBar.CData(4,:) = [0.4392156862745098, 0.5529411764705883, 0.5058823529411764]; % Μπάρα 4: Πορτοκαλί
hBar.CData(5,:) = [0, 0.0784313725490196, 0.15294117647058825]; % Μπάρα 5: Μοβ

% 3. Προσθήκη Λεζάντας κάτω από κάθε μπάρα
% Αντικατάστησε τα ονόματα με αυτά που ταιριάζουν στην εργασία σου
barLabels = {'All-M', 'All-1', 'Grim', 'Old Test.', 'New Test.'};
xticks(1:5);            % Ορίζει τις θέσεις των ticks
xticklabels(barLabels); % Βάζει τα ονόματα από κάτω

% Adjust Axes
ylim([0, N]);
xlim([0.5, 5.5]); % 5 bars

% Figure cleaning
title('Markovian Dynamics Evolution');
ylabel('Players adopting each strategy');
grid on;

% Wait for 20 seconds before the animation
videoObj = VideoWriter('MarkDyn.mp4', 'MPEG-4');
videoObj.FrameRate = 10;
open(videoObj);
drawnow;
currentFrame = getframe(gcf); 
for i = 1:20
    writeVideo(videoObj, currentFrame); 
end
pause(2);
for k = 2:K
    % update data
    set(hBar, 'YData', s(:, k));  
    drawnow; 
    tmpFrame = getframe(gcf); 
    if k == 2
        targetSize = size(currentFrame.cdata); 
    end
    currentFrame.cdata = imresize(tmpFrame.cdata, [targetSize(1), targetSize(2)]); 
    writeVideo(videoObj, currentFrame); 
    pause(0.08); 
end
close(videoObj);


