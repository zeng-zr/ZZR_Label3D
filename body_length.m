data=labelData{1, 1}.data_3d;
for index = 1:size(data,1)
    x=data(index,7)-data(index,19);
    y=data(index,8)-data(index,20);
    z=data(index,9)-data(index,21);
    body_len(index)=sqrt(x^2+y^2+z^2);
end