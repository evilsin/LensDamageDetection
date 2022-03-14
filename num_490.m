function [arrays,n] = num_490(ii,jj,bochang_three) 
%UNTITLED8 此处显示有关此函数的摘要
%   此处显示详细说明
n = 0;
arrays = [];
if(bochang_three(ii,jj)<490&&bochang_three(ii,jj)>400)
    n = n+1;
    arrays = [arrays;ii,jj,bochang_three(ii,jj)];
end
if(bochang_three(ii+1,jj)<490&&bochang_three(ii+1,jj)>400)
    n = n+1;
    arrays = [arrays;ii+1,jj,bochang_three(ii+1,jj)];
end
if(bochang_three(ii+2,jj)<490&&bochang_three(ii+2,jj)>400)
    n = n+1;
    arrays = [arrays;ii+2,jj,bochang_three(ii+2,jj)];
end
if(bochang_three(ii,jj+1)<490&&bochang_three(ii,jj+1)>400)
    n = n+1;
    arrays = [arrays;ii,jj+1,bochang_three(ii,jj+1)];
end
if(bochang_three(ii,jj+2)<490&&bochang_three(ii,jj+2)>400)
    n = n+1;
    arrays = [arrays;ii,jj+2,bochang_three(ii,jj+2)];
end
if(bochang_three(ii+1,jj+1)<490&&bochang_three(ii+1,jj+1)>400)
    n = n+1;
    arrays = [arrays;ii+1,jj+1,bochang_three(ii+1,jj+1)];
end
if(bochang_three(ii+1,jj+2)<490&&bochang_three(ii+1,jj+2)>400)
    n = n+1;
    arrays = [arrays;ii+1,jj+2,bochang_three(ii+1,jj+2)];
end
if(bochang_three(ii+2,jj+1)<490&&bochang_three(ii+2,jj+1)>400)
    n = n+1;
    arrays = [arrays;ii+2,jj+1,bochang_three(ii+2,jj+1)];
end
if(bochang_three(ii+2,jj+2)<490&&bochang_three(ii+2,jj+2)>400)
    n = n+1;
    arrays = [arrays;ii+2,jj+2,bochang_three(ii+2,jj+2)];
end


end

