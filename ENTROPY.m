%计算图像P的信息熵y
% function [y] = ENTROPY(P)
% P=mod(round(P), 256);
% [M,N]=size(P);
% P=transpose(P(:));
% T=zeros(1,256);
% for i=1:256
%     T(i)=sum(P==(i-1));
%     T(i)=T(i)/(M*N);
% end
% y=-T(T>0)*transpose(log2(T(T>0)));
% end

% 数据
% x = 2:2:10; % 横坐标：返回图像的总数
% VGG16= [0.58, 0.55, 0.5, 0.48, 0.42]; % VGG16 (d=128) 数据
% VGG19= [0.68, 0.6, 0.58, 0.56, 0.55]; % VGG19 (d=128) 数据
% ResNet50= [0.71, 0.69, 0.66, 0.63, 0.62]; % ResNet50 (d=128) 数据
% CLD= [0.4, 0.365, 0.32, 0.28, 0.24]; % CLD (d=120) 数据
% EHD= [0.37, 0.35, 0.31, 0.26, 0.22]; % EHD (d=80) 数据
% Ours = [0.801, 0.7844, 0.764, 0.7531, 0.72]; % EHD (d=128) 数据
% % 绘图
% figure;
% fig = figure('Position', [100 100 520 400]);
% 
% plot(x, VGG16, '-o', 'Color', [0.9 0.5 0.13], 'MarkerSize', 4, 'LineWidth', 1.5); % VGG16
% hold on;
% plot(x, VGG19, '-s', 'Color', [0.18 0.8 0.44], 'MarkerSize', 4, 'LineWidth', 1.5); % VGG19
% plot(x, ResNet50, '-^', 'Color', [0.2 0.6 0.86], 'MarkerSize', 4, 'LineWidth', 1.5); % ResNet50
% plot(x, CLD, '-d', 'Color', [0.95 0.77 0.06], 'MarkerSize', 4, 'LineWidth', 1.5); % CLD
% plot(x, EHD,  '-v', 'Color', [0.61 0.35 0.71], 'MarkerSize', 4, 'LineWidth', 1.5); % EHD
% plot(x, Ours, '-p', 'Color', [0.2 0.29 0.37], 'MarkerSize', 4, 'LineWidth',1.5); % CLD
% % 图例
% legend('VGG16 (dimension=128)', 'VGG19 (dimension=128)', 'ResNet50 (dimension=128)', 'CLD (dimension=120)', 'EHD (dimension=80)','Ours(dimension=128)','Location', 'SouthWest');
% 
% % 标签
% xlabel('The total number of returned images');
% ylabel('Accuracy');
% 
% % 网格
% grid on;
% 
% % 设置轴的范围
% xlim([2 10]);
% ylim([0 1]);
% set(legend,'FontName','Times New Roman')
% set(findall(gcf,'Type','Text'),'FontName','Times New Roman')
% % 设置轴的刻度
% set(gca, 'XTick', 2:1:10);
% set(gca, 'YTick', 0:0.1:1);
% 
% 
% print('myplot.pdf', '-dpdf', '-r600');


% top_k = [10, 20, 50, 100];
% epr_m3 = [0.03, 0.05, 0.055, 0.062];
% mfse = [0.50, 0.51, 0.52, 0.54];
% bdmrs = [0.22, 0.23, 0.24, 0.245];
% epr_m15 = [0.038, 0.045, 0.07, 0.085];
% epr_m30 = [0.10, 0.11, 0.12, 0.13];
% figure;
% plot(top_k, epr_m3, '-o','Color', [0.9 0.5 0.13], 'DisplayName', 'EEPR[18]', 'LineWidth', 1.5);
% hold on;
% plot(top_k, mfse, '-d','Color', [0.18 0.8 0.44], 'DisplayName', 'MFSE[17]', 'LineWidth', 1.5);
% plot(top_k, bdmrs, '-<', 'Color', [0.95 0.77 0.06],'DisplayName', 'BDMRS[16]', 'LineWidth', 1.5);
% plot(top_k, epr_m30, '-v','Color', [0.2 0.29 0.37],  'DisplayName', 'Our SA-ASPE1', 'LineWidth', 1.5);
% plot(top_k, epr_m15, '-*','Color', [0.61 0.35 0.71], 'DisplayName', 'Our SA-ASPE2', 'LineWidth', 1.5);
% hold off;
% 
% 
% xlim([10 100]);
% ylim([0 0.75]);
% set(gca, 'XTick', 20:10:100);
% set(gca, 'YTick', 0:0.1:1.2);
% xlabel('The number of top-k');
% ylabel('Search time (s)');
% set(legend,'FontName','Times New Roman');
% set(findall(gcf,'Type','Text'),'FontName','Times New Roman');
% legend('show');
% grid on;
% print('myplot2.pdf', '-dpdf', '-r600');



% 车辆数目
vehicles = [20, 40, 60, 80, 100];

% 各方案的端到端延迟数据（ms）
CATE = [0.8, 2.8, 4.0, 6.3, 6.9];
TPPR = [0.6, 1.8, 3.2, 4.5, 6.0];
Ours = [0.65, 1.9, 3.6, 4.4, 6.3];

% 创建图形
figure;
hold on;

% 绘制各方案的曲线
plot(vehicles, CATE, '-ko', 'LineWidth', 1.5, 'MarkerSize', 8);
plot(vehicles, TPPR, '-bd', 'LineWidth', 1.5, 'MarkerSize', 8);
plot(vehicles, Ours, '-*g', 'LineWidth', 1.5, 'MarkerSize', 8);

% 设置图例
legend( 'CATE[22]', 'TPPR[23]', 'Ours', 'Location', 'northwest');

% 设置坐标轴标签

xlabel('Number of vehicles');
ylabel('End to end latency (ms)');

% 设置坐标轴范围
xlim([20 100]);
ylim([0 7]);

% 设置网格
set(legend,'FontName','Times New Roman');
set(findall(gcf,'Type','Text'),'FontName','Times New Roman');
grid on;

% 保持图形
hold off;
print('myplot1.pdf', '-dpdf', '-r600');

