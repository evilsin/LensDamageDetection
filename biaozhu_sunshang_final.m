function [ kuai_sunshang ] = biaozhu_sunshang_final( lujin,num_zhang )
%% 数据导入
%通过输入的文件夹路径信息，导入文件夹中的图片信息
file_path = lujin;%文件夹路径
img_path_list = dir(strcat(file_path,'*.jpg'));%图片路径
img_num = length(img_path_list);%图片数量
image = [];%图片总信息四维阵
R = [];%R通道信息
G = [];%G通道信息 
B = [];%B通道信息
if img_num>0
   for j=1:img_num
      image_name = img_path_list(j).name;
      image_temp = imread(strcat(file_path,image_name));%依次读取图片
      R(:,:,j) = image_temp(:,:,1);
      G(:,:,j) = image_temp(:,:,2);
      B(:,:,j) = image_temp(:,:,3);
      image(:,:,:,j) = image_temp;     
   end
end
%% 图片信息处理 
%将每一张图片减去第一张图片的数据保存下来作为后面的去噪提供信息进行处理，T表示deta
for i=1:img_num-1
    TR(:,:,i) = R(:,:,i+1)-R(:,:,1);
    TG(:,:,i) = G(:,:,i+1)-G(:,:,1);
    TB(:,:,i) = B(:,:,i+1)-B(:,:,1);
end
%各通道分离处理
TR1 = TR(:,:,1);
TR2 = TR(:,:,2);
TR3 = TR(:,:,3);
TR4 = TR(:,:,4);
TR5 = TR(:,:,5);
TG1 = TG(:,:,1);
TG2 = TG(:,:,2);
TG3 = TG(:,:,3);
TG4 = TG(:,:,4);
TG5 = TG(:,:,5);
TB1 = TB(:,:,1);
TB2 = TB(:,:,2);
TB3 = TB(:,:,3);
TB4 = TB(:,:,4);
TB5 = TB(:,:,5);
% 确定阈值去噪的比例系数
b_rate = 0.99;
%求R通道的阈值yu_r
yu_r = 1;
pinshu = 0;
[m,n] = size(TR1);
pinshu_sum = m*n;
while pinshu<b_rate*pinshu_sum
    pinshu = 0;
    for i = 1:2048
       for j = 1:2448
          if(abs(TR1(i,j))<yu_r)
              pinshu = pinshu+1;
          end
       end
    end
    yu_r = yu_r+1;
end

%求G通道的阈值yu_g
yu_g = 1;
pinshu = 0;
[m,n] = size(TG1);
pinshu_sum = m*n;
while pinshu<b_rate*pinshu_sum
    pinshu = 0;
    for i = 1:2048
       for j = 1:2448
          if(abs(TG1(i,j))<yu_g)
              pinshu = pinshu+1;
          end
       end
    end
    yu_g = yu_g+1;
end
%求B通道的阈值yu_b
yu_b = 1;
pinshu = 0;
[m,n] = size(TB1);
pinshu_sum = m*n;
while pinshu<b_rate*pinshu_sum
    pinshu = 0;
    for i = 1:2048
       for j = 1:2448
          if(abs(TB1(i,j))<yu_b)
              pinshu = pinshu+1;
          end
       end
    end
    yu_b = yu_b+1;
end
%% 利用阈值去噪
yuzhi_r = yu_r;
yuzhi_g = yu_g;
yuzhi_b = yu_b;
%依次对五张图片处理
TR11 = TR1;
TG11 = TG1;
TB11 = TB1;
[xx,yy] = size(TR11);
for i = 1:xx
    for j = 1:yy
        if(TR11(i,j)<yuzhi_r && TG11(i,j)<yuzhi_g && TB11(i,j)<yuzhi_b)%确定去噪条件，如果三个通道都小于阈值，则作为噪声处理
            TR11(i,j) = 0;
            TG11(i,j) = 0;
            TB11(i,j) = 0;
        end
    end 
end

TR22 = TR2;
TG22 = TG2;
TB22 = TB2;
[xx,yy] = size(TR22);
for i = 1:xx
    for j = 1:yy
        if(TR22(i,j)<yuzhi_r && TG22(i,j)<yuzhi_g && TB22(i,j)<yuzhi_b)
            TR22(i,j) = 0;
            TG22(i,j) = 0;
            TB22(i,j) = 0;
        end
    end 
end

TR33 = TR3;
TG33 = TG3;
TB33 = TB3;
[xx,yy] = size(TR33);
for i = 1:xx
    for j = 1:yy
        if(TR33(i,j)<yuzhi_r && TG33(i,j)<yuzhi_g && TB33(i,j)<yuzhi_b)
            TR33(i,j) = 0;
            TG33(i,j) = 0;
            TB33(i,j) = 0;
        end
    end 
end

TR44 = TR4;
TG44 = TG4;
TB44 = TB4;
[xx,yy] = size(TR44);
for i = 1:xx
    for j = 1:yy
        if(TR44(i,j)<yuzhi_r && TG44(i,j)<yuzhi_g && TB44(i,j)<yuzhi_b)
            TR44(i,j) = 0;
            TG44(i,j) = 0;
            TB44(i,j) = 0;
        end
    end 
end

TR55 = TR5;
TG55 = TG5;
TB55 = TB5;
[xx,yy] = size(TR55);
for i = 1:xx
    for j = 1:yy
        if(TR55(i,j)<yuzhi_r && TG55(i,j)<yuzhi_g && TB55(i,j)<yuzhi_b)
            TR55(i,j) = 0;
            TG55(i,j) = 0;
            TB55(i,j) = 0;
        end
    end 
