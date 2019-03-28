function [cur_group] = kmeans_diy( input_data, num_cluster )
% your implementation of kmeans clustering Lloyd's algorithm
%   input_data: data to be classified, size:NxD
%   num_cluster: specified number of cluster
%   cur_group: obtained label from clustering, size: Nx1
%   where N is the number of data and D is the dimension of each data point

[N,~] = size(input_data);

% Initialize random centroid
centroid = input_data(randi(N, num_cluster, 1),:);

% Assign all points to belonging to one centroid and recompute
% centroids
notConverged = true;
cur_group = zeros(N,1);
numIter = 0;
maxIter = 5000;
while notConverged % Max-Iter
    dist = compute_pairwise_distance(input_data, centroid);
    [~,newCluster] = min(dist,[],2);
    
    % compute new center
    for i = 1:num_cluster
        centroid(i,:) = mean(input_data(cur_group==i,:),1);
    end
    
    % stopping criteria
    if (newCluster == cur_group) | (numIter > maxIter)
        notConverged = 0;
    else
        cur_group = newCluster;
    end
    numIter = numIter + 1;
end
end

