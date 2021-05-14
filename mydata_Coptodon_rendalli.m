function [data, auxData, metaData, txtData, weights] = mydata_Coptodon_rendalli 

%% set metaData
metaData.phylum     = 'Chordata'; 
metaData.class      = 'Actinopterygii'; 
metaData.order      = 'Cichliformes'; 
metaData.family     = 'Cichlidae';
metaData.species    = 'Coptodon_rendalli'; 
metaData.species_en = 'Redbreast tilapia'; 
metaData.ecoCode.climate = {''};
metaData.ecoCode.ecozone = {''};
metaData.ecoCode.habitat = {''};
metaData.ecoCode.embryo  = {''};
metaData.ecoCode.migrate = {''};
metaData.ecoCode.food    = {''};
metaData.ecoCode.gender  = {''};
metaData.ecoCode.reprod  = {''};
metaData.T_typical  = C2K(28); % K, body temp
metaData.data_0     = {}; 
metaData.data_1     = {}; 

metaData.COMPLETE = 2.5; % using criteria of LikaKear2011

metaData.author   = {'Vaskar Nepal'};    
metaData.date_subm = [];              
metaData.email    = {'vaskarnepal@gmail.com'};            
metaData.address  = {'Virginia Institute of Marine Science'};   

metaData.curator     = {''};
metaData.email_cur   = {''}; 
metaData.date_acc    = []; 

%% set data
% zero-variate data

data.ah = 2; units.ah = 'd'; label.ah = 'age at hatch'; bibkey.ah = 'PhilRuwe1982'; temp.ah = C2K(26.5); units.temp.ah = 'K'; label.temp.ah = 'temperature';
data.ab = 6; units.ab = 'd'; label.ab = 'age at birth; age at swimup'; bibkey.ab = 'PhilRuwe1982'; temp.ab = temp.ah;  units.temp.ab = 'K'; label.temp.ab = 'temperature';
data.tp = 365 * 2; units.tp = 'd'; label.tp = 'time since birth at puberty'; bibkey.tp = ''; temp.tp = C2K(25.8);  units.temp.tp = 'K'; label.temp.tp = 'temperature'; comment.tj = 'Second year';
data.am = 16 * 365; units.am = 'd'; label.am = 'life span'; bibkey.am = 'WeylHech1998'; temp.am = temp.tp;  units.temp.am = 'K'; label.temp.am = 'temperature'; 

data.L0  = 0.163; units.L0  = 'cm';  label.L0  = 'egg diameter'; bibkey.L0  = 'ChanDeSi1982'; comment.L0 = 'Range 1.3-1.8 cm';
data.Lh  = 0.39; units.Lh  = 'cm';  label.Lh  = 'standard (?) length at hatch';    bibkey.Lh  = 'PhilRuwe1982';  
data.Lb  = 0.6; units.Lb  = 'cm';  label.Lb  = 'standard (?) length at birth';   bibkey.Lb  = 'PhilRuwe1982';
% data.Lj  = ;   units.Lj  = 'cm';  label.Lj  = 'total length at metam';   bibkey.Lj  = '';
data.Lp  = 15.5;   units.Lp  = 'cm';  label.Lp  = 'total length at puberty'; bibkey.Lp  = 'ChanDeSi1981'; comment.Lp = 'Size of the smallest mature fish; a lot of variability (12-22 cm) based on density and temperature';
data.Li  = 40;   units.Li  = 'cm';  label.Li  = 'ultimate total length';   bibkey.Li  = 'Skel1993';

%data.Wwb = ;   units.Wwb = 'g';   label.Wwb = 'wet weight at birth';     bibkey.Wwb = '';
%data.Wwj = ;   units.Wwj = 'g';   label.Wwj = 'wet weight at metam';   bibkey.Wwj = '';
%data.Wwp = ;   units.Wwp = 'g';   label.Wwp = 'wet weight at puberty';   bibkey.Wwp = '';
data.Wwi = 2500;   units.Wwi = 'g';   label.Wwi = 'ultimate wet weight';     bibkey.Wwi = 'Fishbase';

