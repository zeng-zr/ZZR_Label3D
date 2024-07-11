function [frames, numFrames] = readFrames(videoPath, frameNums, isGrayscale)
    %READFRAMES Reads frames using VideoReader.
    % Usage:
    %   frames = readFrames(videoPath, frameNums)
    %   frames = readFrames(videoPath, frameNums, true) % for grayscale videos
    %   [frames, numFrames] = readFrames(_)
    
    % Check if the video file exists

    if ~ischar(videoPath) || ~exist(videoPath, 'file')
        error('Invalid video path specified.')
    end
    
    % If frameNums is not specified, read all frames
    if nargin < 2 || isempty(frameNums)
        frameNums = inf;
    end
    
    % If isGrayscale is not specified, auto-detect
    if nargin < 3 || isempty(isGrayscale)
        isGrayscale = false;
    end
    isGrayscale= true;
    % Create a VideoReader object
    vidObj = VideoReader(videoPath);
    numFrames = vidObj.NumFrames;
    
    % Initialize the frames array
    if isGrayscale
        frames = zeros(vidObj.Height, vidObj.Width, 1, length(frameNums), 'uint8');
    else
        frames = zeros(vidObj.Height, vidObj.Width, 3, length(frameNums), 'uint8');
    end
    
    % Read the specified frames
    count = 0;
    for i = 1:length(frameNums)
        if frameNums(i) == inf
            % Read all frames
            while hasFrame(vidObj)
                count = count + 1;
                currentFrame = readFrame(vidObj);
                if isGrayscale
                    frames(:, :, 1, count) = rgb2gray(currentFrame);
                else
                    frames(:, :, :, count) = currentFrame;
                end
            end
            break;
        elseif frameNums(i) <= numFrames
            % Seek to the specified frame
            vidObj.CurrentTime = (frameNums(i)-1) / vidObj.FrameRate;
            currentFrame = readFrame(vidObj);
            count = count + 1;
            if isGrayscale
                frames(:, :, 1, count) = rgb2gray(currentFrame);
            else
                frames(:, :, :, count) = currentFrame;
            end
        else
            warning('Frame number %d exceeds the total number of frames in the video.', frameNums(i));
        end
    end
    
    % Trim the uninitialized frames if fewer frames were read
    frames = frames(:, :, :, 1:count);
    numFrames = count;
end