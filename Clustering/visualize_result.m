function visualize_result(data,label,plot_title)
% visualize result (for 2 clusters only!)
data1 = data(label==1,:);
data2 = data(label==2,:);
figure
    plot(data1(:,1),data1(:,2),'or'); hold on;
    plot(data2(:,1),data2(:,2),'sb'); hold on;
axis square
title(plot_title);
end