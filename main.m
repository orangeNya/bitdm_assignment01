function main
%MAIN ��������ڡ�
%   ���д˳����ø��ֽ����

analytic_mat = load_file('Analysis.txt');

ATTRIBUTES = {'mxPH'; 'mnO2'; 'CL'; 'NO3'; 'NH4'; 'oPO4'; 'PO4'; 'Chla'}; % ����������
ATTRIBUTE_L = 4;
ATTRIBUTE_H = 11; % 4~11�е���������ֵ��ֵ����

disp('Frequency of season attribute:');
tabulate(analytic_mat(:, 1));
disp(' ');
disp('Frequency of size attribute:');
tabulate(analytic_mat(:, 2));
disp(' ');
disp('Frequency of level attribute:');
tabulate(analytic_mat(:, 3)); % ���Ʊ���Ƶ��
disp(' ');

for i = ATTRIBUTE_L: ATTRIBUTE_H
    disp(['Data abstract of attribute ', ATTRIBUTES{i - ATTRIBUTE_L + 1}, ':']);
    
    temp_data = [analytic_mat{:, i}]';
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line, :) = []; % ɾ������NaN����
    
    disp(['  Maximium:     ', num2str(max(temp_data))]); % ���ֵ
    disp(['  Minimium:     ', num2str(min(temp_data))]); % ��Сֵ
    disp(['  Average:      ', num2str(sum(temp_data) / size(temp_data, 1))]); % ƽ��ֵ
    disp(['  Median:       ', num2str(median(temp_data))]); % ��λ��
    disp(['  Quartile:     ', num2str(prctile(temp_data,25)), ', ', num2str(prctile(temp_data,75))]); % �ķ�λ��
    disp(['  Missing data: ', num2str(size(NaN_line, 1))]); % ȱʧֵ����
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