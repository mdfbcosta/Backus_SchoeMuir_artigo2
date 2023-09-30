function [d_cf] = de_exp (in,ro_cf,v45_cf,vsv_cf,vpz_cf,vpx_cf)

% Calcula o parâmetro de anisotropia experimental - delta

for i = 1:numel(in)
    r_cf(i,1)  = ro_cf(in(i));
    vp_cf(i,1) = vpz_cf(in(i));
    vs_cf(i,1) = vsv_cf(in(i));
end

C11 = r_cf.*vpx_cf.^2;
C33 = r_cf.*vp_cf.^2;
C44 = r_cf.*vs_cf.^2;

aux = ( ( 4*r_cf.*v45_cf.^2 -C11-C33-2*C44 ).^2 - (C11 - C33).^2 )/4;
C13 = sqrt(aux) - C44;

d_cf = ( (C13 + C44).^2 - (C33 - C44).^2 )./( 2*C33.*(C33 - C44) );
