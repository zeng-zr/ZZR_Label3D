%info = mmfileinfo('C:\Users\zeng\Desktop\intern\origin_videos\0 (1).avi');
%vidPath='C:\Users\zeng\Desktop\intern\origin_videos\0 (1).avi';
%vidPath="C:\Users\zeng\Desktop\intern\origin_videos\0(1)_test.avi";
%vidPath='C:\Users\zeng\Desktop\intern\test_xvid.avi';
%vidPath='C:\Users\zeng\Desktop\intern\test_x264.mp4';
%vidPath='C:\Users\zeng\Desktop\intern\test_mpeg4avc.avi';
%info = mmfileinfo(vidPath);
info = mmfileinfo('D:\python37\py37_venv\dannce\demo\my_demo\videos\Camera1\0.avi')
%%
%VidObj = VideoReader("C:\Users\zeng\Desktop\intern\origin_videos\0 (1).avi"); %可以正常读取
%vidPath="C:\Users\zeng\Desktop\intern\videos\0_1_edit.mp4"
%vidPath = 'C:\Users\zeng\Desktop\intern\videos\0(1).avi';
%vidPath='C:\Users\zeng\Desktop\intern\origin_videos\0 (1).avi';
VidObj = VideoReader('D:\python37\py37_venv\dannce\demo\my_demo\videos\Camera1\0.avi'); %错误使用 test_frame (第 11 行) 文件中没有更多可读取的帧。
nFrames = VidObj.NumFrames %获取视频总帧数

vidHeight = VidObj.Height %获取视频高度

vidWidth = VidObj.Width%获取视频宽度

%for k = 1 : nFrames %遍历每一帧

%% mmread 与 VideoReader不兼容？
%for k = 1 : 10 %遍历每一帧
    I = mmread(vidPath, 1); %读出当前帧

    imshow(1); %显示当前帧

    %pause(1); %暂停系统，使人眼连贯观察到每一帧，此设为0.005秒

%end
%% 
filename = vidPath;
avi_obj=aviread(filename);
no_frame=size(avi_obj,2);
figure
%for i=721:no_frame
img=avi_obj(1).cdata;
imshow(img),title(sprintf('Frame %d',1));
drawnow; 
%pause(0.5);
%end
%% mmread test
video = mmread(vidPath,1:10)

%% test my_readFrames.m
[frames,numframes]=readFrames(vidPath,1:10);


