%test plot of e^-(th/b)^2
t=-10:0.1:10;
f=exp(-t.*t);
f2=2.^(-t.*t);
plot(t,f,t,f2);

legend ('e^-(t^2)' ,'2^-(t^2)');