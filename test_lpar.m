clear; clc;

match = matching_network(network_types.L_par, 10e9, (150 - i * 231), 50);
match = match.calc_network();

eps = 1e-4;
assert(abs(match.Q - 3.019) < eps);
assert(abs(match.X_l1 - 167.515) < eps);
assert(abs(match.X_l2 - 150.9536) < eps);