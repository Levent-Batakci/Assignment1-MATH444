%Levent Batakci - LAB192@case.edu
%MATH444 HW#1
%Model Reduction Data portion

%Clear memory
clc
clear all

%Load the model reduction data
%The data is stored in 6x4000 a matrix X
%The entries are all of type 'double'
load ModelReductionData


%PART a
%In this part, the data will be visualized by plotting the components
%of the data (one pair at a time) against each other
%Since there are 6 components, there will be (6 choose 2)=15 plots

colors = ["Blue","Green","Red","Purple","Black","Yellow"];
colors = ["Black","Black","Black","Black","Black","Black"];

c = size(X,1); %Number of components
sbplt_index=1;
figure(1);
for i = 1:c
   for j= i+1:c 
       subplot(3, 5, sbplt_index)
       sbplt_index = sbplt_index + 1;
       plot(X(i,:),X(j,:),'k.','MarkerSize',3)
       axis('equal')
       set(gca,'FontSize',10)
       
       xlabel(append("Component ", string(i)))
       ylabel(append("Component ", string(j)))
   end
end
sgtitle("Figure 1: Raw Data Components Compared") %MAKE THIS PLOT PRETTIER !!!!


%PART b
%In this part, I calculate the SVD of the data (after centering it)
%Then, the singular values are plotted to determine the effective
%dimensionality of the data

%Get the average of the data
N = size(X,2);
xc = sum(X, 2)/N; 

%Center the data
Xc = X -  xc*ones(1,N);

[U,S,V] = svd(Xc); %Compute the SVD

%Plot the singular values
singular_values = diag(S); %Extract the singular values
figure(2);
subplot(1, 1, 1); %Make the plot into 1 large one
plot(1:size(Xc,1), singular_values, 'k.','MarkerSize', 20, 'Color', 'b')

%Set up the x-axis
xlbl = append("\fontsize{15}1", "\leq j \leq", string(size(Xc,1)));
xlabel(xlbl, 'interpreter','tex');
xticks(1:size(Xc,1));

%Set up the y-axis
ylbl = "\fontsize{15}Singular Value   \sigma_j";%Label y
ylabel(ylbl, 'interpreter','tex');
sgtitle("Figure 2: Centered Data Singular Values");

%THE RESULTING PLOT MAKES IT CLEAR THAT THE DATA HAS EFFECTIVE
% % % % % 3 DIMENSIONS % % % % %
%From here, it remains to check how many distinct data clumps there are.
%To do this, we will project the data onto u1, u2, and u3 and plot the
%data in 3-space
Uk = U(:, 1:3)';

%Project to get the 3 principal components
X3 = Uk * Xc;

%Look at the principal components in pairs
figure(3);
c = size(X3,1); %Number of components
sbplt_index=1;
for i = 1:c
   for j= i+1:c 
       subplot(2, 2, sbplt_index)
       sbplt_index = sbplt_index + 1;
       plot(X3(i,:),X3(j,:),'k.','MarkerSize',3)
       axis('equal')
       set(gca,'FontSize',15)
       
       
       xlabel(append("PC ", string(i)))
       ylabel(append("PC ", string(j)))
   end
end

%Look at the 3D Scatterplot
s = 15; %Marker size
subplot(2, 2, 4)
scatter3(X3(1,:),X3(2,:),X3(3,:), s, 'o', 'MarkerEdgeColor','k', 'MarkerFaceColor','b')
xlabel("PC 1")
ylabel("PC 2")
zlabel("PC 3")
title("Principal Components 3D-Scatterplot")

sgtitle("Figure 3: Centered Data Principal Components (PC) Compared");

%Looking at the comparisons, there appear to be
% % % % % 2 CLUSTERS % % % % %

