addpath(genpath('deps'));
projectFolder = 'E:\zzr\dannce_project\test_0530';
skeletonPath=fullfile(projectFolder, 'skeletons\mymouse_14.mat');
skeleton = load(skeletonPath);
calibPaths = collectCalibrationPaths(projectFolder);
params = cellfun(@(X) {load(X)}, calibPaths);

vidName = '0.avi';
vidPaths = collectVideoPaths(projectFolder,vidName);
videos = cell(6,1);% 
sync =  collectSyncPaths(projectFolder, '*.mat');
sync = cellfun(@(X) {load(X)}, sync);
%% 
framesToLabel=1:500;
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