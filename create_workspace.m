function [rbt, obstacle] = create_workspace(a, alpha, d, offset_of_theta)
% This function create a workspace of 6-Dof manipulator using Corke
% Robotics toolbox, which contains the robot
% and the parallelepiped as obstacle. The function gives back robot as
% structure, created by Corke Robotic Toolbox, and the matrix which is a
% description of obstacle.

% Эта функция создаёт рабочее пространство шестизвенного манипулятора при
% помощи Corke Robotics toolbox, которое включает в себя робота и
% препятствие в виде параллелепипеда. Функция возвращает робота как
% структуру, созданную Corke Robotics toolbox, и матрицу, которая описывает
% препятствие.

% Creation of 6-Dof manipulator in Corke robotics toolbox
% Создание шестизвенного манипулятора с использованием Corke robotics toolbox
L1 = Link('revolute','d', d(1), 'a', a(1), 'alpha', alpha(1));
L2 = Link('revolute','d', d(2), 'a', a(2), 'alpha', alpha(2));
L3 = Link('revolute','d', d(3), 'a', a(3), 'alpha', alpha(3));
L4 = Link('revolute','d', d(4), 'a', a(4), 'alpha', alpha(4));
L5 = Link('revolute','d', d(5), 'a', a(5), 'alpha', alpha(5));
L6 = Link('revolute','d', d(6), 'a', a(6), 'alpha', alpha(6));
rbt = SerialLink([L1,L2,L3,L4,L5,L6],'name','6-DoF manipulator');
figure
rbt.plot(offset_of_theta,'scale',0.7), hold on
% Creation of obstacle (box)
% Создание препятствия (коробка)
obstacle = [];
for x_obs = -0.4:0.05:0.4
    for y_obs = 0.1:0.05:0.3
        for z_obs = -1:0.05:0.15
            obstacle = [obstacle; x_obs y_obs z_obs];
        end
    end
end
% Visualization
% Визуализация
x = [-0.4 0.4 0.4 -0.4 -0.4; -0.4 0.4 0.4 -0.4 -0.4];
y = [0.1 0.1 0.3 0.3 0.1; 0.1 0.1 0.3 0.3 0.1];
z = [-1 -1 -1 -1 -1; 0.15 0.15 0.15 0.15 0.15];
surf(x,y,z,'EdgeColor',[1 0 0],'FaceColor','m')
title('Workspace')
xlabel('x, m')
ylabel('y, m')
zlabel('z, m')
hold off
end