clc; close all; clear;

facesDir = 'training_data';
faces = dir(fullfile(facesDir,'*.bmp')); %What is the variable faces containing? all image files of the directory

face = imread(['./training_data/',faces(1).name,'']);
R = size(face,1);
C = size(face,2);
GAMMA = double(zeros(R.*C, length(faces)));
M=length(faces);

% #to-do: fulfill the matrix GAMMA: each row corresponds to an image of the training data
for i =1:M
    face = imread(['./training_data/',faces(i).name,'']);
    GAMMA(:,i) = reshape(face,R.*C,1);
end
PSI = transpose(mean(transpose(GAMMA))); % #to-do: calculate the mean face of the training data
% #to-do: visualize PSI
PSIV = uint8(reshape(PSI,R,C));
imshow(PSIV);
A = double(zeros(R*C,M)); % #to-do: calculate the matrix A by subtracting the mean face from each feature vector (help repmat)
for i = 1:M
    A(:,i) = GAMMA(:,i) - PSI;
end    
% What is the trick of the method here? We compute the eigenvectors of A*At
% using At*A eigenvectors (this is because a memory problem)
S_trick = A'*A;
[V, D] = eig(S_trick);% #to-do: calculate the eigenvector and the eigenvalue of the trick matrix (help eig)

% Which is the dimension of V? Compare to the dimension of the original
% images. V is a 83-dimensional vector <<< R*c

U = double(zeros(R*C,M));% #to-do: initialize eigenfaces taking into account the dimensionality reduction
% What is the following step here representing?
for l = 1:M % #to-do: specifiy the limit of the loop
    ul = double(zeros(size(A,1),1));
    for k = 1:M % #to-do: specifiy the limit of the loop   
        ul = ul + V(l,k)*A(:,k); 
    end
    U(:,l) = ul; 
end
    
dd = diag(D);% #to-do: extract the eigen values of the matrix D (help diag)
[dd, idx] = sort(dd,'descend');% #to-do: sort them in descendent order

% What are we doing here? Why? Document the code in the following raws.
dd = dd(dd>0); %we cant work with a negative eigenvalue
idx2 = idx(dd>0);
U = U(:,idx2);

numberOfEigenFaces = size(idx2,1);% #to-do: calculate the number of eigenfaces

% Can we say that the following 4 eigenfaces images are the most
% representative eigenfaces? If so, why? yes, because they have asociated
% the greater eigenvalues
figure();
subplot(2,2,1), imshow(reshape(U(:,1), R, C), []), title('Eigenface 1');
subplot(2,2,2), imshow(reshape(U(:,2), R, C), []), title('Eigenface 2');
subplot(2,2,3), imshow(reshape(U(:,3), R, C), []), title('Eigenface 3');
subplot(2,2,4), imshow(reshape(U(:,4), R, C), []), title('Eigenface 4');

% Define the steps here. What is W_TRAIN?
%we compute the linear combination of eigenfaces in each face in A
A = A(:, idx); %we need A ordered in the same order of the base U
W_TRAIN = A' * U;
% Visualize the images of 5 different persons with 5 colors corresponding to each person in the space of the first 3 most important
% eigenfaces space.
figure();
for i =1:5
    I = W_TRAIN(i,1)*U(:,1)+W_TRAIN(i,2)*U(:,2)+W_TRAIN(i,3)*U(:,3);
    subplot(1,5,i),
    imshow(reshape(I,R,C));
end
save('EIGENFACES_TRAIN_DATA', 'GAMMA', 'PSI', 'idx', 'U', 'W_TRAIN', 'A');