end
%% 提取坐标序列，提取出去完噪依然存在的点在原图中各点,主要取第2.3.4.5.6张图像
R2 = R(:,:,2);
R3 = R(:,:,3);
R4 = R(:,:,4);
R5 = R(:,:,5);
R6 = R(:,:,6);
[xx,yy] = size(R2);
for i = 1:xx
    for j = 1:yy
        if(R4(i,j)*TR33(i,j)==0)
            R4(i,j) = 0;
        end
    end
    
end

for i = 1:xx
    for j = 1:yy
        if(R5(i,j)*TR44(i,j)==0)
            R5(i,j) = 0;
        end
    end
    
end

for i = 1:xx
    for j = 1:yy
        if(R3(i,j)*TR22(i,j)==0)
            R3(i,j) = 0;
        end
    end
    
end
for i = 1:xx
    for j = 1:yy
        if(R2(i,j)*TR11(i,j)==0)
            R2(i,j) = 0;
        end
    end
    
end
G2 = G(:,:,2);
G3 = G(:,:,3);
G4 = G(:,:,4);
G5 = G(:,:,5);
for i = 1:xx
    for j = 1:yy
        if(G2(i,j)*TG11(i,j)==0)
            G2(i,j) = 0;
        end
    end
    
end
for i = 1:xx
    for j = 1:yy
        if(G3(i,j)*TG22(i,j)==0)
            G3(i,j) = 0;
        end
    end
    
end
for i = 1:xx
    for j = 1:yy
        if(G4(i,j)*TG33(i,j)==0)
            G4(i,j) = 0;
        end
    end
    
end
for i = 1:xx
    for j = 1:yy
        if(G5(i,j)*TG44(i,j)==0)
            G5(i,j) = 0;
        end
    end
    
end
B2 = B(:,:,2);
B3 = B(:,:,3);
B4 = B(:,:,4);
B5 = B(:,:,5);
for i = 1:xx
    for j = 1:yy
        if(B2(i,j)*TB11(i,j)==0)
            B2(i,j) = 0;
        end
    end
    
end
for i = 1:xx
    for j = 1:yy
        if(B3(i,j)*TB22(i,j)==0)
            B3(i,j) = 0;
        end
    end
    
end
for i = 1:xx
    for j = 1:yy
        if(B4(i,j)*TB33(i,j)==0)
            B4(i,j) = 0;
        end
    end
    
end
for i = 1:xx
    for j = 1:yy
        if(B5(i,j)*TB44(i,j)==0)
            B5(i,j) = 0;
        end
    end
    
end
% 处理为0项
for i = 1:xx
    for j = 1:yy
        if(B4(i,j)*G4(i,j)*R4(i,j)==0)
            B4(i,j) = 0;
            G4(i,j) = 0;
            R4(i,j) = 0;
        end
    end
    
end
for i = 1:xx
    for j = 1:yy
        if(B2(i,j)*G2(i,j)*R2(i,j)==0)
            B2(i,j) = 0;
            G2(i,j) = 0;
            R2(i,j) = 0;
        end
    end
    
end
for i = 1:xx
    for j = 1:yy
        if(B3(i,j)*G3(i,j)*R3(i,j)==0)
            B3(i,j) = 0;
            G3(i,j) = 0;
            R3(i,j) = 0;
        end
    end
    
end
for i = 1:xx
    for j = 1:yy
        if(B5(i,j)*G5(i,j)*R5(i,j)==0)
            B5(i,j) = 0;
            G5(i,j) = 0;
            R5(i,j) = 0;
        end
    end
    
end
%% 波长与比例关系表
% 绘制CCD典型光谱响应曲线
x  = 400:1:750;
y_r = 0.67*exp(-4*log(2)*((x-620)/65).^2);
y_g = 0.56*exp(-4*log(2)*((x-525)/85).^2);
y_b = 0.2*exp(-4*log(2)*((x-440)/50).^2);
figure();
plot(x,y_r,'r-')
hold on
plot(x,y_g,'g-');
plot(x,y_b,'b-');
biao = [];
%建立波长比例关系表
for i = 1:351
    linshi = [y_r(i),y_g(i),y_b(i)];
    [s,index] = sort(linshi,'descend');
    temp = s(1)/s(2);
    biao = [biao;temp index i+399];
end
%% 饱和度特征，对五张图像依次通过三通道灰度值提取饱和度特征
img_gq_2 = [R2,G2,B2];
for i = 1:2048
    for j = 1:2448
        temp = min([img_gq_2(i,j),img_gq_2(i,j+2448),img_gq_2(i,j+4896)]);
        img_gq_2(i,j) = img_gq_2(i,j)-temp;
        img_gq_2(i,j+2448) = img_gq_2(i,j+2448)-temp;
        img_gq_2(i,j+4896) = img_gq_2(i,j+4896)-temp;
    end
end
img_gq_3 = [R3,G3,B3];
for i = 1:2048
    for j = 1:2448
        temp = min([img_gq_3(i,j),img_gq_3(i,j+2448),img_gq_3(i,j+4896)]);
        img_gq_3(i,j) = img_gq_3(i,j)-temp;
        img_gq_3(i,j+2448) = img_gq_3(i,j+2448)-temp;
        img_gq_3(i,j+4896) = img_gq_3(i,j+4896)-temp;
    end
