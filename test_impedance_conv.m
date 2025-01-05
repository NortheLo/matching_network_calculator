clear; clc;
eps = 1e-4;

% test impedance to inductance/capacitance converter at two different f
% Source and load impedance are not relevant in this test
r_s = 2775;
r_l = 50;

match = matching_network(network_types.L_ser, 2.4e9, r_s, r_l);
match = match.calc_network();

x_i = 301.59289;
x_c = 0.66315;
ref_i = 20e-9;
ref_c = 100e-12;

L = match.calc_inductance(x_i);
C = match.calc_capacitance(x_c);
assert(abs(L - ref_i) < eps);
assert(abs(C - ref_c) < eps);


match = matching_network(network_types.L_ser, 10e3, r_s, r_l);
x_i = 1256.63;
x_c = 0.15915;
ref_i = 20e-3;
ref_c = 100e-6;

L = match.calc_inductance(x_i);
C = match.calc_capacitance(x_c);
assert(abs(L - ref_i) < eps);
assert(abs(C - ref_c) < eps);