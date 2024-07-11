% 初始化参数
frames_rate = ...; % 视频帧率
sync = ...; % sync 数组
frames_num = ...; % 需要选取的帧数
sec_start = ...; % 视频片段起始秒数
sec_end = ...; % 视频片段结束秒数

% 从 sync 数组中获取第一个元素的 data_frame 变量
data_frame = sync{1}.data_frame;

% 获取 data_frame 的行数作为总帧数
frames_total = length(data_frame);

% 计算开始和结束对应的帧范围
frame_start = max(1, round(sec_start * frames_rate));
frame_end = min(frames_total, round(sec_end * frames_rate));

% 检查帧范围是否有效
if frame_end <= frame_start
    error('结束时间必须大于开始时间');
end

% 初始化 framesToLabel
framesToLabel = [];

% 当选取的帧数还没达到 frames_num 时，继续随机选择帧
while length(framesToLabel) < frames_num
    % 在指定范围内随机选择一个帧 ID
    frameID = randi([frame_start, frame_end]);
    
    % 检查新选的帧与已选帧之间的间隔是否在 1 到 5 秒之间
    if isempty(framesToLabel) || all(abs(framesToLabel - frameID) >= frames_rate & abs(framesToLabel - frameID) <= 5*frames_rate)
        framesToLabel = [framesToLabel, frameID];
    end
end
