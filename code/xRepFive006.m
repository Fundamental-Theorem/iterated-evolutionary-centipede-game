% Script to simulate Replicator dynamics and draw its phase plot

clear all; clc; close all;
M=8; 					% Number of Centipede stages
T=10; 					% Number of one-shot centipedes played
p=3/5;					% proportion of payoff received by terminating player
Tf=1; 					% final time of simulating replicator dynamics

x0=[2 1 2 0 2]';			% initial state
x0=x0/sum(x0);
x=RepDynFive(x0,p,M,T,Tf); 

% Set Figure
N = size(x, 2);
figure('Position', [200, 200, 800, 500]); % Ορίζουμε μέγεθος παραθύρου
hBar = bar(x(:, 1), 'FaceColor', 'flat'); 

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
ylim([0, 1]);
xlim([0.5, 5.5]); % 5 bars

% Figure cleaning
title('Replicator Dynamics Evolution');
ylabel('Proportions of Strategies');
grid on;

% Wait for 20 seconds before the animation
videoObj = VideoWriter('RepDyn.mp4', 'MPEG-4');
videoObj.FrameRate = 10;
open(videoObj);
drawnow;
currentFrame = getframe(gcf); 
for i = 1:20
    writeVideo(videoObj, currentFrame); 
end
pause(2);
for k = 2:N
    % update data
    set(hBar, 'YData', x(:, k));  
    drawnow; 
    tmpFrame = getframe(gcf); 
    if k == 2
        targetSize = size(currentFrame.cdata); 
    end
    currentFrame.cdata = imresize(tmpFrame.cdata, [targetSize(1), targetSize(2)]); 
    writeVideo(videoObj, currentFrame); 
    pause(0.005); 
end
close(videoObj);
