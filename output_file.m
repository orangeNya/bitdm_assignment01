function output_file(data, path)
%OUTPUT_FILE �����ݱ�׼�������
%   �����·���������ļ�����Ϊpath��

file = fopen(path, 'w');
for i = 1: size(data, 1)
    fprintf(file, '%s     %s     %s     ', data{i, 1}, data{i, 2}, data{i, 3}); 
    fprintf(file, '%f     %f     %f     %f     %f     %f     %f     %f     %f     %f     %f     %f     %f     %f     %f\n', ...
        [data{i, 4: 18}]); % ��������ݼ�����Ϊ�������Ͳ�ͬ�ֿ����
end

end