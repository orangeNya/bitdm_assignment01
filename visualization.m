function visualization(data)
%VISUALIZATION 可视化数据。如果data未经预处理会有NaN，因此要先考虑剔除NaN的情况，再分别可视化。
%   绘制8个属性的直方图、QQ图、盒图，以及7种海藻的直方图、条件盒图。

ATTRIBUTE_L = 4;
ATTRIBUTE_H = 11; % 4~11列的属性是数值且有可能缺失
ALGAE_L = 12;
ALGAE_H = 18; % 12~18列是海藻

figure; % 新建直方图窗口
% ATTR_NAME = {'Maximium PH'; 'Minimium O2'; 'Average Cl'; 'Average NO3'; ...
%     'Average NH4'; 'Average oPO4'; 'Average PO4'; 'Average Chla'}; % 图标题
X_LABELS = {'mxPH'; 'mnO2'; 'CL'; 'NO3'; 'NH4'; 'oPO4'; 'PO4'; 'Chla'}; % 直方图x轴名称
% Y_LABEL = 'The number of samples'; % 直方图y轴名称
for i = ATTRIBUTE_L: ATTRIBUTE_H
    temp_data = [data{:, i}]';
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line, :) = []; % 删掉含有NaN的行
        
    subplot(2, (ATTRIBUTE_H - ATTRIBUTE_L + 1) / 2, i - ATTRIBUTE_L + 1); % 2行4列
    histogram(temp_data);
    title(X_LABELS(i - ATTRIBUTE_L + 1));
    % xlabel(X_LABELS(i - ATTRIBUTE_L + 1)), ylabel(Y_LABEL);
end

figure; % 新建QQ图窗口，因为不知道怎么把subplot放到不同figure里只能重写一遍
for i = ATTRIBUTE_L: ATTRIBUTE_H
    temp_data = [data{:, i}]';
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line, :) = [];
        
    subplot(2, (ATTRIBUTE_H - ATTRIBUTE_L + 1) / 2, i - ATTRIBUTE_L + 1); % 2行4列
    qqplot(temp_data);
    title(X_LABELS(i - ATTRIBUTE_L + 1));
    set(gca, 'xlabel', [], 'ylabel', []); % 取消横纵轴名
end

figure, boxplot(cell2mat(data(:, ATTRIBUTE_L: ATTRIBUTE_H)), ...
    'labels', X_LABELS); % 盒图窗口
figure; % 单独观察盒图
for i = ATTRIBUTE_L: ATTRIBUTE_H       
    subplot(2, (ATTRIBUTE_H - ATTRIBUTE_L + 1) / 2, i - ATTRIBUTE_L + 1); % 2行4列
    boxplot(cell2mat(data(:, i)));
    title(X_LABELS(i - ATTRIBUTE_L + 1));
    set(gca, 'xticklabel', []); % 取消横轴名
end

figure; % 海藻数量直方图
for i = ALGAE_L: ALGAE_H
    temp_data = [data{:, i}]';
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line, :) = []; % 删掉含有NaN的行

    subplot(2, (ALGAE_H - ALGAE_L + 2) / 2, i - ALGAE_L + 1); % 2行4列
    histogram(temp_data);
    title(['a', num2str(i - ALGAE_L + 1)]);
end

figure; % 海藻条件盒图窗口，条件是第二列的size
for i = ALGAE_L: ALGAE_H
    subplot(2, (ALGAE_H - ALGAE_L + 2) / 2, i - ALGAE_L + 1); % 2行4列
    boxplot(cell2mat(data(:, i)), ...
        data(:, 2)); 
    title(['a', num2str(i - ALGAE_L + 1)]);
end

end