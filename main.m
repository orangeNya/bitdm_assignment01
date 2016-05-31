function main
%MAIN 主程序入口。
%   运行此程序获得各种结果。

analytic_mat = load_file('Analysis.txt');

ATTRIBUTES = {'mxPH'; 'mnO2'; 'CL'; 'NO3'; 'NH4'; 'oPO4'; 'PO4'; 'Chla'}; % 各属性名称
ATTRIBUTE_L = 4;
ATTRIBUTE_H = 11; % 4~11列的属性是数值数值属性

disp('Frequency of season attribute:');
tabulate(analytic_mat(:, 1));
disp(' ');
disp('Frequency of size attribute:');
tabulate(analytic_mat(:, 2));
disp(' ');
disp('Frequency of level attribute:');
tabulate(analytic_mat(:, 3)); % 求标称变量频数
disp(' ');

for i = ATTRIBUTE_L: ATTRIBUTE_H
    disp(['Data abstract of attribute ', ATTRIBUTES{i - ATTRIBUTE_L + 1}, ':']);
    
    temp_data = [analytic_mat{:, i}]';
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line, :) = []; % 删掉含有NaN的行
    
    disp(['  Maximium:     ', num2str(max(temp_data))]); % 最大值
    disp(['  Minimium:     ', num2str(min(temp_data))]); % 最小值
    disp(['  Average:      ', num2str(sum(temp_data) / size(temp_data, 1))]); % 平均值
    disp(['  Median:       ', num2str(median(temp_data))]); % 中位数
    disp(['  Quartile:     ', num2str(prctile(temp_data,25)), ', ', num2str(prctile(temp_data,75))]); % 四分位数
    disp(['  Missing data: ', num2str(size(NaN_line, 1))]); % 缺失值个数
    disp(' ');
end

visualization(analytic_mat);

while(1)
    disp('Choose one way to fill the missing data:');
    disp('(1 - filled by maxium; 2 - filled by attributes; 3 - filled by similarity; any other key - end program)');
    method = input('');
    
    switch(method)
        case 1
            data = preprocessing(analytic_mat, 1);
            output_file(data, 'Analysis_filled_by_maximium.txt');
            visualization(data);
        case 2
            data = preprocessing(analytic_mat, 2);
            output_file(data, 'Analysis_filled_by_attribute.txt');
            visualization(data);
        case 3
            data = preprocessing(analytic_mat, 3);
            output_file(data, 'Analysis_filled_by_similarity.txt');
            visualization(data);
        otherwise
            break;
    end
end

end