end
img_gq_4 = [R4,G4,B4];
for i = 1:2048
    for j = 1:2448
        temp = min([img_gq_4(i,j),img_gq_4(i,j+2448),img_gq_4(i,j+4896)]);
        img_gq_4(i,j) = img_gq_4(i,j)-temp;
        img_gq_4(i,j+2448) = img_gq_4(i,j+2448)-temp;
        img_gq_4(i,j+4896) = img_gq_4(i,j+4896)-temp;
    end
end
img_gq_5 = [R5,G5,B5];
for i = 1:2048
    for j = 1:2448
        temp = min([img_gq_5(i,j),img_gq_5(i,j+2448),img_gq_5(i,j+4896)]);
        img_gq_5(i,j) = img_gq_5(i,j)-temp;
        img_gq_5(i,j+2448) = img_gq_5(i,j+2448)-temp;
        img_gq_5(i,j+4896) = img_gq_5(i,j+4896)-temp;
    end
end
%% 将饱和度特征求出比例与波长比例表配对，将灰度值转化为波长特征
% 提取样本所有特征
linshi = [];
bili4 = [];
xulie4 = [];
for i = 1:2048
    for j = 1:2448
        linshi = [img_gq_4(i,j),img_gq_4(i,j+2448),img_gq_4(i,j+4896)];
        [s,index] = sort(linshi,'descend');
        temp = s(1)/s(2);
        bili4(i,j) = temp;%储存比例信息
        sulie4(i,j) = index(1)*100+index(2)*10+index(3);%储存三通道灰度值大小特征
    end
end

linshi = [];
bili5 = [];
xulie5 = [];
for i = 1:2048
    for j = 1:2448
        linshi = [img_gq_5(i,j),img_gq_5(i,j+2448),img_gq_5(i,j+4896)];
        [s,index] = sort(linshi,'descend');
        temp = s(1)/s(2);
        bili5(i,j) = temp;
        sulie5(i,j) = index(1)*100+index(2)*10+index(3);
    end
end

linshi = [];
bili3 = [];
xulie3 = [];
for i = 1:2048
    for j = 1:2448
        linshi = [img_gq_3(i,j),img_gq_3(i,j+2448),img_gq_3(i,j+4896)];
        [s,index] = sort(linshi,'descend');
        temp = s(1)/s(2);
        bili3(i,j) = temp;
        sulie3(i,j) = index(1)*100+index(2)*10+index(3);
    end
end

linshi = [];
bili2 = [];
xulie2 = [];
for i = 1:2048
    for j = 1:2448
        linshi = [img_gq_2(i,j),img_gq_2(i,j+2448),img_gq_2(i,j+4896)];
        [s,index] = sort(linshi,'descend');
        temp = s(1)/s(2);
        bili2(i,j) = temp;
        sulie2(i,j) = index(1)*100+index(2)*10+index(3);
    end
end
% 筛除nan inf，删除比例为0或者无穷大的点
dianji5 = [];
for i = 1:2048
   for j = 1:2448
       if isnan(bili5(i,j))|| isinf(bili5(i,j))
       else
            tempp = [i,j,bili5(i,j),sulie5(i,j)];
           dianji5 = [dianji5;tempp];   
       end
   end
end

dianji4 = [];
for i = 1:2048
   for j = 1:2448
       if isnan(bili4(i,j))|| isinf(bili4(i,j))
       else
            tempp = [i,j,bili4(i,j),sulie4(i,j)];
           dianji4 = [dianji4;tempp];   
       end
   end
end

dianji3 = [];
for i = 1:2048
   for j = 1:2448
       if isnan(bili3(i,j))|| isinf(bili3(i,j))
       else
            tempp = [i,j,bili3(i,j),sulie3(i,j)];
           dianji3 = [dianji3;tempp];   
       end
   end
end

dianji2 = [];
for i = 1:2048
   for j = 1:2448
       if isnan(bili2(i,j))|| isinf(bili2(i,j))
       else
            tempp = [i,j,bili2(i,j),sulie2(i,j)];
           dianji2 = [dianji2;tempp];   
       end
   end
end
% 配对确定点集坐标点波长
my_biao = [400 410 21.0591 24.3372 321;
    411 420 15.7620 21.0592 321;
    421 430 10.2044 15.7620 321;
    431 440 5.7143  10.2044 321;
    441 450 2.7678 5.7143 321;
    451 461 1.0546 2.7678 321;
    462 472 2.7678 2.9663 231;
    473 483 2.9663 11.0595 231;
    484 494 11.0595 49.1454 231;
    495 505 49.1454 260.2895 231;
    506 514 260.2895 1160.1 231;
    515 525 260.2895 312.0524 213;
    526 535 92.1645 260.2895 213;
    536 545 28.7453 92.1645 213;
    546 555 9.4676 28.7453 213;
    556 565 3.2929 9.4674 213;
    566 576 1.0000 3.2929 213;
    577 587 0.9999 2.5596 123;
    588 598 2.5596 6.7310 123;
    599 609 6.7310 16.5713 123;
    610 620 16.5713 38.1940 123;
    621 630 38.1940 77.0576 123;
    631 640 77.0576 147.2206 123;
    641 650 147.2206 251.6344 123;
    651 659 251.6344 433.4652 123;
    660 669 433.4652 707.0834 123;
    670 679 707.0834 1092.2 123;
    680 689 1092.2 1597.7 123;
    690 699 1597.7 2213.2 123;
    700 709 2213.2 2903.1 123;
    710 719 2903.1 3606.1 123;
    720 729 3606.1 4241.8 123;
    730 739 4241.8 4724.9 123;
    740 750 4724.9 4995.5 123];
