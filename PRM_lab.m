function path = PRM_lab(qstart, qgoal, C_space, tolerance, tree)
figure(3), hold on
plot3(qstart(1),qstart(2),qstart(3),'b*')
plot3(qgoal(1),qgoal(2),qgoal(3),'g*')
qs.coordinates = qstart;
qs.cost = 0;
qs.parent = 0;
D(1) = nan;
for i2 = 2:1:length(tree)
    is_collision = collision_check_3d(tree(i2).coordinates, qstart, C_space, tolerance);
    if is_collision == false
    D(i2) = dist_3d(tree(i2).coordinates,qstart);
    else D(i2) = 10000000;
    end
end
[shortest_distance, idx] = min(D);
    tree(1).coordinates = qstart;
    tree(1).parent = 0;
    tree(1).cost = 0;
    tree(idx).parent = 1;
    tree(idx).cost = dist_3d(qstart, tree(idx).coordinates);
    new_second_tree = tree(idx);
    tree(idx) = tree(2);
    tree(2) = new_second_tree;


for i2 = 2:1:length(tree)
    is_collision = collision_check_3d(tree(i2).coordinates, qgoal, C_space, tolerance);
    if is_collision == false
    D(i2) = dist_3d(tree(i2).coordinates,qgoal);
    else D(i2) = 10000000;
    end
end
[shortest_distance, idx] = min(D);

qf.coordinates = qgoal;
qf.parent = idx;
qf.cost = dist_3d(tree(idx).coordinates, qgoal);
tree(length(tree) + 1) = qf;

tr2 = 1;
q_end = tree(length(tree));
while q_end.parent ~= 0
    startt = q_end.parent;
    traj(tr2,1) = tree(startt).coordinates(1);
    traj(tr2,2) = tree(startt).coordinates(2);
    traj(tr2,3) = tree(startt).coordinates(3);
    tr2 = tr2 +1;
    figure(3)
    line([q_end.coordinates(1), tree(startt).coordinates(1)],...
        [q_end.coordinates(2), tree(startt).coordinates(2)],...
        [q_end.coordinates(3), tree(startt).coordinates(3)],...
        'Color', 'r', 'LineWidth', 4);
    q_end = tree(startt);
end
path = traj;
end