data.Ri  = 34000/365*4;   units.Ri  = '#/d'; label.Ri  = 'maximum reprod rate';     bibkey.Ri  = 'ChanDeSi1981'; temp.Ri = C2K(29.8);  units.temp.Ri = 'K'; label.temp.Ri = 'temperature'; comment.Ri = 'Estimated for a 2kg fish using Weight-Fecundity regn from ChanDesi1981; 4 batches/y estimated';
 
% uni-variate data
% Length-wet weight adults from Hlophe 2011 thesis
data.LWw = [ ...
    2.1     2.9     3.4     3.5     3.6     4.0     4.0     4.1     4.2     4.3     4.3	4.5	4.5	4.8	4.8	5.0	5.0	5.5	5.5	5.5	5.8	6.0	6.0	6.0	6.0	6.3	6.4	6.5	6.5	6.5	6.5	6.6	6.7	6.8	6.8	6.8	7.0	7.0	7.0	7.2	7.2	7.3	7.4	7.5	7.5	7.5	7.6	7.6	7.8	7.9	7.9	8.0	8.0	8.0	8.0	8.0	8.0	8.2	8.2	8.2	8.4	8.5	8.5	8.5	8.5	8.5	8.6	8.6	8.8	8.9	8.9	9.0	9.0	9.0	9.0	9.0	9.0	9.2	9.3	9.4	9.5	9.5	9.5	9.5	9.5	9.5	9.5	9.5	10.0	10.0	10.0	10.0	10.0	10.0	10.3	10.4	10.5	10.5	10.5	10.5	10.8	10.8	10.9	11.0	11.0	11.0	11.0	11.1	11.4	11.5	11.5	11.5	11.5	12.0	12.0	12.0	12.0	12.2	12.5	12.5	13.0	14.0	14.0	15.0	15.0	15.5	15.9	16.0	16.0	16.0	16.0	16.0	16.5	17.0	18.0	18.0	20.0	21.5	21.5	22.0	26.0; % total length cm
0.32	0.84	1.35	1.49	1.63	2.21	2.21	2.40	2.58	2.76	2.76	3.16	3.19	3.86	3.86	4.36	4.39	5.80	5.80	5.86	6.82	7.56	7.56	7.56	7.56	8.74	9.21	9.65	9.65	9.65	9.65	10.07	10.54	10.98	11.07	11.08	12.05	12.05	12.05	13.13	13.13	13.64	14.22	14.82	14.87	14.87	15.43	15.49	16.70	17.31	17.31	24.62	22.10	18.31	16.21	16.21	20.42	20.84	20.00	15.79	21.27	28.42	25.90	24.21	21.69	20.01	12.02	27.16	24.22	22.96	26.75	22.12	3.19	30.12	28.01	26.33	20.86	30.54	26.34	29.70	38.54	36.44	33.07	29.29	28.02	24.66	9.10	6.99	52.01	38.97	36.87	35.61	32.24	30.14	31.83	36.88	49.92	43.61	38.15	36.04	42.78	50.77	55.40	54.56	45.31	50.36	44.05	62.56	58.78	60.04	54.58	49.95	45.74	79.41	69.73	59.22	71.84	73.94	86.15	79.84	83.22	115.21	99.65	156.88	145.10	158.16	131.25	191.40	149.34	159.85	147.65	145.55	169.96	226.34	270.54	203.65	334.11	400.19	381.26	445.63	730.51]'; % Wet weight g
units.LWw = {'cm', 'g'};   label.LWw = {'total length', 'wet weight'};  bibkey.LWw = 'Hlop2011';
comment.LWw = 'Figure 3.13; 2 extremely unlikely data points removed';