[p,q] = size(my_biao);
[m,n] = size(dianji5);
%储存波长信息
for i = 1:m
    for j = 1:p
        if dianji5(i,3)>my_biao(j,3)&&dianji5(i,3)<=my_biao(j,4)&&dianji5(i,4)==my_biao(j,5)
            dianji5(i,5) = my_biao(j,1);
            dianji5(i,6) = my_biao(j,2);
        end
    end
end

[m,n] = size(dianji4);
for i = 1:m
    for j = 1:p
        if dianji4(i,3)>my_biao(j,3)&&dianji4(i,3)<=my_biao(j,4)&&dianji4(i,4)==my_biao(j,5)
            dianji4(i,5) = my_biao(j,1);
            dianji4(i,6) = my_biao(j,2);
        end
    end
end

[m,n] = size(dianji3);
for i = 1:m
    for j = 1:p
        if dianji3(i,3)>my_biao(j,3)&&dianji3(i,3)<=my_biao(j,4)&&dianji3(i,4)==my_biao(j,5)
            dianji3(i,5) = my_biao(j,1);
            dianji3(i,6) = my_biao(j,2);
        end
    end
end

[m,n] = size(dianji2);
for i = 1:m
    for j = 1:p
        if dianji2(i,3)>my_biao(j,3)&&dianji2(i,3)<=my_biao(j,4)&&dianji2(i,4)==my_biao(j,5)
            dianji2(i,5) = my_biao(j,1);
            dianji2(i,6) = my_biao(j,2);
        end
    end
end
%% 标准化点集,建立后续使用的波长分布变量bochang_dianji
% load('rgbz_dianji.mat')
% C为标注点集
bochang_dianji_zero5 = dianji5(:,[1 2 5]);%简化dinaji数据，将坐标信息和波长信息提取出来
bochang_dianji5 = [];
zzz = 0;
[m,n] = size(bochang_dianji_zero5);
%提取符合正常波段的点集的过程
for i=1:m
    if bochang_dianji_zero5(i,3)>=400
        bochang_dianji5(i-zzz,1) = bochang_dianji_zero5(i,1);
        bochang_dianji5(i-zzz,2) = bochang_dianji_zero5(i,2);
        bochang_dianji5(i-zzz,3) = bochang_dianji_zero5(i,3);
    else
        zzz = zzz+1;
    end
end

bochang_dianji_zero4 = dianji4(:,[1 2 5])
bochang_dianji4 = [];
zzz = 0;
[m,n] = size(bochang_dianji_zero4);
for i=1:m
    if bochang_dianji_zero4(i,3)>=400
        bochang_dianji4(i-zzz,1) = bochang_dianji_zero4(i,1);
        bochang_dianji4(i-zzz,2) = bochang_dianji_zero4(i,2);
        bochang_dianji4(i-zzz,3) = bochang_dianji_zero4(i,3);
    else
        zzz = zzz+1;
    end
end

bochang_dianji_zero3 = dianji3(:,[1 2 5]);
bochang_dianji3 = [];
zzz = 0;
[m,n] = size(bochang_dianji_zero3);
for i=1:m
    if bochang_dianji_zero3(i,3)>=400
        bochang_dianji3(i-zzz,1) = bochang_dianji_zero3(i,1);
        bochang_dianji3(i-zzz,2) = bochang_dianji_zero3(i,2);
        bochang_dianji3(i-zzz,3) = bochang_dianji_zero3(i,3);
    else
        zzz = zzz+1;
    end
end

bochang_dianji_zero2 = dianji2(:,[1 2 5]);
bochang_dianji2 = [];
zzz = 0;
[m,n] = size(bochang_dianji_zero2);
for i=1:m
    if bochang_dianji_zero2(i,3)>=400
        bochang_dianji2(i-zzz,1) = bochang_dianji_zero2(i,1);
        bochang_dianji2(i-zzz,2) = bochang_dianji_zero2(i,2);
        bochang_dianji2(i-zzz,3) = bochang_dianji_zero2(i,3);
    else
        zzz = zzz+1;
    end
end
%% 确定损伤点波长范围
%通过前面设立的波长比例表，建立每个损伤点波长范围信息
bochang_three5 = zeros(2048,2448);
[m,n] = size(bochang_dianji5);
for i = 1:m
    bochang_three5(bochang_dianji5(i,1),bochang_dianji5(i,2)) = bochang_dianji5(i,3);
end

bochang_three4 = zeros(2048,2448);
[m,n] = size(bochang_dianji4);
for i = 1:m
    bochang_three4(bochang_dianji4(i,1),bochang_dianji4(i,2)) = bochang_dianji4(i,3);
end

bochang_three3 = zeros(2048,2448);
[m,n] = size(bochang_dianji3);
for i = 1:m
    bochang_three3(bochang_dianji3(i,1),bochang_dianji3(i,2)) = bochang_dianji3(i,3);
end

bochang_three2 = zeros(2048,2448);
[m,n] = size(bochang_dianji2);
for i = 1:m
    bochang_three2(bochang_dianji2(i,1),bochang_dianji2(i,2)) = bochang_dianji2(i,3);
