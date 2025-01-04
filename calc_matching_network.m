clear; clc;

%match = matching_network(network_types.L_ser, 28e9, 62.9 + i * 165.8, 50);
match = matching_network(network_types.L_ser, 2.4e9, 2775, 50)
match.calc_network()