% t-L data
data.tL = [ ...
    0	0	0	0	1	0	0	1	0	0	1	3	0	1	5	0	1	0	1	1	3	5	1	2	3	4	5	0	1	3	4	5	6	0	2	3	4	5	0	1	2	3	4	5	6	7	8	9	11	1	2	3	4	5	6	7	8	9	11	12	16	2	3	4	5	6	7	8	10	14	15	3	4	6	7	8	9	10	12	2	3	4	5	6	7	13	3	5	6	7	10	5	11	5	9	12	7; % time since birth (y)
    35	75	85	95	95	105	115	115	125	135	135	135	145	145	145	155	155	165	165	175	175	175	185	185	185	185	185	195	195	195	195	195	195	205	205	205	205	205	215	215	215	215	215	215	215	215	215	215	215	225	225	225	225	225	225	225	225	225	225	225	225	235	235	235	235	235	235	235	235	235	235	245	245	245	245	245	245	245	245	255	255	255	255	255	255	255	265	265	265	265	265	275	275	285	285	285	305; % Total length (mm) 
    1	14	14	21	1	29	22	2	11	4	1	1	1	2	1	5	8	4	2	2	1	1	3	1	1	1	1	1	2	5	4	1	1	1	4	4	3	1	1	1	5	5	2	5	1	1	1	2	1	1	2	4	2	6	5	1	2	1	4	2	1	3	4	2	5	1	3	1	1	1	1	1	3	6	1	1	1	2	1	1	1	1	2	1	3	1	1	2	2	2	1	1	1	1	1	1	1]'; % Frequency 
data.tL(:,1) = data.tL(:,1)*365;    % convert y to d
data.tL(:,2) = data.tL(:,2)/10;     % convert mm to cm
data.tL = [repelem(data.tL(:,1), data.tL(:,3)) repelem(data.tL(:,2), data.tL(:,3))]; % Change from frequency table to simple long matrix
units.tL   = {'d', 'cm'};  label.tL = {'time since birth', 'total length'};  
temp.tL    = temp.tp;  units.temp.tL = 'K'; label.temp.tL = 'temperature';
bibkey.tL = 'WeylHech1998';
 

% t-SL for larvae
data.tL0 = [ ...
    7       11	15      29;             % d after hatch;
    7.15	8.2	8.05	12.1]';         % Standard length (mm); also 6.1 mm at 3 dah
data.tL0(:,1) = data.tL0(:,1) - 4;      % convert to days after BIRTH
data.tL0(:,2) = data.tL0(:,2)/10;       % convert mm to cm
units.tL0   = {'d', 'cm'};  label.tL0 = {'time since hatch', 'total length'};  
temp.tL0    = C2K(23);  units.temp.tL0 = 'K'; label.temp.tL0 = 'temperature';
bibkey.tL0 = 'MoriMats2007';

% % Wet-weight - fecundity
data.WwR = [...
    126	200     250     300     350     380;                            % Wet weight g
    760	2601	3113	3624	4136	6160]';                         % Fecundity (# of eggs per year)
data.WwR(:,2) = data.WwR(:,2)*4;       % 4 batches/y estimated (literature says 3-6)
units.WwR = {'g', '#'}; label.WwR =  {'Wet weight', 'fecundity'};  
temp.WwR = C2K(29.8);  units.temp.WwR = 'K'; label.temp.WwR = 'temperature'; 
bibkey.WwR = 'ChanDesi1981'; comment.WwR = 'Table 1 and text';

% % respiration in mg O2/g/d, temp in C (Caulton 1977) % See Argyrosomus_regius example
% % fish wet weight: 50 g; used as the fixed parameter Ww_0 in the pars_init file
% data.T_JO = [   17      23	28      33      37      38.5	40;         % Temperature C
%                 2.35	3.5	5.82	6.58	7.83	9.34	13.6]';     % mg O2/g/d; same as g O2/kg/d
% units.T_JO = {'C', 'g/d/kg'};  label.T_JO = {'temperature', 'O2 consumption'}; 
% auxData.weight.T_JO =  50; units.weight.T_JO = {'g'}; label.weight.T_JO = {'wet weight'};
% bibkey.T_JO = 'Caul1977';
% 
% Consumption rates 
% Group consumption on duckweed Hlophe 2011
data.JX_T1 = [  14.5	16.0	18.0	22.0	23.0	26.0	27.0;   % Temp C
                102.0	135.2	99.0	170.8	182.0	216.5	269.3]';% Consumption rate g/d
