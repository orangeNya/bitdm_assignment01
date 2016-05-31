function visualization(data)
%VISUALIZATION ���ӻ����ݡ����dataδ��Ԥ�������NaN�����Ҫ�ȿ����޳�NaN��������ٷֱ���ӻ���
%   ����8�����Ե�ֱ��ͼ��QQͼ����ͼ���Լ�7�ֺ����ֱ��ͼ��������ͼ��

ATTRIBUTE_L = 4;
ATTRIBUTE_H = 11; % 4~11�е���������ֵ���п���ȱʧ
ALGAE_L = 12;
ALGAE_H = 18; % 12~18���Ǻ���

figure; % �½�ֱ��ͼ����
% ATTR_NAME = {'Maximium PH'; 'Minimium O2'; 'Average Cl'; 'Average NO3'; ...
%     'Average NH4'; 'Average oPO4'; 'Average PO4'; 'Average Chla'}; % ͼ����
X_LABELS = {'mxPH'; 'mnO2'; 'CL'; 'NO3'; 'NH4'; 'oPO4'; 'PO4'; 'Chla'}; % ֱ��ͼx������
% Y_LABEL = 'The number of samples'; % ֱ��ͼy������
for i = ATTRIBUTE_L: ATTRIBUTE_H
    temp_data = [data{:, i}]';
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line, :) = []; % ɾ������NaN����
        
    subplot(2, (ATTRIBUTE_H - ATTRIBUTE_L + 1) / 2, i - ATTRIBUTE_L + 1); % 2��4��
    histogram(temp_data);
    title(X_LABELS(i - ATTRIBUTE_L + 1));
    % xlabel(X_LABELS(i - ATTRIBUTE_L + 1)), ylabel(Y_LABEL);
end

figure; % �½�QQͼ���ڣ���Ϊ��֪����ô��subplot�ŵ���ͬfigure��ֻ����дһ��
for i = ATTRIBUTE_L: ATTRIBUTE_H
    temp_data = [data{:, i}]';
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line, :) = [];
        
    subplot(2, (ATTRIBUTE_H - ATTRIBUTE_L + 1) / 2, i - ATTRIBUTE_L + 1); % 2��4��
    qqplot(temp_data);
    title(X_LABELS(i - ATTRIBUTE_L + 1));
    set(gca, 'xlabel', [], 'ylabel', []); % ȡ����������
end

figure, boxplot(cell2mat(data(:, ATTRIBUTE_L: ATTRIBUTE_H)), ...
    'labels', X_LABELS); % ��ͼ����
figure; % �����۲��ͼ
for i = ATTRIBUTE_L: ATTRIBUTE_H       
    subplot(2, (ATTRIBUTE_H - ATTRIBUTE_L + 1) / 2, i - ATTRIBUTE_L + 1); % 2��4��
    boxplot(cell2mat(data(:, i)));
    title(X_LABELS(i - ATTRIBUTE_L + 1));
    set(gca, 'xticklabel', []); % ȡ��������
end

figure; % ��������ֱ��ͼ
for i = ALGAE_L: ALGAE_H
    temp_data = [data{:, i}]';
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line, :) = []; % ɾ������NaN����

    subplot(2, (ALGAE_H - ALGAE_L + 2) / 2, i - ALGAE_L + 1); % 2��4��
    histogram(temp_data);
    title(['a', num2str(i - ALGAE_L + 1)]);
end

figure; % ����������ͼ���ڣ������ǵڶ��е�size
for i = ALGAE_L: ALGAE_H
    subplot(2, (ALGAE_H - ALGAE_L + 2) / 2, i - ALGAE_L + 1); % 2��4��
    boxplot(cell2mat(data(:, i)), ...
        data(:, 2)); 
    title(['a', num2str(i - ALGAE_L + 1)]);
end

end