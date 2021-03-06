% Equation 26 of Bortfeld paper
% toggle_approx=1 -> uses dosehat for z<R0-10sigma

function D_z=dose(phi0,beta,alpha,gamma,E0,p,d,rho,epsilon,E_sigma,toggle_approx)
    steps=length(d);
    D_z=zeros(1,steps);
    R0=range(alpha,E0,p);
    sigma=0.012*(R0^0.935);
    sigma=sigma^2 + E_sigma^2*alpha^2*p^2*E0^(2*p-2);
    sigma=sigma^0.5;
    z=zetafunc(R0,d,sigma);
    for i=1:steps
        D_z(i) = phi0*exp(-(z(i)^2)/4)*(sigma^(1/p))*double(feval(symengine,'gamma',(1/p)))*...
                ((sqrt(2*pi)*rho*p*alpha^(1/p)*(1+beta*R0))^-1)*((1/sigma)*parafunc(-1/p,-z(i))+...
                (gamma*beta+beta/p+epsilon/R0)*parafunc(-1/p-1,-z(i)));
        if (isnan(D_z(i)) || D_z(i)==inf)
            if toggle_approx==1
                D_z(i)=dosehat(phi0,beta,alpha,gamma,E0,p,d(i),rho, epsilon);
            end
        end
    end
end