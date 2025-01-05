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
        
        function obj = calc_l_network(obj)
            
            % on complex sources calc Q of the resonance and 
            % the component to compensate
            if  ~isreal(obj.R_s)
                Q_comp = imag(obj.R_s) / real(obj.R_s);
                R_par = (1 + Q_comp^2) * real(obj.R_s);
                X_par = R_par / Q_comp;
                obj.R_s = R_par + 1i * X_par;
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

        function obj = calc_t_type(obj)
            R_s_1 = (1 + obj.Q^2) * obj.R_l;
            
            % high Q l-network
            obj.X_l1 = real(obj.R_l) * obj.Q;
            obj.X_l2 = real(R_s_1) / obj.Q;

            % low Q l-network
            obj.Q = sqrt(real(R_s_1) / real(obj.R_s) - 1);
            
            obj.X_l3 = real(R_s_1) / obj.Q;
            obj.X_l4 = real(obj.R_s) * obj.Q;
            
        end
        
        function obj = calc_pi_type(obj)
            R_l_new = real(obj.R_s) / (1 + obj.Q^2);
            
            obj.X_l1 = real(obj.R_s) / obj.Q;
            obj.X_l2 = obj.Q * R_l_new;
            
            obj.Q = sqrt(real(obj.R_l) / real(R_l_new) - 1);
            obj.X_l3 = obj.Q * R_l_new;
            obj.X_l4 = real(obj.R_l) / obj.Q;
        end

        function obj = calc_network(obj)
            switch obj.type
                case network_types.L_ser
                    obj = obj.calc_l_network();
                case network_types.L_par
                    obj = obj.calc_l_network();
                case network_types.T
                    obj = obj.calc_t_type();
                case network_types.PI
                    obj = obj.calc_pi_type();
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

