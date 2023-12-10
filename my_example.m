%% Example setup for Label3D
% Label3D is a GUI for manual labeling of 3D keypoints in multiple cameras. 
% 
% Its main features include:
% 1. Simultaneous viewing of any number of camera views. 
% 2. Multiview triangulation of 3D keypoints.
% 3. Point-and-click and draggable gestures to label keypoints. 
% 4. Zooming, panning, and other default Matlab gestures
% 5. Integration with Animator classes. 
% 6. Support for editing prelabeled data.
% 
% Instructions:
% right: move forward one frameRate
% left: move backward one frameRate
% up: increase the frameRate
% down: decrease the frameRate
% t: triangulate points in current frame that have been labeled in at least two images and reproject into each image
% r: reset gui to the first frame and remove Animator restrictions
% u: reset the current frame to the initial marker positions
% z: Toggle zoom state
% p: Show 3d animation plot of the triangulated points. 
% backspace: reset currently held node (first click and hold, then
%            backspace to delete)
% pageup: Set the selectedNode to the first node
% tab: shift the selected node by 1
% shift+tab: shift the selected node by -1
% h: print help messages for all Animators
% shift+s: Save the data to a .mat file
%clear all
close all;
addpath(genpath('deps'))
%addpath(genpath('skeletons'))
danncePath = 'D:\python37\py37_venv\dannce\demo\my_demo';

%% Load in the calibration parameter data
%建议将文件组织成以下结构:
%'danncePath'
%+-- videos
%+-- Label3D
%   +--calibration
%       +-- *_params
%   +--sync
%       +-- *_sync.mat 
%   +--skeletons
projectFolder = fullfile(danncePath,'Label3D');
calibPaths = collectCalibrationPaths(projectFolder);
params = cellfun(@(X) {load(X)}, calibPaths);

%% Load the videos into memory
vidName = '0.avi';
vidPaths = collectVideoPaths(danncePath,vidName);
videos = cell(4,1);
sync =  collectSyncPaths(projectFolder, '*.mat');%
sync = cellfun(@(X) {load(X)}, sync);
%% 

% In case the demo folder uses the dannce.mat data format. 
if isempty(sync)
    dannce_file = dir(fullfile(projectFolder, '*dannce.mat'));
    dannce = load(fullfile(dannce_file(1).folder, dannce_file(1).name));
    sync = dannce.sync;
    params = dannce.params;
end
%% 

%framesToLabel = 1480:5:1480+30*13;%设置需要标记的帧范围:47秒开始到60秒，5帧间隔
framesToLabel =100:200;
for nVid = 1:numel(vidPaths)%每次循环处理一个视频文件
    frameInds = sync{nVid}.data_frame(framesToLabel);%从sync中提取第n个相机的framesToLabel范围内的帧
    videos{nVid} = readFrames(vidPaths{nVid}, frameInds+1);%frameInds+1 调整帧索引以提取正确的帧到videos数组中
end

%% Get the skeletons
skeleton = load('D:\python37\py37_venv\dannce\demo\my_demo\Label3D\skeletons\my_rat.mat');
% skeleton = load('com');

%% Start Label3D
close all
%labelGui = Label3D(params, videos, skeleton);
 labelGui = Label3D(params, videos, skeleton, 'sync', sync,'framesToLabel', framesToLabel);%load from scratch
 %如果不执行framestoLabel节则无法加载状态文件，如果执行该节则会错误地将frames和label对应
%labelGui=Label3D('20231130_211959_Label3D.mat',videos);%从该状态加载;shift+S保存当前状态，记录的是相对于framestoLabel的帧位置
%%  Save to *dannce.mat
%labelGui.exportDannce('basePath',danncePath)

%% Check the camera positions
%labelGui.plotCameras%选择projectFolder打开

%% If you just wish to view labels, use View 3D
%close all
%viewGui = View3D(params, videos, skeleton);

%% You can load both in different ways
%close all;
%View3D()
