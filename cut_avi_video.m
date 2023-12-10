function cut_avi_video(inputFile, startTime, endTime, outputFile)
    % 创建视频读取对象
    vidObj = VideoReader(inputFile);

    % 获取视频属性
    fps = vidObj.FrameRate;
    startFrame = round(startTime * fps);
    endFrame = round(endTime * fps);

    % 创建视频写入对象
    writerObj = VideoWriter(outputFile, 'Uncompressed AVI');
    writerObj.FrameRate = fps;
    open(writerObj);

    % 初始化帧计数器
    currentFrame = 0;

    % 读取并写入帧
    while hasFrame(vidObj) 
        currentFrame = currentFrame + 1;
        frame = readFrame(vidObj);

        % 检查当前帧是否在指定范围内
        if currentFrame >= startFrame && currentFrame <= endFrame
            writeVideo(writerObj, frame);
        elseif currentFrame > endFrame
            break;
        end
    end

    % 关闭视频文件
    close(writerObj);
end
