%% 用于com-train
clear;
close all;
addpath(genpath('deps'));
danncePath = 'D:\zzr_workspace\com_label3D';
projectFolder = fullfile(danncePath,'Label3D');
skeleton=load('D:\zzr_workspace\ZZR_Label3D-master\skeletons\com.mat');
calibPaths = collectCalibrationPaths(projectFolder);
params = cellfun(@(X) {load(X)}, calibPaths);
vidName = '0.avi';
vidPaths = collectVideoPaths(danncePath,vidName);
videos = cell(4,1);
sync =  collectSyncPaths(projectFolder, '*.mat');
sync = cellfun(@(X) {load(X)}, sync);

framesToLabel =sampleID;
for nVid = 1:numel(vidPaths)%每次循环处理一个视频文件
    frameInds = sync{nVid}.data_frame(framesToLabel);%
    videos{nVid} = readFrames(vidPaths{nVid}, frameInds+1,true);
end

labelGui=Label3D(params, videos, skeleton, 'sync', sync,'framesToLabel', framesToLabel);
%labelGui.saveAll();

%%
%load com3d0.mat;
framesToLabel=sampleID;
data_3D=com;

save com_basic.mat  data_3D -append

%params=camParams;
%labelGui=Label3D('com3d0.mat',params,videos,skeleton,sync,framesToLabel);
%%
for i=1:length(sync)
    struct_cell=sync(i);
    struct=sync{1};
    fields = fieldnames(struct);
    for j=1:length(fields)
        tmp=fields(i);
        tmp_edit=tmp(750:end,:);
    end
end

%%
sync =  collectSyncPaths('D:\zzr_workspace\demo1223', '*.mat');
sync = cellfun(@(X) {load(X)}, sync);
%%
viewGui = View3D(params, videos, skeleton);