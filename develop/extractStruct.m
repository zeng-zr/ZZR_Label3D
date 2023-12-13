calib=load("ball.calibpkl.mat");
poses=calib.ba_poses;
save_path='D:\python37\py37_venv\dannce\demo\my_demo\Label3D\calibration';
%% 
for k=1:numel(poses)
    dist=poses{k}.dist;
    R= poses{k}.R;
    t=poses{k}.t;
    K =poses{k}.K;
    image_shape=poses{k}.image_shape;
    fileName=sprintf('%d_params.mat',k);
    filePath=fullfile(save_path,fileName);
    save(filePath,'K','t','dist','R');
    %eval(['cam',num2str(k),'=',poses{k},';')
end

%field = fieldnames(poses{k}); 
%field{i}=poses{k}.field{i}
%