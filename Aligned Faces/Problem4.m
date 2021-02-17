%Levent Batakci - LAB192@case.edu
%MATH444 HW#1
%Aligned Faces portion

%Clear memory
clc
clear all

%Load the face data
%The data is stored in a 28341x165 matrix X
%The entries are integers ranging from
%0 to 255 (256 possible values)
%Each data vector is an encoded image with size 201x141=28341 pixels
%Each image falls into 1 of 11 categories
%The row-vector I represents the categorization of the data
% 1='No glasses',2='Glasses',3='Sad',4='Surprised',
% 5='Happy', 6='Sleepy',7='Wink',8='Centerlight',
% 9='Leftlight',10='Rightlight',11='Normal'
load AlignedYaleFaces

%Obtain an approximation for the images
r = 50;
[U,D,V] = svds(X, r);
Xr = U * D * V';

%Get an easy way to access the images belonging to a given category
noGlasses = find(I==1);
glasses = find(I==2);
sad = find(I==3);
surprised = find(I==4);
happy = find(I==5);
sleepy = find(I==6);
wink = find(I==7);
centerlight = find(I==8);
leftlight = find(I==9);
rightlight = find(I==10);
normal = find(I==11);

samples = [sad(1) surprised(1) happy(1) sleepy(1) wink(1)];
label = ["sad" "surprised" "happy" "sleepy" "wink"];

%USED FOR ANIMATION CREATION, VERY VERY VERY VERY VERY VERY TIME CONSUMING
% for k = 1: 165
%     figure(1);
%     colormap(gray);
%     [U,D,V] = svds(X, k);
%     Xr = U * D * V';
%     for i = 1:5
%         subplot(2,5,i);
%         imagesc(reshape(X(:,samples(1,i)), ImageSize));
%         xlabel(label(i));
%         xticks([])
%         yticks([])
%         set(gca,'FontSize', 20)
% 
%         subplot(2,5,i+5);
%         imagesc(reshape(Xr(:,samples(1,i)), ImageSize));
%         xlabel(label(i) + " approximation");
%         xticks([])
%         yticks([])
%         set(gca,'FontSize', 20)
%     end
%     sgtitle("Original Images vs. those Achieved by an Approximation of the Data", 'FontSize', 30)
%     saveas(gcf, "animation\frame " + string(k) + ".png");
% end

% Write to the GIF File
% for k = 1:165
%     filename = "animation\frame " + string(k) + ".png";
%     im = imread(filename);
%     im = rgb2gray(im);
%     disp(k)
%     if k == 1 
%         imwrite(im,"animation\FacesGif.gif",'gif'); 
%     else 
%         imwrite(im,"animation\FacesGif.gif",'gif','WriteMode','append'); 
%     end
% end

%Compare originals w/ approximations
figure(1)
colormap(gray)
for i = 1:5
    subplot(2,5,i);
    imagesc(reshape(X(:,samples(1,i)), ImageSize));
    xlabel(label(i));
    xticks([])
    yticks([])
    set(gca,'FontSize', 20)

    subplot(2,5,i+5);
    imagesc(reshape(Xr(:,samples(1,i)), ImageSize));
    xlabel(label(i) + " approximation");
    xticks([])
    yticks([])
    set(gca,'FontSize', 20)
end
sgtitle("Original Images vs. those Achieved by a rank " + string(r) + " Approximation of the Data", 'FontSize', 30)

%Plot the SVs
figure(2)
singular_values = diag(D);
plot(1:r, log(singular_values), 'k.','MarkerSize', 20, 'Color', 'b')
%MAKE THIS PART BETTER

%10 feature vectors
figure(3)
colormap(gray)
for i = 1:5
    subplot(2,5,i);
    imagesc(reshape(U(:,i), ImageSize));
    xlabel("Feature Vector " + string(i));
    xticks([])
    yticks([])
    set(gca,'FontSize', 20)

    subplot(2,5,i+5);
    imagesc(reshape(U(:,i+5), ImageSize));
    xlabel("Feature Vector " + string(i+5));
    xticks([])
    yticks([])
    set(gca,'FontSize', 20)
end
sgtitle("First 10 Feature Vectors", 'FontSize', 30)

K = [4 8 15];
for j = 1:3
    %Compare originals w/ approximations
    figure(3+j)
    colormap(gray)
    k= K(j);
    Uk = U(:, 1:k);
    Xk = U(:, 1:k) * (Uk' * Xr); %Approximation by first k feature vectors
    size(Xk)
    for i = 1:5
        subplot(2,5,i);
        imagesc(reshape(X(:,samples(1,i)), ImageSize));
        xlabel(label(i));
        xticks([])
        yticks([])
        set(gca,'FontSize', 20)

        subplot(2,5,i+5);
        imagesc(reshape(Xk(:,samples(1,i)), ImageSize));
        xlabel(label(i) + " approximation");
        xticks([])
        yticks([])
        set(gca,'FontSize', 20)
    end
    sgtitle("Original Images vs. those Approximated by the First " + string(k) + " Feature Vectors", 'FontSize', 30) 
end



