clear; clc;

match = matching_network(network_types.T, 10e9, 2775, 50);
match.Q = 20;
match = match.calc_network();

eps = 1e-4;
assert(abs(match.X_l1 - 1e3) < eps);
assert(abs(match.X_l2 - 1.0025e3) < eps);
assert(abs(match.X_l3 - 8.0359429e3) < eps);
assert(abs(match.X_l4 - 6.9237363e3) < eps);