end
% 展现去噪以后的效果
% for i = 1:2048
%     for j = 1:2448
%         imgxxx5(i,j,1) = img_gq_5(i,j);
%         imgxxx5(i,j,2) = img_gq_5(i,j+2448);
%         imgxxx5(i,j,3) = img_gq_5(i,j+4896);
%      
%         
%     end
%     
% end
% imshow(imgxxx5)
%% 检测部分 
%% 提取出所有490块，并合并接壤的490块
%% 抓取输入的某一种图片的短波长块
k1 = 3;%初始块的行数
k2 = 3;%初始快的列数
kk = 1;
array_490_temp = [];
% array_490 = cell(10000);
arrays = [];
sunshang_490_590 = [];
if(num_zhang == 2)%通过If实现读取num_zhang输入信息，提供检测要求的数据信息
    bochang_three = bochang_three2;
    img_5 = image(:,:,:,2);
    img_guangqiang = [R2,G2,B2];
elseif(num_zhang == 3)
     bochang_three = bochang_three3;
    img_5 = image(:,:,:,3);
    img_guangqiang = [R3,G3,B3];
elseif(num_zhang == 4)
     bochang_three = bochang_three4;
    img_5 = image(:,:,:,4);
    img_guangqiang = [R4,G4,B4];
elseif(num_zhang == 5)
     bochang_three = bochang_three5;
    img_5 = image(:,:,:,5);
    img_guangqiang = [R5,G5,B5];
end
%检测短波块
for i = 1:(2048-k1+1)
  for j = 1:(2448-k2+1)
      [arrays,n] = num_490(i,j,bochang_three);%num_490为自定义小函数，实现功能为确定该点是否为满足波长为400到490范围条件，具体见函数
      if(n>=4)%如果9个里面有4个及以上则满足小块条件保存
          array_490_temp = [array_490_temp;arrays];
          tempp = add_490(i,j,array_490_temp,bochang_three);%add_490为自定义小函数，实现功能为对小块进行周围检测，将符合条件的连接的点加入块中，具体见函数
          array_490{kk} = tempp;
          [xx,yy] = size(tempp);
          for e = 1:xx
              bochang_three(tempp(e,1),tempp(e,2)) = 0;
          end
          array_490_temp = [];
          kk = kk+1;
      else
          array_490_temp = [];
      end
 
  end
end
%% 将接壤块合并
% 绘制块490
num_kuai_490 = length(array_490);
x = 1:2048;
y = 1:2448;
figure(1);
for i = 1:num_kuai_490
    kuai_temp = array_490{i};
    [x_kuai,y_kuai] = size(kuai_temp);
    left_x = min(kuai_temp(:,1));
    right_x = max(kuai_temp(:,1));
    left_y = min(kuai_temp(:,2));
    right_y = max(kuai_temp(:,2));
    center_x = (left_x+right_x)/2;
    center_y = (left_y+right_y)/2;
    radius = sqrt((right_x-left_x)^2+(right_y-left_y)^2)/2*1.2;
    draw_circle_r(center_x,center_y,radius);
    hold on
    kuai_temp(1,4) = center_x;
    kuai_temp(2,4) = center_y;
    kuai_temp(3,4) = radius;
    kuai_490_circle{i} = kuai_temp;
end
hold off;
% 合并
hebing_double = [1,1];
while(isempty(hebing_double)~=1)
    num_kuai_490_circle = length(kuai_490_circle);
    hebing_double = [];
    kuai_490_circle_hebing_temp = [];
    jilu = [];
    for i = 1:num_kuai_490_circle-1
       for j = i+1:num_kuai_490_circle 
            kuai1 = kuai_490_circle{i};
            kuai2 = kuai_490_circle{j};
          juli = sqrt((kuai1(1,4)-kuai2(1,4))^2+(kuai1(2,4)-kuai2(2,4))^2);
               if(juli<(kuai1(3,4)+kuai2(3,4)))
                   hebing_double = [hebing_double;i,j]; 
                   jilu = [jilu;i,j];
               end
       end
    end
  
 if(isempty(hebing_double)==0)
    [num_xulie1,num_xulie2] = size(hebing_double);
    
    for ii = 1:num_xulie1
        xulie_hebing1 = hebing_double(ii,1);
        xulie_hebing2 = hebing_double(ii,2);
        kuai_hebing1 = kuai_490_circle{xulie_hebing1};
        kuai_hebing2 = kuai_490_circle{xulie_hebing2};
        kuai_hebing1(:,4) = 0;
        kuai_hebing2(:,4) = 0;
        kuai_hebing_temp = [kuai_hebing1;kuai_hebing2];
        kuai_hebing_temp = unique(kuai_hebing_temp,'rows');
        left_x = min(kuai_hebing_temp(:,1));
        right_x = max(kuai_hebing_temp(:,1));
        left_y = min(kuai_hebing_temp(:,2));
        right_y = max(kuai_hebing_temp(:,2));
        center_x = (left_x+right_x)/2;
        center_y = (left_y+right_y)/2;
        radius = sqrt((right_x-left_x)^2+(right_y-left_y)^2)/2*1.2;
        kuai_hebing_temp(1,4) = center_x;
        kuai_hebing_temp(2,4) = center_y;
        kuai_hebing_temp(3,4) = radius;
