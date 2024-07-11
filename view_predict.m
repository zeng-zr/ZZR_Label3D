addpath(genpath('deps'));
projectFolder = 'E:\zzr\dannce_project\0612_G1';
skeletonPath=fullfile(projectFolder, 'skeletons\mouse_21.mat');
skeleton = load(skeletonPath);
calibPaths = collectCalibrationPaths(projectFolder);
params = cellfun(@(X) {load(X)}, calibPaths);

vidName = '0.avi';
vidPaths = collectVideoPaths(projectFolder,vidName);
videos = cell(5,1);%camera数量
sync =  collectSyncPaths(projectFolder, '*.mat');
sync = cellfun(@(X) {load(X)}, sync);
%% 
framesToLabel =1:30:3000; 
for nVid = 1:numel(vidPaths)
    frameInds = sync{nVid}.data_frame(framesToLabel);
    videos{nVid} = readFrames(vidPaths{nVid}, frameInds+1,false);
end
%% view dannce predictions
viewGui = View3D(params, videos, skeleton);
predPath= fullfile(projectFolder,'predictions\0620_dannce.mat');
pts3d = load(predPath);
%com_pts=pts3d.com(framesToLabel,:);
dannce_pts=pts3d.pred(framesToLabel,:,:);
viewGui.loadFrom3D(dannce_pts);
%%  view COM predictions
skeletonPath=fullfile(projectFolder, 'skeletons\com.mat');
skeleton = load(skeletonPath);
viewGui = View3D(params, videos, skeleton);
comPath= fullfile(projectFolder,'\predictions\com3d_max.mat');
pts3d = load(comPath);
com_pts=pts3d.com(framesToLabel,:);
viewGui.loadFrom3D(com_pts);
%% write videos
framesInVideo = framesToLabel;
savePath = 'video_0515_1.mp4';
viewGui.writeVideo(framesInVideo, savePath, 'FPS', 4, 'Quality', 90);