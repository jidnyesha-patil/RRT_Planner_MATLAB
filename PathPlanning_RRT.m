% Path Planning using RRT

maze_img = imresize(imcomplement(imbinarize(rgb2gray(imread('maze_easy.jpg')))),0.25);
binary_map = binaryOccupancyMap(maze_img);
show(binary_map);
%%
init_state_space = stateSpaceSE2;
state_validator = validatorOccupancyMap(init_state_space);
state_validator.Map = binary_map;
state_validator.ValidationDistance = 0.25;
init_state_space.StateBounds = [ binary_map.XWorldLimits;binary_map.YWorldLimits; [-pi pi]];
%%
planner = plannerRRT(init_state_space,state_validator);
planner.MaxConnectionDistance = 0.45;
planner.MaxIterations = 1e4;
start = [25,75,0];
goal = [225,150,0];
[pathObj, sol]=plan(planner,start,goal);
%%
show(binary_map);
hold on
plot(sol.TreeData(:,1),sol.TreeData(:,2),'b-');
plot(pathObj.States(:,1),pathObj.States(:,2),'r-','LineWidth',2);
plot(start(1),start(2),'ro',goal(1),goal(2),'ro','MarkerSize',10,'MarkerFaceColor','r');
%%
del_x = zeros(length(pathObj.States)-1,1);
del_y = zeros(length(pathObj.States)-1,1);
del_theta = zeros(length(pathObj.States)-1,1);
for i=(2:length(pathObj.States)-1)
    del_x(i-1) = pathObj.States(i,1)-pathObj.States(i-1,1);
    del_y(i-1) = pathObj.States(i,2)-pathObj.States(i-1,2);
    del_theta(i-1) = atand(del_y(i-1)/del_x(i-1));
end
%%
figure
plot(del_x);
hold on
plot(del_y);
title("Performance Plot - X and Y change");
xlabel("Time units");
ylabel("Distance units");
legend('Delta x', 'Delta y');
hold off
figure
plot(del_theta,'b');
title("Performance Plot - Theta change");
xlabel("Time units");
ylabel("Delta theta");