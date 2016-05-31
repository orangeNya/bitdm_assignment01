function analytic_mat = load_file(path)
%LOAD_FILE ��ȡpath�����ļ���������ݾ��������������
%   Ҫ��path�����ļ�����Analysis.txt�ı�׼��ʽ������ÿ�а���3��������ԣ�8��ˮ�����ԣ�7������������

file = fopen(path);

DIM = 18; % ˮ������ά��

temp_mat = textscan( ...
        file, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s'); % ��ȡ�����ݼ�
N = size(temp_mat{1, 1}, 1); % ��������

analytic_mat = cell(N, DIM); % �����µ�cell�����temp_mat���и�ʽ���洢
for i = 1: N
    for j = 1: DIM
        if(j <= 3)
            analytic_mat{i, j} = temp_mat{1, j}{i}; % ǰ����û������ȱʧ��ֱ�Ӹ���
        else
            if(strcmp(temp_mat{1, j}{i}, 'XXXXXXX') == 1)
                analytic_mat{i, j} = NaN; % ����ȱʧת��ΪNaN
            else
                analytic_mat{i, j} = str2double(temp_mat{1, j}{i}); % �������ȱʧ��ת��Ϊdouble
            end
        end
    end
end

end