function output_file(data, path)
%OUTPUT_FILE 将数据标准化输出。
%   输出的路径（包含文件名）为path。

file = fopen(path, 'w');
for i = 1: size(data, 1)
    fprintf(file, '%s     %s     %s     ', data{i, 1}, data{i, 2}, data{i, 3}); 
    fprintf(file, '%f     %f     %f     %f     %f     %f     %f     %f     %f     %f     %f     %f     %f     %f     %f\n', ...
        [data{i, 4: 18}]); % 输出的数据集，因为数据类型不同分开输出
end

end