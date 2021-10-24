function q = steer_3d(q1, q2, max_distance)
       q(1) = q2(1) + ((q1(1)-q2(1))*max_distance)/dist_3d(q1,q2);
       q(2) = q2(2) + ((q1(2)-q2(2))*max_distance)/dist_3d(q1,q2);
       q(3) = q2(3) + ((q1(3)-q2(3))*max_distance)/dist_3d(q1,q2);
end