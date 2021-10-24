function traj = RRT_lab(qstart, qgoal, C_space, qlim, max_distance, max_number_of_q, tolerance)
qs.coordinates = qstart;
qs.cost = 0;
qs.parent = 0;
tree(1) = qs; is_collision = true;
figure(2), hold on
plot3(qstart(1),qstart(2),qstart(3),'b*')
plot3(qgoal(1),qgoal(2),qgoal(3),'g*')
for i1 = 1:1:max_number_of_q
for i = 1:1:length(tree)
    is_collision = collision_check_3d(tree(i).coordinates, qgoal, C_space, tolerance);
    if is_collision == false
    D(i) = dist_3d(tree(i).coordinates,qgoal);
    else D(i) = 10000000;
    end
end
[shortest_distance, idx] = min(D);
if D(idx) < max_distance
    tree(i1+1).coordinates = qgoal;
    tree(i1+1).parent = idx;
    tree(i1+1).cost = shortest_distance;
    figure(2)
    line([tree(idx).coordinates(1), tree(length(tree)).coordinates(1)],...
        [tree(idx).coordinates(2), tree(length(tree)).coordinates(2)],...
        [tree(idx).coordinates(3), tree(length(tree)).coordinates(3)],...
        'Color', 'k', 'LineWidth', 2);
    drawnow
    break
else
    qrand = [qlim(1)*rand(1) qlim(2)*rand(1) qlim(3)*rand(1)] - 90;
    
    for i = 1:1:length(tree)
    is_collision = collision_check_3d(tree(i).coordinates, qrand, C_space, tolerance);
    if is_collision == false
    D(i) = dist_3d(tree(i).coordinates,qrand);
    else D(i) = 10000000;
    end
    end
    [shortest_distance, idx] = min(D);
if D(idx) <= max_distance
    tree(i1+1).coordinates = qrand;
    tree(i1+1).parent = idx;
    tree(i1+1).cost = shortest_distance;
    figure(2)
    line([tree(idx).coordinates(1), tree(length(tree)).coordinates(1)],...
        [tree(idx).coordinates(2), tree(length(tree)).coordinates(2)],...
        [tree(idx).coordinates(3), tree(length(tree)).coordinates(3)],...
        'Color', 'k', 'LineWidth', 2);
    drawnow   
else qrr = steer_3d( qrand,tree(idx).coordinates, max_distance);
    tree(i1+1).coordinates = qrr;
    tree(i1+1).parent = idx;
    tree(i1+1).cost = dist_3d(tree(idx).coordinates, qrr);
    figure(2)
    line([tree(idx).coordinates(1), tree(length(tree)).coordinates(1)],...
        [tree(idx).coordinates(2), tree(length(tree)).coordinates(2)],...
        [tree(idx).coordinates(3), tree(length(tree)).coordinates(3)],...
        'Color', 'k', 'LineWidth', 2);
    drawnow   
end
end
end
if tree(length(tree)).coordinates == qgoal
tr2 = 1;
q_end = tree(length(tree));
while q_end.parent ~= 0
    startt = q_end.parent;
    traj(tr2,1) = tree(startt).coordinates(1);
    traj(tr2,2) = tree(startt).coordinates(2);
    traj(tr2,3) = tree(startt).coordinates(3);
    tr2 = tr2 +1;
    figure(2)
    line([q_end.coordinates(1), tree(startt).coordinates(1)],...
        [q_end.coordinates(2), tree(startt).coordinates(2)],...
        [q_end.coordinates(3), tree(startt).coordinates(3)],...
        'Color', 'r', 'LineWidth', 4);
    q_end = tree(startt);
end
else mes = 'Trajectory was not found!'
end
end