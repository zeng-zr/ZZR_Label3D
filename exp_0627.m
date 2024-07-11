addpath(genpath('deps'));
projectFolder = '..\0612_G1';
skeletonPath=fullfile(projectFolder, 'skeletons\mouse_21.mat');
skeleton = load(skeletonPath);
calibPaths = collectCalibrationPaths(projectFolder);
params = cellfun(@(X) {load(X)}, calibPaths);

vidName = '0.avi';
vidPaths = collectVideoPaths(projectFolder,vidName);
videos = cell(5,1);% 
sync =  collectSyncPaths(projectFolder, '*.mat');
sync = cellfun(@(X) {load(X)}, sync);
%% 指定需要标记的帧序号
%framesIndex1=1160:1175;
%framesIndex2=1395:1425;
%framesToLabel= cat(2,framesIndex1,framesIndex2);
framesToLabel= 1:500;
%%
for nVid = 1:numel(vidPaths)
    frameInds = sync{nVid}.data_frame(framesToLabel);
    videos{nVid} = readFrames(vidPaths{nVid}, frameInds+1,false);
end
%% Start Label3D
close all
labelGui = Label3D(params, videos, skeleton, 'sync', sync,'framesToLabel', framesToLabel,'savePath',projectFolder);%load from scratch
%labelGui=Label3D('20231227_181440_Label3D_videos.mat')%加载saveAll()保存的文件
%%  Save to *dannce.mat
%labelGui.exportDannce('basePath',danncePath,'saveFolder','save_dannce');
%labelGui.saveAll()%退出时执行，保存进度
%% Check the camera positions
%labelGui.plotCameras%选择projectFolder打开
%% If you just wish to view labels, use View 3D
%close all
%viewGui = View3D(params, videos, skeleton);
%% You can load both in different ways
%close all;
%View3D()