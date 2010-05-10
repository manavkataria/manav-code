function configEcgSyn(lead)
% Configures: Model Parameters thetai, widthi, heighti according to LEAD
% configuration

global thetai
global heighti
global widthi

if (lead==1)
    display 'Configuring lead 1 - Normal (fig8.1)';
    thetai    = [-pi/3  -pi/12    0    pi/12  pi/2]; 
    heighti   = [  2.4    -22    90   -30     1.5];
    widthi    = [ 0.25    0.1    0.1   0.1   0.40];
elseif (lead==2)
    display 'Configuring lead 2 - Normal (fig8.1)';
    thetai    = [-pi/3  -pi/12    0    pi/12  pi/2]; 
    heighti   = [  2.4    -22    190   -30     1.5];
    widthi    = [ 0.25    0.1    0.1   0.1    0.40];  
elseif (lead==21)
    display 'Configuring lead 1';
    thetai    = [-pi/3  -pi/12    0    pi/12  pi/2]; 
    heighti   = [  2.4    -22    90   -30     1.5];
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