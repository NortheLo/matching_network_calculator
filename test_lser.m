clear; clc;

match = matching_network(network_types.L_ser, 2.4e9, 2775, 50);
match = match.calc_network();

eps = 1e-4;
assert(abs(match.Q - 7.38241) < eps);
assert(abs(match.X_l1 - 375.8934) < eps);
assert(abs(match.X_l2 - 369.1206) < eps);