%%%%%%%%%%%% load observation data from file

pde_name = pde_names{pde_num};
load([data_dr,pde_name],'U_exact','xs','lhs','true_nz_weights');
if ~exist('true_nz_weights','var')
    true_nz_weights=[];
end
U_obs = U_exact;
xs_obs = xs;

%%%%%%%%%%%% coarsen data: rewrites coarsened versions to U_obs, xs_obs

[U_obs,xs_obs] = coarsen_data(U_obs, coarse_data_pattern, xs_obs);

%%%%%%%%%%%% add noise

rng_seed = rng().Seed; rng(rng_seed);
[U_obs,noise,snr,sigma] = gen_noise(U_obs,sigma_NR,noise_dist,noise_alg,...
    rng_seed,0);