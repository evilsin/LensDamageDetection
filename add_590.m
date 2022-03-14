function array_590 = add_590(i,j,array_590_temp,bochang_three)
%拓展490块大小，先右后左
%   此处显示详细说明
kk1 = 3;
kk2 = 3;
num = 0;
array_590 = array_590_temp;
%检测右边
while(j+kk2<=2448)
    if((bochang_three(i,j+kk2-1)>520&&bochang_three(i,j+kk2-1)<590&&bochang_three(i,j+kk2)>520&&bochang_three(i,j+kk2)<590)||(bochang_three(i+1,j+kk2-1)>520&&bochang_three(i+1,j+kk2-1)<590&&bochang_three(i+1,j+kk2)>520&&bochang_three(i+1,j+kk2)<590)||(bochang_three(i+2,j+kk2-1)>520&&bochang_three(i+2,j+kk2-1)<590&&bochang_three(i+2,j+kk2)>520&&bochang_three(i+2,j+kk2)<590))
%         kk2 = kk2+1;
        if(bochang_three(i,j+kk2)>520&&bochang_three(i,j+kk2)<590)
            array_590 = [array_590;i,j+kk2,bochang_three(i,j+kk2)];
        end
       if(bochang_three(i+1,j+kk2)>520&&bochang_three(i+1,j+kk2)<590)
            array_590 = [array_590;i+1,j+kk2,bochang_three(i+1,j+kk2)];
       end
        if(bochang_three(i+2,j+kk2)>520&&bochang_three(i+2,j+kk2)<590)
            array_590 = [array_590;i+2,j+kk2,bochang_three(i+2,j+kk2)];
        end  
         kk2 = kk2+1;
    else
        break;
        
    end
end
%检测下边
while(i+kk1<=2048)
    for t = 1:kk2
        if(bochang_three(i+kk1,j+t-1)>520&&bochang_three(i+kk1,j+t-1)<590)
            array_590 = [array_590;i+kk1,j+t-1,bochang_three(i+kk1,j+t-1)];
            num = num+1;
        end
        
    end
    if(num>=1)
        kk1 = kk1+1;
        num = 0;
    else
        break;
    end
    
end


end