%         kuai_490_circle{xulie_hebing1} = kuai_hebing_temp;
%         kuai_490_circle{xulie_hebing2} = kuai_hebing_temp;
        [dd1,dd2] = size(kuai_490_circle_hebing_temp);
        kuai_490_circle_hebing_temp{dd2+1} = kuai_hebing_temp;
       
    end 
    %删除合并块
    [jilu_x,jilu_y] = size(jilu);
    for i = 1:jilu_x
        kuai_490_circle{jilu(i,1)} = [];
        kuai_490_circle{jilu(i,2)} = [];
    end
    jilu = [];
    %增加合并块
    [temp_x,temp_y] = size(kuai_490_circle_hebing_temp);
    [kuai_circle1,kuai_circle2] = size(kuai_490_circle);
    for i = 1:temp_y
        kuai_490_circle{kuai_circle2+i} = kuai_490_circle_hebing_temp{i};
    end 
    kuai_490_circle(cellfun(@isempty,kuai_490_circle)) = [];
    %去除相同单元
    [xxx,yyy] = size(kuai_490_circle);
    for iii = 1:yyy-1
        for jjj = iii+1:yyy
            if isequal(kuai_490_circle{iii},kuai_490_circle{jjj})
                kuai_490_circle{jjj}=[];
            end
        end
    end
    kuai_490_circle(cellfun(@isempty,kuai_490_circle)) = [];
 end
end

%% 绘制合并后的490块
figure(2);
[x,y] = size(kuai_490_circle);
for i = 1:y
    temp = kuai_490_circle{i};
    draw_circle_r(temp(1,4),temp(2,4),temp(3,4));
    hold on
end
hold off

%% 求590（520-590）中长波块
k1 = 3;%初始块的行数
k2 = 3;%初始快的列数
kk = 1;
array_590_temp = [];
arrays = [];
bochang_three = bochang_three5;
for i = 1:(2048-k1+1)
  for j = 1:(2448-k2+1)
      [arrays,n] = num_590(i,j,bochang_three);
      if(n>=4)
          array_590_temp = [array_590_temp;arrays];
          tempp = add_590(i,j,array_590_temp,bochang_three);
          array_590{kk} = tempp;
          [xx,yy] = size(tempp);
          for e = 1:xx
              bochang_three(tempp(e,1),tempp(e,2)) = 0;
          end
          array_590_temp = [];
          kk = kk+1;
      else
          array_590_temp = [];
      end
 
  end
end
%% 将接壤块合并
% 绘制块590
num_kuai_590 = length(array_590);
x = 1:2048;
y = 1:2448;
figure(3);
for i = 1:num_kuai_590
    kuai_temp = array_590{i};
    [x_kuai,y_kuai] = size(kuai_temp);
    left_x = min(kuai_temp(:,1));
    right_x = max(kuai_temp(:,1));
    left_y = min(kuai_temp(:,2));
    right_y = max(kuai_temp(:,2));
    center_x = (left_x+right_x)/2;
    center_y = (left_y+right_y)/2;
    radius = sqrt((right_x-left_x)^2+(right_y-left_y)^2)/2*1.2;
    draw_circle_k(center_x,center_y,radius);
    hold on
    kuai_temp(1,4) = center_x;
    kuai_temp(2,4) = center_y;
    kuai_temp(3,4) = radius;
    kuai_590_circle{i} = kuai_temp;
end
hold off;
% 合并
hebing_double = [1,1];
while(isempty(hebing_double)~=1)
    num_kuai_590_circle = length(kuai_590_circle);
    hebing_double = [];
    kuai_590_circle_hebing_temp = [];
    jilu = [];
    for i = 1:num_kuai_590_circle-1
       for j = i+1:num_kuai_590_circle 
            kuai1 = kuai_590_circle{i};
            kuai2 = kuai_590_circle{j};
          juli = sqrt((kuai1(1,4)-kuai2(1,4))^2+(kuai1(2,4)-kuai2(2,4))^2);
               if(juli<(kuai1(3,4)+kuai2(3,4)))
                   hebing_double = [hebing_double;i,j]; 
                   jilu = [jilu;i,j];
               end
       end
    end
  
 if(isempty(hebing_double)==0)
    [num_xulie1,num_xulie2] = size(hebing_double);
    
    for ii = 1:num_xulie1
        xulie_hebing1 = hebing_double(ii,1);
        xulie_hebing2 = hebing_double(ii,2);
        kuai_hebing1 = kuai_590_circle{xulie_hebing1};
        kuai_hebing2 = kuai_590_circle{xulie_hebing2};
        kuai_hebing1(:,4) = 0;
        kuai_hebing2(:,4) = 0;
        kuai_hebing_temp = [kuai_hebing1;kuai_hebing2];
        kuai_hebing_temp = unique(kuai_hebing_temp,'rows');
        left_x = min(kuai_hebing_temp(:,1));
        right_x = max(kuai_hebing_temp(:,1));
        left_y = min(kuai_hebing_temp(:,2));
        right_y = max(kuai_hebing_temp(:,2));
        center_x = (left_x+right_x)/2;
        center_y = (left_y+right_y)/2;
        radius = sqrt((right_x-left_x)^2+(right_y-left_y)^2)/2*1.2;
        kuai_hebing_temp(1,4) = center_x;
        kuai_hebing_temp(2,4) = center_y;
        kuai_hebing_temp(3,4) = radius;
        [dd1,dd2] = size(kuai_590_circle_hebing_temp);
        kuai_590_circle_hebing_temp{dd2+1} = kuai_hebing_temp;
       
    end 
    %删除合并块
    [jilu_x,jilu_y] = size(jilu);
    for i = 1:jilu_x
        kuai_590_circle{jilu(i,1)} = [];
        kuai_590_circle{jilu(i,2)} = [];
    end
    jilu = [];
    %增加合并块
    [temp_x,temp_y] = size(kuai_590_circle_hebing_temp);
    [kuai_circle1,kuai_circle2] = size(kuai_590_circle);
    for i = 1:temp_y
        kuai_590_circle{kuai_circle2+i} = kuai_590_circle_hebing_temp{i};
    end 
    kuai_590_circle(cellfun(@isempty,kuai_590_circle)) = [];
    %去除相同单元
    [xxx,yyy] = size(kuai_590_circle);
    for iii = 1:yyy-1
        for jjj = iii+1:yyy
            if isequal(kuai_590_circle{iii},kuai_590_circle{jjj})
                kuai_590_circle{jjj}=[];
            end
        end
    end
    kuai_590_circle(cellfun(@isempty,kuai_590_circle)) = [];
 end
