clear,clc

% load data
load('ex10_data');
num_cluster = 2;

% form data
data1_merge = [data1.X1;data1.X2];
data1_label = [ones(size(data1.X1,1),1);2*ones(size(data1.X2,1),1)];

data2_merge = [data2.X1;data2.X2];
data2_label = [ones(size(data2.X1,1),1);2*ones(size(data2.X2,1),1)];
% visualize the raw data
visualize_result(data1_merge,data1_label,'Data1')
visualize_result(data2_merge,data2_label,'Data2')

% K-means clustering
data1_km_result = kmeans_diy(data1_merge,num_cluster);
data2_km_result = kmeans_diy(data2_merge,num_cluster);
% Spectral clustering
data1_sc_result = spectralclustering_diy(data1_merge,num_cluster);
data2_sc_result = spectralclustering_diy(data2_merge,num_cluster);

% visualize the clustering result
visualize_result(data1_merge,data1_km_result,'Data1 k-means');
visualize_result(data1_merge,data1_sc_result,'Data1 spectral clustering');

visualize_result(data2_merge,data2_km_result,'Data2 k-means');
visualize_result(data2_merge,data2_sc_result,'Data2 spectral clustering');