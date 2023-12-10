function [frames, numFrames] = my_readFrames(videoPath, frameNums, isGrayscale)
%READFRAMES Reads frames using VideoReader.
% Usage:
%   frames = readFrames(videoPath, frameNums)
%   frames = readFrames(videoPath, frameNums, true) % for grayscale videos
%   [frames, numFrames] = readFrames(_)
%   frames=[height,width,channels,frames]

if ~ischar(videoPath) || ~exist(videoPath, 'file')
    error('Invalid video path specified.')
end
if nargin < 2
    frameNums = [];
end
if nargin < 3
    isGrayscale = []; % auto
end

video = VideoReader(videoPath);
numFrames = video.NumFrames;

if isempty(frameNums)
    frameNums = 1:numFrames;
end

frames = zeros(video.Height, video.Width, video.NumChannels, numel(frameNums));

for i = 1:numel(frameNums)
    frame = read(video, frameNums(i));
    frames(:, :, :, i) = frame;
end

% Auto detect
if isempty(isGrayscale)
    isGrayscale = isequal(frames(:,:,1,1), frames(:,:,2,1));
end

if isGrayscale
    frames = frames(:,:,1,:);
end

end

