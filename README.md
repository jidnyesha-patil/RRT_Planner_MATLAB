# RRT_Planner_MATLAB
## Implementing RRT using Navigation Toolbox in MATLAB

### Objective: Design a map using the Navigation Toolbox in MATLAB, use the map to find an optimal path from a set start location to goal using a RRT planner from the Navigation Toolbox.

#### Rapidly exploring Random Tree (RRT)
Rapidly exploring Random Tree (RRT) is a motion planner which uses tree structures to build a search tree. The tree build by random sampling from the state space given as an input. Generally, the tree searches a sizeable amount of the space and connects the start to the goal state. An overview of the process is as follows:
    - A random state is selected from the state space
    - The next state to be selected has to be in the search tree and be nearest to the randomly selected space in the direction of the goal state
    - The tree expands from this near state to the random state until a new state is reached
    - This new state is added to the search tree

Detailed explaination in "Randomized Kinodynamic Planning.", S.M. Lavalle and J.J. Kuffner. The International Journal of Robotics Research. Vol. 20, Number 5, 2001, pp. 378 – 400.

#### How this implementation works
- A maze image is downloaded and used as the map for this problem statement. Using the *binaryOccupancyMap* function from the Motion Planning section of Navigation Toolbox in MATLAB, the image of the maze is converted to a binary map.
- The *binaryOccupancyMap* function takes black and white image as input and converts it to a two-dimensional occupancy map object. Every cell in this occupancy grid contains a value showing the status of that cell. A location occupied is denoted by value 1 while free location is denoted by 0. The first location in this grid has the index (1,1) and begins at the top-left corner of the grid.
- The downloaded image is converted to grayscale, resized for convenience and binarized so that it can be passed as an argument to the *binaryOccupancyMap* function. Now, the map for world is ready and is displayed as shown in Fig. 1.
<p align="center">
  <img width="400" src="https://user-images.githubusercontent.com/94715242/218627664-4face33a-06a9-43b7-bd8e-bb762901f03f.png">
</p>

- The *plannerRRT* function from Navigation Toolbox of MATLAB needs two arguments: the current state space and a state validator. The basic state space is created using the function *stateSpaceSE2* and this state space is passed as argument to make the state validator using *validatorOccupancyMap*. This creates a occupancy map based state validator using the state space created before. 
- The occupancy grid achieved from the maze image is used to create the map for state validator. The validation distance for which the function checks the state validity is set to 0.25 units. The limits of the world are set to those of the map we loaded to avoid any confusion. 
- The *plannerRRT* function is used to map the optimal path from the state space to the state validator space. The maximum distance allowed between connections is given as 0.45 units. The planner runs for **10,000 iterations**. 
- Set the start position and goal position for our point robot and use the planner. 
- Extract required data from the path object returned and plot how the x coordinate, y coordinate and traversal angle changes over time.

### Results
<p align="center">
<img width="400" src="https://user-images.githubusercontent.com/94715242/218627755-374e0ca6-e5b1-4ee9-ba6f-58311a66c8b8.png">
</p>
<p align="center">
<img width="800" src="https://user-images.githubusercontent.com/94715242/218627523-31a4f165-cdea-493b-aea0-05fdb21ce994.png">
</p>
