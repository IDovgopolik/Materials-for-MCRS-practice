function c = collision_check_3d(tree, q, C_space, tolerance)
q1 = tree; c = false;
for i = 1:1:length(C_space)
    dist = point_to_line_distance(C_space(i,:), q1, q);
    d1 = dist_3d(q1,q); d2 = dist_3d(q,C_space(i,:)); d3 = dist_3d(q1,C_space(i,:));
    alfa1 = rad2deg(acos((d1*d1 + d2*d2 - d3*d3)/(2*d1*d2)));
    alfa2 = rad2deg(acos((d2*d2 + d3*d3 - d1*d1)/(2*d2*d3)));
    if dist < tolerance && alfa1 <= 90 && alfa2 <= 90
        c = true; break;
    elseif alfa1 > 90 && d3 < tolerance
        c = true; break;
    elseif alfa2 > 90 && d2 < tolerance
        c = true; break;
    end
end
end