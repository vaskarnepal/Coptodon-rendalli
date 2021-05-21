function [prdData, info] = predict_Coptodon_rendalli(par, data, auxData)
  
  % unpack par, data, auxData
  cPar = parscomp_st(par);  % calculate compound parameters from par (primary parameters)
  vars_pull(par);           % make primary parameters available
  vars_pull(cPar);          % make compound parameters available
  vars_pull(data);  vars_pull(auxData);
  
  % customized filters for allowable parameters of the standard DEB model (std)
  % for other models consult the appropriate filter function.
  filterChecks =  k * v_Hp >= f_tL^3 || k * v_Hp >= f_ChanDeSi1981^3 || ...         % constraint required for reaching puberty with f_tL
                 ~reach_birth(g, k, v_Hb, f_tL)|| ...                               % constraint required for reaching birth with f_tL
                 E_Hh >= E_Hb || E_Hh < 0 || ...                                    % maturity at hatching must be positive and greater than that at birth
                 T_L>T_ref || T_L<273 || T_H<T_ref || T_AH<T_H || T_AL<T_H || ...	% Temperatures for Arrhenius curve
                 f_Hlop2011 > 1.5;                                                  % Note: Consumption in wild can be twice that in captivity (which is assumed to be as high as 1, here);
       
  if filterChecks  
    info = 0;
    prdData = {};
    return;
  end  
  
  
  % compute temperature correction factors
  pars_T     = [T_A, T_L, T_H, T_AL, T_AH];  % Using 5-parameter Arrhenius function
  TC_ah      = tempcorr(temp.ab, T_ref, pars_T);
  TC_tp      = tempcorr(temp.tp, T_ref, pars_T);
  TC_am      = tempcorr(temp.am, T_ref, pars_T);
  TC_Ri      = tempcorr(temp.Ri, T_ref, pars_T);
  TC_tL0     = tempcorr(temp.tL0, T_ref, pars_T);
  TC_WwR     = tempcorr(temp.WwR, T_ref, pars_T);
  TC_T_JO    = tempcorr(C2K(T_JO(:,1)), T_ref, pars_T);
  TC_JX_T1   = tempcorr(C2K(JX_T1(:,1)), T_ref, pars_T);
  TC_JX_T2   = tempcorr(C2K(JX_T2(:,1)), T_ref, pars_T);
  TC_tdW_T20 = tempcorr(temp.tdW_T20, T_ref, pars_T);
  TC_tdW_T24 = tempcorr(temp.tdW_T24, T_ref, pars_T);
  TC_tdW_T28 = tempcorr(temp.tdW_T28, T_ref, pars_T);
  TC_tdW_T32 = tempcorr(temp.tdW_T32, T_ref, pars_T);
  
  
  TC_ab = TC_ah;
  
  %% zero-variate data

  % life cycle
  pars_tp = [g; k; l_T; v_Hb; v_Hp];                        % compose parameter vector
  [t_p, t_b, l_p, l_b, info] = get_tp(pars_tp, f);          % -, scaled times & lengths at f
  
  % Initial (i.e., egg)
  pars_UE0 = [V_Hb; g; k_J; k_M; v];                        % compose parameter vector
  U_E0 = initial_scaled_reserve(f, pars_UE0);               % d.cm^2, initial scaled reserve
  prdData.L0 = (U_E0 * p_Am * w_E/ mu_E/ d_E)^(1/3)/ del_Y; % cm, egg diameter
  
  % hatch   
  [U_H aUL] = ode45(@dget_aul, [0; U_Hh; U_Hb], [0 U_E0 1e-10], [], kap, v, k_J, g, L_m);
  a_h = aUL(2,1);                                           % d, age at hatch
  prdData.ah = a_h/ TC_ah;                                  % d, age at hatch corrected for temperature
  prdData.Lh = aUL(2,3)/ del_M;                             % cm, total length at hatch
  
  % birth
  L_b = L_m * l_b;                                          % cm, structural length at birth at f
  prdData.Lb = L_b/ del_M;                                  % cm, total length at birth at f
  prdData.ab = t_b/ k_M/ TC_ab;                             % d, age at birth at f and T

  
  % puberty  
  pars_tp_1 = [g k l_T v_Hb v_Hp];
  L_p_1 = L_m * get_lp(pars_tp_1, f_tL, l_b);               % cm, structural length at puberty at f_tL (i.e., WeylHech1988); L_p = L_m * l_p;
  prdData.Lp = L_p_1/ del_M;                                % cm, total length at puberty at f_tL
  prdData.tp = (t_p - t_b)/ k_M/ TC_tp;                     % d, time since birth at puberty at f_tL and T; or   aT_p = t_p/ k_M/ TC_tp; if assume age at puberty

 
  % ultimate
  l_i = f - l_T;                                            % -, scaled ultimate length at f
  L_i = L_m * l_i;                                          % cm, ultimate structural length at f
  prdData.Li = L_i/ del_M;                                  % cm, ultimate total length at f
  prdData.Wwi = L_i^3 * (1 + f * w);                        % g, ultimate wet weight 
  pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hp];   % compose parameter vector at T
  prdData.Ri = TC_Ri * reprod_rate(L_i, f, pars_R);      	% #/d, ultimate reproduction rate at T

  % life span
  pars_tm = [g; l_T; h_a/ k_M^2; s_G];                      % compose parameter vector at T_ref
  t_m = get_tm_s(pars_tm, f, l_b);                          % -, scaled mean life span at T_ref
  prdData.am = t_m/ k_M/ TC_am;                             % d, mean life span at T
  
  
  %% uni-variate data
  
  %% Length-weight; Hlop2011
  prdData.LWw  = (LWw(:,1) * del_M).^3 * (1 + f_Hlop2011 * w);             % g, expected wet weight at time; f is scaled reserve density; w is actually omega
  
  %% time since birth-length; Hlop2011
  prdData.tL  = get_Lw(f_Hlop2011, TC_tp, tL, par, cPar);                  % Juveniles and adults; 
  prdData.tL0 = get_Lw(f, TC_tL0, tL0, par, cPar);                         % Larvae; MoriMats2007; assume feeding is not at max (because wrong food, stress, etc.)
  
  %% Wet-weight v fecundity; ChanDeSi1981
  pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hp];                  % compose parameter vector at T
  Length = (WwR(:,1) / (1 + f_ChanDeSi1981 * w)).^(1/3);                   % Structural length at T and f_ChanDeSi1981
  prdData.WwR = 365 * TC_WwR * reprod_rate(Length, f_ChanDeSi1981, pars_R);% #, fecundity per year
 
  %% Temperature - O2 consumption; Caul1997
  pars_pow = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hp];                % compose pars
  p_ref = p_Am * L_m^2;                                                    % J/d, max assimilation power at max size

  Ww_0 = weight.T_JO;                                                      % g, wet weight passed through the auxData structure
  L = (Ww_0 / (1 + f * w)) .^ (1/3);                                       % cm, structural length
  pACSJGRD = p_ref * scaled_power(L, f, pars_pow, l_b, l_p);               % J/d, powers
  pADG = pACSJGRD(:, [1 7 5]);                                             % only need these columns
  pADG(:, 1) = 0;                                                          % set assim to zero because starving
  J_Org = pADG * eta_O';                                                   % organic fluxes
  O2M = (-n_M\n_O)';                                                       % matrix that converts organic to mineral fluxes
  J_Min = J_Org * O2M;                                                     % mineral fluxes; mol/d: J_C, J_H, J_O, J_N in columns
  prdData.T_JO = - J_Min(:,3) .* TC_T_JO * 32e3/ Ww_0;                     % mg O2/d.g, spec O2 consumption
  
  %% Temperature v Consumption rates
  % Hlophe 2011
  d_X1 = 0.0643;                                                           % fresh food; Moisture content of food = 0.9357
  Ww1 = weight.JX_T1;                                                      % g, wet weight 
  L = (Ww1 / (1 + f * w)) .^ (1/3);                                        % cm, structural length
  pACSJGRD = p_ref * scaled_power(L, f, pars_pow, l_b, l_p);               % J/d, powers
  pADG = pACSJGRD(:, [1 7 5]);                                             % only need these columns
  J_Org = pADG * eta_O';                                                   % organic fluxes
  prdData.JX_T1 = - (w_X/d_X1) * J_Org(:,1).* TC_JX_T1;                    % g/d, ingested food
  
  % Caulton 1982
  d_X2 = 0.0839;                                                           % fresh food; dry weight to wet weight ratio ~ 0.0839
  Ww2 = weight.JX_T2;                                                      % g, wet weight 
  L = (Ww2/ (1 + f * w)) .^ (1/3);                                         % cm, structural length
  pACSJGRD = p_ref * scaled_power(L, f, pars_pow, l_b, l_p);               % J/d, powers
  pADG = pACSJGRD(:, [1 7 5]);                                             % only need these columns
  J_Org = pADG * eta_O';                                                   % organic fluxes
  prdData.JX_T2 = - (w_X/d_X2) * J_Org(:,1).* TC_JX_T2;                    % g/d, ingested food
  
  
  %% Growth at different temperatures
  prdData.tdW_T20   = get_tdW(f_exp, TC_tdW_T20, tdW_T20, 6.66, par, cPar);    % 20.5 C
  prdData.tdW_T24   = get_tdW(f_exp, TC_tdW_T24, tdW_T24, 6.69, par, cPar);    % 24 C
  prdData.tdW_T28   = get_tdW(f_exp, TC_tdW_T28, tdW_T28, 6.60, par, cPar);    % 28 C
  prdData.tdW_T32   = get_tdW(f_exp, TC_tdW_T32, tdW_T32, 6.62, par, cPar);    % 32 C


  
