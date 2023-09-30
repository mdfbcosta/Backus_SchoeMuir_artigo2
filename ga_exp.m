function [g_sf,g_cf] = ga_exp (vsh_sf,vsv_sf,vsh_cf,vsv_cf)

g_sf = (vsh_sf.^2 - vsv_sf.^2)./(2*vsv_sf.^2);
g_cf = (vsh_cf.^2 - vsv_cf.^2)./(2*vsv_cf.^2);