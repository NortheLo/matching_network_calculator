classdef network_types
    enumeration
        % matching network types
        L_ser,  % L-Type with second impedance in series with R_l
        L_par,  % L-Type with second impedance in parallel with R_l
        T,      % T-Type; Cascaded L_par -> L_ser
        PI      % PI-Type; Cascaded L_ser -> L_par
    end
end

