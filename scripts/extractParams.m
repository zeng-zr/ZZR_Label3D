calib=load("D:\zzr_workspace\demo0215_300\calibration\ball1223_27.calibpkl.mat");
poses=calib.ba_poses;
save_path='D:\zzr_workspace\demo0215_300\calibration';
%% 
for k=1:numel(poses)
    dist=poses{k}.dist;
    r= poses{k}.R;
    r=r';
    t=poses{k}.t;
    K =poses{k}.K;
    K=K'+[0,0,0;0,0,0;1,1,0];
    RDistort =dist([1 2 5]);
    TDistort=dist(3:4);
    image_shape=poses{k}.image_shape;
    fileName=sprintf('%d_params.mat',k);
    filePath=fullfile(save_path,fileName);
    save(filePath,'K','t','RDistort','TDistort','r');
    %eval(['cam',num2str(k),'=',poses{k},';')
end

%field = fieldnames(poses{k}); 
%field{i}=poses{k}.field{i}
%