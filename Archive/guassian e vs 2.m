%test plot of e^-(th/b)^2
t=-10:0.1:10;
f=exp(-t);
%f=exp(-t.*t);
% f2=2.^(-t.*t);
% plot(t,f,t,f2);
plot(t,f);
% legend ('e^-(t^2)' ,'2^-(t^2)');

%plot (t, exp(-(t-.3).^2), t, exp(-t.^2), t, exp(t.^2), t, exp(t))

