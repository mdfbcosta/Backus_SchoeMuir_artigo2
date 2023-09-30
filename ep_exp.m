function [e_sf,e_cf] = ep_exp (in,vpz_sf,vpx_sf,vpz_cf,vpx_cf)

% Calcula o parâmetros de anisotropia experimental - epsilon

for i = 1:numel(in)
    vz_sf(i,1) = vpz_sf(in(i));
    vz_cf(i,1) = vpz_cf(in(i));
end

e_sf = (vpx_sf.^2 - vz_sf.^2)./(2*vz_sf.^2);
e_cf = (vpx_cf.^2 - vz_cf.^2)./(2*vz_cf.^2);
%e_sf = (vpx_sf - vz_sf)./vz_sf;
%e_cf = (vpx_cf - vz_cf)./vz_cf;
