classdef matching_network
    properties
        freq    % [Herz]
        R_l     % [Ohm] Load impedance 
        R_s     % [Ohm] Source impedance
        type    % [network_types] enum with type

        w       % [rad] filled in by constructor

        % results
        Q       % [ ] quality factor
        X_l1    % [Ohm]
        X_l2    % [Ohm]
        X_l3    % [Ohm]
        X_l4    % [Ohm]
    end
    
    methods
        function obj = matching_network(type, freq, R_s, R_l)
            if nargin > 0
                obj.type = type;
                obj.freq = freq;
                obj.R_l = R_l;
                obj.R_s = R_s;

                obj.w = 2 * pi * obj.freq;
            end
        end
        
        function obj = calc_l_series(obj)
            
            % on complex sources calc Q and capacitor to  
            if  ~isreal(obj.R_s)
                Q_comp = imag(obj.R_s) / real(obj.R_s);
                R_par = (1 + Q_comp^2) * real(obj.R_s);
                X_par = R_par / Q_comp;
                obj.R_s = R_par + i * X_par;
                % depending on the source impedance choose inductor or
                % capacitor to compensate
                if imag(obj.R_s) < 0
                    C_par = 1 / (obj.w * X_par)
                end
                if imag(obj.R_s) > 0 
                    L_par = X_par / obj.w
                end
            end
            
            obj.Q = sqrt(real(obj.R_s) / real(obj.R_l) - 1);
            obj.X_l1 = real(obj.R_s) / obj.Q;
            obj.X_l2 = real(obj.R_l) * obj.Q;

      
        end

        function obj = calc_network(obj)
            switch obj.type
                case network_types.L_ser
                    obj = obj.calc_l_series();
                case network_types.L_par
                    disp('Calculating L-par matching network...');
                case network_types.T
                    disp('Calculating T matching network...');
                case network_types.PI
                    disp('Calculating PI matching network...');
                otherwise
                    disp('Unknown matching network');
            end
        end

        function L = calc_inductance(obj, x_i)
                L = x_i / obj.w;
        end

        function C = calc_capacitance(obj, x_c)
                C = 1 / (obj.w * x_c);
        end
    end
end

