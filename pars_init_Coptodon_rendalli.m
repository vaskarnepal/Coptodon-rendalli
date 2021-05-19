function [par, metaPar, txtPar] = pars_init_Coptodon_rendalli(metaData)

metaPar.model = 'std'; 

% reference parameter (not to be changed)
par.T_ref = C2K(20);  free.T_ref = 0;   units.T_ref = 'K';        label.T_ref = 'Reference temperature';

%% Arrhenius parameters
par.T_A = 8332.65;   free.T_A   = 0;   units.T_A = 'K';          label.T_A = 'Arrhenius temperature'; 
par.T_AH = 100000;    free.T_AH  = 1;   units.T_AH = 'K';         label.T_AH = 'Arrhenius temperature'; 
par.T_AL = 30000;     free.T_AL  = 1;   units.T_AL = 'K';         label.T_AL = 'Arrhenius temperature'; 
par.T_H = 307.5;   free.T_H   = 1;   units.T_H = 'K';          label.T_H = 'Arrhenius temperature'; 
par.T_L = 273;     free.T_L   = 1;   units.T_L = 'K';          label.T_L = 'Arrhenius temperature'; 

%% core primary parameters
par.z     = 10.79;        free.z     = 1;   units.z     = '-';        label.z     = 'zoom factor';
par.F_m   = 6.5;      free.F_m   = 0;   units.F_m   = 'l/d.cm^2'; label.F_m   = '{F_m}, max spec searching rate';
par.kap_X = 0.6;      free.kap_X = 0;   units.kap_X = '-';        label.kap_X = 'digestion efficiency of food to reserve';
par.kap_P = 0.1;      free.kap_P = 0;   units.kap_P = '-';        label.kap_P = 'faecation efficiency of food to faeces';
par.v     = 0.07884;     free.v     = 1;   units.v     = 'cm/d';     label.v     = 'energy conductance';
par.kap   = 0.3784;      free.kap   = 1;   units.kap   = '-';        label.kap   = 'allocation fraction to soma';
par.kap_R = 0.95;     free.kap_R = 0;   units.kap_R = '-';        label.kap_R = 'reproduction efficiency';
par.p_M   = 13;       free.p_M   = 1;   units.p_M   = 'J/d.cm^3'; label.p_M   = '[p_M], vol-spec somatic maint';
par.p_T   = 0;        free.p_T   = 0;   units.p_T   = 'J/d.cm^2'; label.p_T   = '{p_T}, surf-spec somatic maint';
par.k_J   = 0.002;    free.k_J   = 0;   units.k_J   = '1/d';      label.k_J   = 'maturity maint rate coefficient';
par.E_G   = 5250;     free.E_G   = 1;   units.E_G   = 'J/cm^3';   label.E_G   = '[E_G], spec cost for structure';
par.E_Hb  = 70.71; free.E_Hb = 1;    units.E_Hb  = 'J';        label.E_Hb  = 'maturity at birth';
par.E_Hp  = 1.79e6;  free.E_Hp = 1;    units.E_Hp  = 'J';        label.E_Hp  = 'maturity at puberty';
par.h_a   = 5.035e-10;free.h_a = 1;     units.h_a   = '1/d^2';    label.h_a   = 'Weibull aging acceleration';
par.s_G   = 1e-4;     free.s_G   = 0;   units.s_G   = '-';        label.s_G   = 'Gompertz stress coefficient';

%% auxiliary parameters
par.del_M = 0.3152;     free.del_M = 1;   units.del_M = '-';        label.del_M = 'shape coefficient for larvae, juveniles and adults';
par.del_Y = 1.973;     free.del_Y = 1;   units.del_Y = '-';        label.del_Y = 'shape coefficient for egg';
par.E_Hh  = 11.3; free.E_Hh = 1;    units.E_Hh  = 'J';        label.E_Hh  = 'maturity at hatch';

%% environmental parameters (temperatures are in auxData)
par.f     = 1.0;      free.f     = 0;   units.f = '-';            label.f     = 'scaled functional response for 0-var data';
par.f_tL  = 0.8408;      free.f_tL  = 1;   units.f_tL = '-';         label.f_tL  = 'scaled functional response for WeylHech1998';
par.f_ChanDeSi1981 = 0.701;    free.f_ChanDeSi1981 = 1;   units.f_ChanDeSi1981 = '-';        label.f_ChanDeSi1981 = 'scaled functional response for ChanDeSi1981';
par.f_LW0 = 0.2894;    free.f_LW0 = 1;   units.f_LW0 = '-';        label.f_LW0 = 'scaled functional response for Hlop2011 wild fish';

%% set chemical parameters from Kooy2010 
[par, units, label, free] = addchem(par, units, label, free, metaData.phylum, metaData.class);

%% Pack output:
txtPar.units = units; txtPar.label = label; par.free = free; 
