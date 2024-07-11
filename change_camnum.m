%% load file
fileName='dannce\com_0516_1_dannce.mat';
baseName=split(fileName,'_');
load(fileName);

file=matfile(fileName);
varlist=who(file);
%% 5 cams
camnames{5}='Camera5';
labelData{5}=labelData{4};
sync{5}=sync{4};
params{5}=params{4};

save('0223_5cams_dannce.mat','camnames','labelData','sync','params');

%% 4 cams
camnames=camnames(1:4);
labelData=labelData(1:4);
sync=sync(1:4);
params=params(1:4);

save('dannce\com_0516_1_4cams_dannce.mat','camnames','labelData','sync','params');
%% 3 cams
camnames=camnames(1:3);
labelData=labelData(1:3);
sync=sync(1:3);
params=params(1:3);

save('dannce\0411_3cams_dannce.mat','camnames','labelData','sync','params');
%% mod cam5 to cam1 data
camnames{5}='Camera5';
labelData{5}=labelData{1};
sync{5}=sync{1};
params{5}=params{1};

save('dannce/0221_5new_dannce.mat','camnames','labelData','sync','params');

%% cam12 to cam45
camnames{4}='Camera4';
camnames{5}='Camera5';
labelData{5}=labelData{2};
labelData{4}=labelData{1};
sync{5}=sync{2};
sync{4}=sync{1};
params{5}=params{2};
params{4}=params{1};
save('0223_5new2_dannce.mat','camnames','labelData','sync','params');
