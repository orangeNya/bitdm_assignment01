function analytic_mat = load_file(path)
%LOAD_FILE 读取path处的文件，输出数据矩阵和数据条数。
%   要求path处的文件按照Analysis.txt的标准格式给出，每行包含3个标称属性，8个水样属性，7个海藻数量。

file = fopen(path);

DIM = 18; % 水样参数维度

temp_mat = textscan( ...
        file, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s'); % 读取的数据集
N = size(temp_mat{1, 1}, 1); % 数据条数

analytic_mat = cell(N, DIM); % 创建新的cell矩阵对temp_mat进行格式化存储
for i = 1: N
    for j = 1: DIM
        if(j <= 3)
            analytic_mat{i, j} = temp_mat{1, j}{i}; % 前三列没有数据缺失，直接复制
        else
            if(strcmp(temp_mat{1, j}{i}, 'XXXXXXX') == 1)
                analytic_mat{i, j} = NaN; % 数据缺失转换为NaN
            else
                analytic_mat{i, j} = str2double(temp_mat{1, j}{i}); % 如果不是缺失就转换为double
            end
        end
    end
end

end