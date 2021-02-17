%Levent Batakci - LAB192@case.edu
%MATH444 HW#1
%Iris Data portion

%Clear memory
clc
clear all

%Load the iris data
%The data is stored in 4x450 a matrix X
%The entries are lengths measured in centimeters
%In order, the entries are 'sepal length', 'sepal width', 'petal length',
%and 'petal width'
load IrisData

%Center the data and compute the SVD
n = size(X,1);
p = size(X,2);
xc = sum(X,2) / p;
Xc = X - xc * ones(1, p);
[U,S,V] = svd(Xc, 'eco');

%Plot the singular values
singular_values = diag(S);
plot(1:n, singular_values);
figure(1);
plot(1:n, singular_values, 'k.','MarkerSize', 20, 'Color', 'b')

%Set up the x-axis
xlbl = append("\fontsize{15}1", "\leq j \leq", string(size(Xc,1)));
xlabel(xlbl, 'interpreter','tex');
xticks(1:size(Xc,1));

%Set up the y-axis
ylbl = "\fontsize{15}Singular Value   \sigma_j";%Label y
ylabel(ylbl, 'interpreter','tex');
sgtitle("Figure 1: Centered Data Singular Values");

%Compute all of the principal components
Z = U' * X;

%Look at the principal components in pairs
figure(2);
c = size(Z,1); %Number of components
sbplt_index=1;
for i = 1:n-1
   for j= i+1:n 
       subplot(2, 3, sbplt_index)
       sbplt_index = sbplt_index + 1;
       plot(Z(i,:),Z(j,:),'k.','MarkerSize',3)
       axis('equal')
       set(gca,'FontSize',15)
       
       xlabel(append("PC ", string(i)))
       ylabel(append("PC ", string(j)))
   end
end
sgtitle("Figure 2: Centered Data Principal Components (PC) Compared");

%Look at a 3D scatter plot of the first 3 PCs
figure(3);
s=30;
scatter3(Z(1,:), Z(2,:), Z(3,:), s, 'o', 'MarkerEdgeColor','k', 'MarkerFaceColor','b')
xlabel("PC 1")
ylabel("PC 2")
zlabel("PC 3")
sgtitle("Figure 3: First 3 Principal Components 3D-Scatterplot")


%Honestly, it looks like there are 2 obvious groupings.
%There might be 3 clusters, but I think that two of the flower types
% are definitely harder to tell apart.