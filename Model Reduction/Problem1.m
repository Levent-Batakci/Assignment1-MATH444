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
colors = [[0, 0.4470, 0.7410]; [0, 0.5, 0]; [1, 0, 0]; [0.8500, 0.3250, 0.0980]; [0, 0.75, 0.75]; [0.6350, 0.0780, 0.1840]];

c = size(X,1); %Number of components
sbplt_index=1;
figure(1);
for i = 1:c
   for j= i+1:c 
       subplot(3, 5, sbplt_index)
       sbplt_index = sbplt_index + 1;
       plot(X(i,:),X(j,:),'k.','MarkerSize',3)
       axis('equal')
       set(gca,'FontSize',23)
       
       xlabel(append("Component ", string(i)), 'Color', colors(i,:))
       ylabel(append("Component ", string(j)), 'Color', 'k')
   end
end
sgtitle("Figure 1: Raw Data Components Compared", 'FontSize', 30) %MAKE THIS PLOT PRETTIER !!!!


%PART b
%In this part, I calculate the SVD of the data (after centering it)
%Then, the singular values are plotted to determine the effective
%dimensionality of the data

%Center the data
N = size(X,2);
xc = sum(X, 2)/N; %Get the average
Xc = X -  xc*ones(1,N); %Subtract out the average

[U,S,V] = svd(Xc, 'eco'); %Compute the SVD

%Plot the singular values
singular_values = diag(S); %Extract the singular values
figure(2);
subplot(1, 1, 1); %Make the plot into 1 large one
plot(1:size(Xc,1), singular_values, 'k.','MarkerSize', 45, 'Color', 'b')
set(gca,'FontSize',25)

%Set up the x-axis
xlbl = append("\fontsize{25}1", "\leq j \leq", string(size(Xc,1)));
xlabel(xlbl, 'interpreter','tex');
xticks(1:size(Xc,1));

%Set up the y-axis
ylbl = "\fontsize{25}Singular Value   \sigma_j";%Label y
ylabel(ylbl, 'interpreter','tex');
sgtitle("Figure 2: Centered Data Singular Values", 'FontSize', 20);

%THE RESULTING PLOT MAKES IT CLEAR THAT THE DATA HAS EFFECTIVELY
% % % % % 3 DIMENSIONS % % % % %
%From here, it remains to check how many distinct data clumps there are.
%To do this, we will project the data onto u1, u2, and u3 and plot the
%data in 3-space
U3 = U(:, 1:3)'; %Get the first 3 feature vectors
Z3 = U3 * Xc; %Project to get the 3 principal components

%Look at the principal components in pairs
figure(3);
c = size(Z3,1); %Number of components
sbplt_index=1;
for i = 1:c
   for j= i+1:c 
       subplot(2, 2, sbplt_index)
       sbplt_index = sbplt_index + 1;
       plot(Z3(i,:),Z3(j,:),'k.','MarkerSize',3)
       axis('equal')
       set(gca,'FontSize',22)
       
       xlabel(append("PC ", string(i)))
       ylabel(append("PC ", string(j)))
   end
end

%Look at the 3D Scatterplot
s = 15; %Marker size
subplot(2, 2, 4)
scatter3(Z3(1,:),Z3(2,:),Z3(3,:), s, 'o', 'MarkerEdgeColor','k', 'MarkerFaceColor','b')
xlabel("PC 1")
ylabel("PC 2")
zlabel("PC 3")
set(gca,'FontSize',22)
title("Principal Components 3D-Scatterplot", 'FontSize', 20)

sgtitle("Figure 3: Centered Data Principal Components (PC) Compared");

%Looking at the comparisons, there appear to be
% % % % % 2 CLUSTERS % % % % %

