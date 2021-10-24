function tree = PRM_map_analyze(C_space, qlim, number_of_q, tolerance)
qlist = [];
for i = 1:1:number_of_q
        qrand = [qlim(1)*rand(1) qlim(2)*rand(1) qlim(3)*rand(1)] - 90;
        qlist = [qlist; qrand];
end
k = 2;
for i = 1:1:length(qlist)
    for j = 1:1:length(qlist)
        if i ~= j
        is_collision = collision_check_3d(qlist(i,:), qlist(j,:), C_space, tolerance);
            if is_collision == false
                tree(k).parent = i + 1;
                tree(k).coordinates = qlist(j,:);
                tree(k).cost = dist_3d(qlist(i,:),qlist(j,:));
                k = k + 1;
                figure(3), hold on
                line([tree(i+1).coordinates(1), tree(length(tree)).coordinates(1)],...
                    [tree(i+1).coordinates(2), tree(length(tree)).coordinates(2)],...
                    [tree(i+1).coordinates(3), tree(length(tree)).coordinates(3)],...
                'Color', 'k', 'LineWidth', 2);
                drawnow
            end
        end
    end
end
end