%Levent Batakci - LAB192@case.edu
%MATH444 HW#1
%Biopsy Data portion

%Clear memory
clc
clear all

%Load the biopsy data
%The data is stored in 9x699 a matrix X
%The entries are all of type 'double' and are between 1 & 10
%If an entry is missing, it will be NaN
load BiopsyData

%Remove columns with missing data
X(:, any(isnan(X))) = [];

n = size(X,1); %Number of attributes
p = size(X,2); %Number of data points

%Center the data and compute the SVD
xc = sum(X,2) / p;
Xc = X - xc * ones(1, p);
[U,S,V] = svd(Xc, 'eco');

%Plot the singular values
singular_values = diag(S); %Extract the singular values
figure(1);
plot(1:n, singular_values, 'k.','MarkerSize', 30, 'Color', 'b')

%Set up the x-axis
xlbl = append("\fontsize{25}1", "\leq j \leq", string(size(Xc,1)));
xlabel(xlbl, 'interpreter','tex');
xticks(1:size(Xc,1));

%Set up the y-axis
ylbl = "\fontsize{25}Singular Value   \sigma_j";%Label y
ylabel(ylbl, 'interpreter','tex');

set(gca,'FontSize', 25)
%%%%

%Compute the principal components
Z = U' * Xc;

%Look at the principal components in pairs
figure(2);
c = size(Z,1); %Number of components
sbplt_index=1;
for i = 1:1
   for j= i+1:n 
       subplot(3, 3, sbplt_index)
       sbplt_index = sbplt_index + 1;
       plot(Z(i,:),Z(j,:),'k.','MarkerSize',8)
       axis('equal')
       set(gca,'FontSize',25)
       
       xlabel(append("PC ", string(i)))
       ylabel(append("PC ", string(j)))
   end
end

%Look at the 3D Scatterplot
s = 15; %Marker size
subplot(3, 3, 9)
scatter3(Z(1,:), Z(2,:), Z(3,:), s, 'o', 'MarkerEdgeColor','k', 'MarkerFaceColor','b')
xlabel("PC 1")
ylabel("PC 2")
zlabel("PC 3")
set(gca, 'FontSize', 25)
title("First 3 PC's 3D-Scatterplot", 'FontSize', 25)

sgtitle("Figure 2: Centered Data Principal Components (PC) Compared");

%PLOT JUST FIRST PC
figure(3)
scatter(Z(1,:), zeros(size(Z(1,:))),500,'filled')
ylim(gca, [-0.02 0.02])
xlabel("PC 1")
alpha(0.2)
set(gca, 'FontSize', 30)