end

%% 绘制合并后的590块
figure(4);
[x,y] = size(kuai_590_circle);
for i = 1:y
    temp = kuai_590_circle{i};
    draw_circle_r(temp(1,4),temp(2,4),temp(3,4));
    hold on
end
hold off
%% 绘制490和590
figure(5);
[x,y] = size(kuai_490_circle);
for i = 1:y
    temp = kuai_490_circle{i};
    draw_circle_r(temp(1,4),temp(2,4),temp(3,4));
    hold on
end
[x,y] = size(kuai_590_circle);
for i = 1:y
    temp = kuai_590_circle{i};
    draw_circle_k(temp(1,4),temp(2,4),temp(3,4));
end
hold off
%% 损伤点确定
[x490,y490] = size(kuai_490_circle);
[x590,y590] = size(kuai_590_circle);
dd = 1;
cc = 1;
for i = 1:y490
   for j = 1:y590
       temp_490 = kuai_490_circle{i};
       temp_590 = kuai_590_circle{j};
       juli = sqrt((temp_490(1,4)-temp_590(1,4))^2+(temp_490(2,4)-temp_590(2,4))^2);
       flag = 0;
       if(juli<(temp_490(3,4)+temp_590(3,4)))
           flag = flag+1;
            %引入第二判据，光强,应该是随着波长递增的
            %计算490波长的中心光强
            center_x_490 = sum(temp_490(:,1))/length(temp_490(:,1));
            center_y_490 = sum(temp_490(:,2))/length(temp_490(:,2));
            for ii = 1:length(temp_490(:,1))
                center_juli = (temp_490(ii,1)-center_x_490)^2+(temp_490(ii,2)-center_y_490)^2;
                temp_490(ii,5) = center_juli;
            end
            [min_value,min_hangshu] = min(temp_490(:,5),[],1);
            center_x_490 = temp_490(min_hangshu,1);
            center_y_490 = temp_490(min_hangshu,2);
            %img_gq在程序最开头定义
            guangqiang_490 = min([img_guangqiang(center_x_490,center_y_490),img_guangqiang(center_x_490,center_y_490+2448),img_guangqiang(center_x_490,center_y_490+4896)]);
            %计算590波长的中心光强
            center_x_590 = sum(temp_590(:,1))/length(temp_590(:,1));
            center_y_590 = sum(temp_590(:,2))/length(temp_590(:,2));
            for iii = 1:length(temp_590(:,1))
                center_juli = (temp_590(iii,1)-center_x_590)^2+(temp_590(iii,2)-center_y_590)^2;
                temp_590(iii,5) = center_juli;
            end
            [min_value,min_hangshu] = min(temp_590(:,5),[],1);
            center_x_590 = temp_590(min_hangshu,1);
            center_y_590 = temp_590(min_hangshu,2);
            guangqiang_590 = min([img_guangqiang(center_x_590,center_y_590),img_guangqiang(center_x_590,center_y_590+2448),img_guangqiang(center_x_590,center_y_590+4896)]);
            %比较得出结论
           if(guangqiang_490>guangqiang_590)%判断为损伤
              %为损伤，开始合并损伤块
              
              temp_490(:,5) = [];
              temp_590(:,5) = [];
              temp_490(:,4) = [];
              temp_590(:,4) = [];
              sunshang_temp = [temp_490;temp_590];
              left_x = min(sunshang_temp(:,1));
              right_x = max(sunshang_temp(:,1));
              left_y = min(sunshang_temp(:,2));
              right_y = max(sunshang_temp(:,2));
              center_x = (left_x+right_x)/2;
              center_y = (left_y+right_y)/2;
              radius = sqrt((right_x-left_x)^2+(right_y-left_y)^2)/2*1.2;
              sunshang_temp(1,4) = center_x;
              sunshang_temp(2,4) = center_y;
              sunshang_temp(3,4) = radius;
              sunshang_490_590{cc} = sunshang_temp;
              cc = cc+1;
           end
       end
   end
   if(flag == 0)
       %记录小损伤
       sunshang_490{dd} = temp_490;
       dd = dd+1;
   else
       flag = 0;
   end
   