end
  %% subfunctions
function ELw = get_Lw(f, TC, tL,  p, c)                % Function get_Lw that gives output ELw

pars_lb = [c.g; c.k; c.v_Hb];                          % compose parameters
l_b   = get_lb(pars_lb, f);                            % scaled structural length at birth
L_b   = c.L_m * l_b;                                   % cm, structural length at birth (L_b)
Lw_b  = L_b/ p.del_M;                                  % cm, physical length at birth at f

rho_B = 1/ 3/ (1 + f/ c.g);                            % -, scaled functional response    
rT_B  = rho_B * c.k_M * TC;                            % 1/d, temp-corrected von bert growth coeff
L_i   = (f * c.L_m - c.L_T);                           % cm, ultimate structural length at f; L_T heating length = p_T/p_M (p_T set to 0)
% L_i = c.L_m * l_i;                                   % cm, ultimate structural length (L_infinity); why is L_m * l_i same as f * L_m? l_i = f - l_T
Lw_i  = L_i / p.del_M;                                 % cm, ultimate physical length at f

ELw   = Lw_i - (Lw_i - Lw_b) * exp(-rT_B * tL(:,1));   % cm, expected physical length at time

end


% VB growth model when initial age/size is NOT the age/size at birth
 function EW = get_tdW(f, TC, dataset, init_wt, p, c)  % Function get_tdW that gives output EW
L_0   = (init_wt / (1 + f * c.w)) .^ (1/3);            % cm, structural length
% L_0   = init_size * p.del_M;                         % cm, structural length at t = 0; i.e., first row, first col

rho_B = 1/ 3/ (1 + f/ c.g);                            % -, scaled functional response    
rT_B  = rho_B * c.k_M * TC;                            % 1/d, temp-corrected von bert growth coeff
L_i   = f * c.L_m - c.L_T; 
L     = L_i - (L_i - L_0) .* exp(-rT_B * dataset(:,1));% cm, expected structural lengths at time
% EL    = L / p.del_M;                                 % cm, expected total length at time
EW    = L.^3 * (1 + f * c.w);                          % g, expected wet weight at time
 end