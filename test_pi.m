clear; clc;

match = matching_network(network_types.PI, 10e9, 2775, 50);
match.Q = 20;
match = match.calc_network();

eps = 1e-4;
assert(abs(match.X_l1 - 1.3875e2) < eps);
assert(abs(match.X_l2 - 138.4039) < eps);
assert(abs(match.X_l3 - 17.2661) < eps);
assert(abs(match.X_l4 - 20.0397) < eps);