data.JX_T1 =[11	0.05*max(data.JX_T1(:,2));                              % Add pseudodata; minimum
            data.JX_T1;
            37.5	0.05*max(data.JX_T1(:,2))];                         % Add pseudodata; maximum
data.JX_T1(:,2) = data.JX_T1(:,2)/1800*65;                              % convert from a group of fish with weight ~1800 g, each fish about 65g
units.JX_T1   = {'C', 'g/d'};  label.JX_T1 = {'Temperature','feed intake'};  
auxData.weight.JX_T1 =  65; units.weight.JX_T1 = {'g'};  label.weight.JX_T1 = {'wet weight'};  
bibkey.JX_T1  = 'Hlop1981';

% Individual consumption Caulton 1982
data.JX_T2 = [  18      22      26      30      34;                     % Temp C
                2.12	3.26	5.76	6.64	6.62]';                 % Consumption rate g/d
data.JX_T2 =[11	0.05*max(data.JX_T2(:,2));                              % Add pseudodata; minimum
            data.JX_T2;
            37.5	0.05*max(data.JX_T2(:,2))];                         % Add pseudodata
units.JX_T2   = {'C', 'g/d'};  label.JX_T2 = {'Temperature','feed intake'};  
auxData.weight.JX_T2 =  50; units.weight.JX_T2 = {'g'};  label.weight.JX_T2 = {'wet weight'};  
bibkey.JX_T2  = 'Caul1982';
% 
% 
% % NH4 excretion rates Caulton 1982
% % data.TJN = [	18      22      26      30      34; % Temp C
% %             	0.023	0.026	0.027	0.028	0.028]';% Excretion rate (J/J prey consumed)
% % units.TJN   = {'C', 'J/J prey consumed'};  label.TJN = {'Temperature', 'NH4 excretion'};  
% % auxData.weight.TJN =  50; units.weight.TJN = {'g'};  label.weight.TJN = {'wet weight'};  
% % bibkey.TJN  = 'Caul1982';
% 
% 
% Growth at different temperatures; Kang'ombe 2004 thesis
% Temperature 20.5C (i.e., ambient)
data.tdW_T20  = [  0    2       4	6       8       10;
                   6.66 6.62	7.3	8.53	8.69	8.65]';
data.tdW_T20(:,1) = data.tdW_T20(:,1)*7; % convert weeks to d
units.tdW_T20  = {'d', 'g'};  label.tdW_T20 = {'time since start', 'wet weight'};
temp.tdW_T20 = C2K(20.5);  units.temp.tdW_T20 = 'K'; label.temp.tdW_T20 = 'temperature'; 
bibkey.tdW_T20 = 'Kang2004';

% Temperature 24C
data.tdW_T24  = [  0	2       4	6       8       10;
                   6.69	7.42	8.3	9.65	9.96	10.7]';
data.tdW_T24(:,1) = data.tdW_T24(:,1)*7; % convert weeks to d
units.tdW_T24  = {'d', 'g'};  label.tdW_T24 = {'time since start', 'wet weight'};
temp.tdW_T24 = C2K(24);  units.temp.tdW_T24 = 'K'; label.temp.tdW_T24 = 'temperature'; 
bibkey.tdW_T24 = 'Kang2004';

% Temperature 28C
data.tdW_T28  = [  0	2       4       6       8       10;
                   6.6	7.8     8.96	10.54	11.12	13.49]';
data.tdW_T28(:,1) = data.tdW_T28(:,1)*7; % convert weeks to d
units.tdW_T28  = {'d', 'g'};  label.tdW_T28 = {'time since start', 'wet weight'};
temp.tdW_T28 = C2K(28);  units.temp.tdW_T28 = 'K'; label.temp.tdW_T28 = 'temperature'; 
bibkey.tdW_T28 = 'Kang2004';

