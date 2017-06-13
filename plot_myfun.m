% plots myfun(x,c) for x in [0..1] and c = 2

clf; % clears figure
x = 0:0.01:1;
c = 0.5:0.5:2;

figure

for i= 1:4   
    hold on
plot(myfun(x,c(i)))% adjust this line!
end
hold off
title(['myfun(x,c); c=' num2str(c)]);
xlabel('x');
ylabel('myfun(x)');