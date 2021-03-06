format compact
a = 0; b = 20;
T = 1;
sigma = 0.20;
E = 10;
r = 0.05;
ns = 599; nt = 599;
type = "call";

values_im = BS_eur_impl_fd(a, b, E, r, sigma, T, type, ns, nt);
values_cn = BS_eur_cn(a, b, E, r, sigma, T, type, ns, nt);
num_tests = {2,4,6,7,8,9,10,11,12,13,14,15,16};

disp("Price(S)  Actual     Crank-N.   Error          Impl. FD   Error");
for i = 1:length(num_tests)
    si = fix(num_tests{i} / (b-a) * (ns+1));
    ti = fix(0.5 / T * (nt+1));

    cn = values_cn((ti-2) * ns + si);
    im = values_im((ti-2) * ns + si);
    actual = BS_eur_actual(num_tests{i}, E, r, sigma, T, 0.5, type);

    fprintf("%4d      %8.6f   %8.6f   %8.6e   %8.6f   %8.6e \n", ...
                num_tests{i}, actual, cn, abs(actual-cn), im, ...
                abs(actual-im));
end