% Temperature 32C
data.tdW_T32  = [  0	2       4       6       8       10;
                   6.62	7.91	9.12	10.72	12.26	17.37]';
data.tdW_T32(:,1) = data.tdW_T32(:,1)*7; % convert weeks to d
units.tdW_T32  = {'d', 'g'};  label.tdW_T32 = {'time since start', 'wet weight'};
temp.tdW_T32 = C2K(32);  units.temp.tdW_T32 = 'K'; label.temp.tdW_T32 = 'temperature'; 
bibkey.tdW_T32 = 'Kang2004';


%% set weights for all real data
weights = setweights(data, []);
weights.JX_T1(1) = 0.1* weights.JX_T1(1); % treat the first value as pseudo data
weights.JX_T1(9) = 0.1* weights.JX_T1(9); % treat the last value as pseudo data
weights.JX_T2(1) = 0.1* weights.JX_T2(1); % treat the first value as pseudo data
weights.JX_T2(7) = 0.1* weights.JX_T2(7); % treat the last value as pseudo data

%% set pseudodata and respective weights
[data, units, label, weights] = addpseudodata(data, units, label, weights);

%% pack auxData and txtData for output
auxData.temp = temp;
txtData.units = units;
txtData.label = label;
txtData.bibkey = bibkey;
txtData.comment = comment;

%% Group plots
set1 = {'JX_T1','JX_T2'}; comment1 = {'Consumption'};
set2 = {'tdW_T20', 'tdW_T24', 'tdW_T28', 'tdW_T32'}; comment2 = {'Growth at different temperatures'};
metaData.grp.sets = {set1, set2};
metaData.grp.comment = {comment1, comment2};

%% Discussion points
D1 = 'Stunted growth and precocial puberty are common phenomena (and problems in aquaculture)';
D2 = '';     
metaData.discussion = struct('D1', D1, 'D2', D2);

%% Facts
F1 = 'Communal care of the young by guarding nests';
metaData.bibkey.F1 = 'Ribb1981'; 
metaData.facts = struct('F1',F1);

%% Acknowledgment
metaData.acknowledgment = '';

%% Links
metaData.links.id_CoL = 'Y7M2'; % Cat of Life
metaData.links.id_EoL = '52229157'; % Ency of Life
metaData.links.id_Wiki = 'Redbreast_tilapia'; % Wikipedia
metaData.links.id_ADW = 'Tilapia_rendalli'; % ADW
metaData.links.id_Taxo = ''; % Taxonomicon
metaData.links.id_AnAge = 'Tilapia_rendalli'; % Animal Ageing and Longeivity Database
metaData.links.id_fishbase = 'Coptodon-rendalli.html'; % Fishbase

%% References
bibkey = 'Wiki'; type = 'Misc'; bib = ...
'howpublished = {\url{http://en.wikipedia.org/wiki/my_pet}}';
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Kooy2010'; type = 'Book'; bib = [ ...  % used in setting of chemical parameters and pseudodata
'author = {Kooijman, S.A.L.M.}, ' ...
'year = {2010}, ' ...
'title  = {Dynamic Energy Budget theory for metabolic organisation}, ' ...
'publisher = {Cambridge Univ. Press, Cambridge}, ' ...
'pages = {Table 4.2 (page 150), 8.1 (page 300)}, ' ...
'howpublished = {\url{http://www.bio.vu.nl/thb/research/bib/Kooy2010.html}}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'WeylHech1998'; type = 'Article'; bib = [ ... 
'author = {Weyl, Olaf L. F. and Hecht, T.}, ' ... 
'year = {1998}, ' ...
'title = {The biology of Tilapia rendalli and Oreochromis mossambicus (Pisces: Cichlidae)in a subtropical lake in Mozambique}, ' ...
'journal = {South African Journal of Zoology}, ' ...
'volume = {33}, ' ...
'number = {3}, '...
'pages = {178-188}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

