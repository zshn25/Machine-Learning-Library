function [ cur_group ] = spectralclustering_diy( input_data, num_cluster )
%your implementation of (unnormalized spectral clustering)
%   input_data: data to be classified, size:NxD
%   num_cluster: specified number of cluster
%   cur_group: obtained label from clustering, size: Nx1
%   where N is the number of data and D is the dimension of each data point
% compute adjacency matrix
dist = compute_pairwise_distance(input_data,input_data);
gamma = 1;
W = exp(-1/gamma*dist);
% compute unnormalized laplacian
D = diag(sum(W,2));
L = D - W;
% compute eigenvectors
[U,~] = eig(L);
U = U(:,1:num_cluster);
% perform k-means clustering
cur_group = kmeans_diy(U,num_cluster);
end

