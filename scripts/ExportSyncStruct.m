% 加载 sync.mat 文件
load('sync.mat');

% 遍历 sync cell 数组
for k = 1:length(sync)
    % 从 cell 数组中提取当前结构体
    currentStruct = sync{k};

    % 为每个字段创建变量
    varNames = fieldnames(currentStruct); % 获取所有字段名称
    for n = 1:length(varNames)
        % 使用动态字段名创建变量
        varName = varNames{n};
        eval([varName ' = currentStruct.' varName ';']);
    end

    % 将所有变量保存到单独的文件中
    filename = sprintf('%d_sync.mat', k);
    save(filename, varNames{:});
end