end
%合并490_590重叠损伤，确定490590接壤块
hebing_double = [1,1];
while(isempty(hebing_double)~=1)
    %num_kuai_490_circle = length(kuai_490_circle);
    num_sunshang_490_590 = length(sunshang_490_590);
    hebing_double = [];
    sunshang_490_590_hebing_temp = [];
    jilu = [];
    for i = 1:num_sunshang_490_590-1
       for j = i+1:num_sunshang_490_590 
            kuai1 = sunshang_490_590{i};
            kuai2 = sunshang_490_590{j};
          juli = sqrt((kuai1(1,4)-kuai2(1,4))^2+(kuai1(2,4)-kuai2(2,4))^2);
               if(juli<(kuai1(3,4)+kuai2(3,4)))
                   hebing_double = [hebing_double;i,j]; 
                   jilu = [jilu;i,j];
               end
       end
    end
  
 if(isempty(hebing_double)==0)
    [num_xulie1,num_xulie2] = size(hebing_double);
    
    for ii = 1:num_xulie1
        xulie_hebing1 = hebing_double(ii,1);
        xulie_hebing2 = hebing_double(ii,2);
        kuai_hebing1 = sunshang_490_590{xulie_hebing1};
        kuai_hebing2 = sunshang_490_590{xulie_hebing2};
        kuai_hebing1(:,4) = 0;
        kuai_hebing2(:,4) = 0;
        kuai_hebing_temp = [kuai_hebing1;kuai_hebing2];
        kuai_hebing_temp = unique(kuai_hebing_temp,'rows');
        left_x = min(kuai_hebing_temp(:,1));
        right_x = max(kuai_hebing_temp(:,1));
        left_y = min(kuai_hebing_temp(:,2));
        right_y = max(kuai_hebing_temp(:,2));
        center_x = (left_x+right_x)/2;
        center_y = (left_y+right_y)/2;
        radius = sqrt((right_x-left_x)^2+(right_y-left_y)^2)/2*1.2;
        kuai_hebing_temp(1,4) = center_x;
        kuai_hebing_temp(2,4) = center_y;
        kuai_hebing_temp(3,4) = radius;
%         kuai_490_circle{xulie_hebing1} = kuai_hebing_temp;
%         kuai_490_circle{xulie_hebing2} = kuai_hebing_temp;
        [dd1,dd2] = size(sunshang_490_590_hebing_temp);
       sunshang_490_590_hebing_temp{dd2+1} = kuai_hebing_temp;
       
    end 
    %删除合并块
    [jilu_x,jilu_y] = size(jilu);
    for i = 1:jilu_x
        sunshang_490_590{jilu(i,1)} = [];
        sunshang_490_590{jilu(i,2)} = [];
    end
    jilu = [];
    %增加合并块
    [temp_x,temp_y] = size(sunshang_490_590_hebing_temp);
    [kuai_circle1,kuai_circle2] = size(sunshang_490_590);
    for i = 1:temp_y
        sunshang_490_590{kuai_circle2+i} = sunshang_490_590_hebing_temp{i};
    end 
    sunshang_490_590(cellfun(@isempty,sunshang_490_590)) = [];
    %去除相同单元
    [xxx,yyy] = size(sunshang_490_590);
    for iii = 1:yyy-1
        for jjj = iii+1:yyy
            if isequal(sunshang_490_590{iii},sunshang_490_590{jjj})
               sunshang_490_590{jjj}=[];
            end
        end
    end
   sunshang_490_590(cellfun(@isempty,sunshang_490_590)) = [];
 end
end

%合并得总的损伤块
kuai_sunshang = [sunshang_490,sunshang_490_590];
sunshang_qc_jilu = [];
sunshang_bl_jilu = [];
  [xxx,yyy] = size(kuai_sunshang);
    for iii = 1:yyy-1
        for jjj = iii+1:yyy
            sunshang_temp1 = kuai_sunshang{iii};
            sunshang_temp2 = kuai_sunshang{jjj};
            sunshang_juli = sqrt((sunshang_temp1(1,4)-sunshang_temp2(1,4))^2+(sunshang_temp1(2,4)-sunshang_temp2(2,4))^2);
            
            if (abs(sunshang_temp1(3,4)-sunshang_temp2(3,4)))> sunshang_juli
                if(sunshang_temp1(3,4)<sunshang_temp2(3,4))
               sunshang_qc_jilu = [sunshang_qc_jilu,iii];
               sunshang_bl_jilu = [sunshang_bl_jilu,jjj];
                else
                   sunshang_qc_jilu = [sunshang_qc_jilu,jjj];
                   sunshang_bl_jilu = [sunshang_bl_jilu,iii];
                end
            end
        end
    end
    for i = 1:length(sunshang_qc_jilu)
        kuai_sunshang{sunshang_qc_jilu(i)} = [];
    end
   kuai_sunshang(cellfun(@isempty,kuai_sunshang)) = [];                                                                                         
%绘制损伤
figure(6);
[x,y] = size(kuai_sunshang);
for i = 1:y
    temp = kuai_sunshang{i};
    draw_circle_r(temp(1,4),temp(2,4),temp(3,4));
    hold on
end
hold off
%% 在原图中绘制出损伤块
 figure(7);
imshow(img_5/256);
hold on;
[x,y] = size(kuai_sunshang);
for i = 1:y
    temp = kuai_sunshang{i};
    if(temp(3,4)>3)%将半径很小的随机噪声点去掉
    draw_circle_r(temp(2,4),temp(1,4),temp(3,4));
    end
end
hold off;
end

 
