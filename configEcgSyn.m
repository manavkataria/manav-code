function configEcgSyn(lead)
% Configures: Model Parameters thetai, widthi, heighti according to LEAD
% configuration

global thetai
global heighti  % Z position of each attractor 
global widthi   % Guassian Width of each attractor

if (lead==1)
    display 'Configuring lead 1 - Normal (lesson3:ecg_normal.gif)';
    thetai    = [-pi/3       -pi/12    0       pi/12        pi/2 ]; 
    heighti   = [  2.4*.8    -22*.9    90*.9   -30*.9     1.5*.85];
    widthi    = [ 0.25*.8    0.1*.9   0.1*.7   0.1*.9    0.40*.95];
elseif (lead==2)
    display 'Configuring lead 2 - Normal (lesson3:ecg_normal.gif)';
    thetai    = [-pi/3  -pi/12    0    pi/12  pi/2]; 
    heighti   = [  2.4    -22    90   -30     1.5];
    widthi    = [ 0.25    0.1    0.1   0.1    0.40];  
elseif (lead==21)
    display 'Configuring lead 1';
    thetai    = [-pi/3  -pi/12    0    pi/12  pi/2]; 
    heighti   = [1.2      -5      30   -7.5   0.75];
    widthi    = [ 0.25   0.1    0.1   0.1   0.40];
elseif (lead==22)
    display 'Configuring lead 2';
    thetai    = [-pi/3  -pi/12    0    pi/12  pi/2]; 
    heighti   = [  2.4    -22    90   -30     1.5];
    widthi    = [ 0.25   0.1    0.1   0.1   0.40];  
else
    error 'LEAD Variable Assignment Error!';
end

end