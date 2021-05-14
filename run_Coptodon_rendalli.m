close all; 
global pets

pets = {'Coptodon_rendalli'};
check_my_pet(pets); 

estim_options('default'); 
estim_options('max_step_number',5e2); 
estim_options('max_fun_evals',5e3);  

estim_options('pars_init_method', 1);
estim_options('results_output', 2);
estim_options('method', 'nm');

for ijk = 1:5
    estim_pars; 
end
