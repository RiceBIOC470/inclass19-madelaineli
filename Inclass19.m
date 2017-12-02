%In class 19
%GB comments
1A 100
1B 100
1C 100
2. 100
Overall 100


clear all

% Problem 1. Imagine a clincal trial for two drugs that are intended to lower
% cholesterol. Assume 30 subjects are randomly divided into 3 groups that
% either receive a placebo or one of the two treatments. The mean initials
% levels of total cholesterol in each group are the same. The final
% measurements look like

placebo = [   194   183   199   189   189   214   212   186   191   190];
treatment1 = [    138   217   188   126   249   217   255   196   279   123];
treatment2 =[   152   152   151   143   161   142   142   141   161   135];

%A. Make a bar plot of the means of each group with errorbars (Hint, use
%bar and then use 'hold on' and then errorbar). 
placebo_bar = mean(placebo);
p_std = std(placebo);
t1_bar = mean(treatment1);
t1_std = std(treatment1);
t2_bar = mean(treatment2);
t2_std = std(treatment2);
y = horzcat(placebo_bar,t1_bar,t2_bar);
err = [p_std,t1_std,t2_std];
figure(1)
bar(y)
hold on
errorbar(y,err,'o','Capsize',50)
%B. Run a one way ANOVA analysis to see whether any of the treatment groups showed
%a statistically signficant difference. 
y = [placebo, treatment1, treatment2];
for ii = 0:2
    for i = 1:10
        if ii == 0
            group{ii*10+i} = 'placebo';
        elseif ii == 1
            group{ii*10+i} = 'treatment 1';
        else
            group{ii*10+i} = 'treatment 2';
        end
    end
end
[p,tbl,stats] = anova1(y,group)
% according to anova test, there is statistically significant difference
% between the groups

%C. use the multcompare function to look at all pairs of samples and
%indicate which are significantly different. 
compare_tbl = multcompare(stats)
%statistically significantly different groups:
% treatment 2 & treatment 1, treatment 2 & placebo 

%Problem 2. In this directory, you will find a data.mat file with three
%variables, xdat, ydat, and ydat2. For each pair (xdat, ydat) and (xdat,
%ydat2), fit the data to a first, second and third order polynomial. Which
%one is the best fit in each case? In at least one of the cases, do the
%problem with both the polyfit/polyval functions and with the 'fit' function.

file = load('data.mat');
xdat = file.xdat;
ydat = file.ydat;
ydat2 = file.ydat2;
%for ydat
f1_1st = fit(xdat', ydat', 'poly1');
f1_2nd = fit(xdat', ydat', 'poly2');
f1_3rd = fit(xdat', ydat', 'poly3');
figure(4)
plot(xdat',ydat','o','MarkerSize',10)
hold on
plot(f1_1st,'b')
plot(f1_2nd,'g')
plot(f1_3rd,'r')
legend('data','order 1','order 2','order 3')
% the three polynomials fit equally well for ydat

%with polyfit
f1_1st_poly = polyfit(xdat',ydat',1);
f1_2nd_poly = polyfit(xdat',ydat',2);
f1_3rd_poly = polyfit(xdat',ydat',3);
figure(5)
plot(xdat',ydat','o','MarkerSize',10)
hold on
plot(polyval(f1_1st_poly,xdat'),'b')
plot(polyval(f1_2nd_poly,xdat'),'g')
plot(polyval(f1_3rd_poly,xdat'),'r')
title('polyfit with 3 fitting lines')
legend('data','order 1','order 2','order 3')

%for ydat2
f2_1st = fit(xdat',ydat2','poly1');
f2_2nd = fit(xdat',ydat2','poly2');
f2_3rd = fit(xdat',ydat2','poly3');
figure(6)
plot(xdat',ydat2','o','MarkerSize',10)
hold on
plot(f2_1st,'b')
plot(f2_2nd,'g')
plot(f2_3rd,'r')
legend('data','order 1','order 2','order 3')
% third order polynomial fits the best by passing thru the most points for
% ydat2
