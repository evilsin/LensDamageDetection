function array_490 = add_490(i,j,array_490_temp,bochang_three)
%��չ490���С�����Һ���
%   �˴���ʾ��ϸ˵��
kk1 = 3;
kk2 = 3;
num = 0;
array_490 = array_490_temp;
%����ұ�
while(j+kk2<=2448)
    if((bochang_three(i,j+kk2-1)>400&&bochang_three(i,j+kk2-1)<490&&bochang_three(i,j+kk2)>400&&bochang_three(i,j+kk2)<490)||(bochang_three(i+1,j+kk2-1)>400&&bochang_three(i+1,j+kk2-1)<490&&bochang_three(i+1,j+kk2)>400&&bochang_three(i+1,j+kk2)<490)||(bochang_three(i+2,j+kk2-1)>400&&bochang_three(i+2,j+kk2-1)<490&&bochang_three(i+2,j+kk2)>400&&bochang_three(i+2,j+kk2)<490))
             % kk2 = kk2+1;     
        if(bochang_three(i,j+kk2)>400&&bochang_three(i,j+kk2)<490)
            array_490 = [array_490;i,j+kk2,bochang_three(i,j+kk2)];
        end
       if(bochang_three(i+1,j+kk2)>400&&bochang_three(i+1,j+kk2)<490)
            array_490 = [array_490;i+1,j+kk2,bochang_three(i+1,j+kk2)];
       end
        if(bochang_three(i+2,j+kk2)>400&&bochang_three(i+2,j+kk2)<490)
            array_490 = [array_490;i+2,j+kk2,bochang_three(i+2,j+kk2)];
        end  
         kk2 = kk2+1;
    else
        break;
        
    end
end
%����±�
while(i+kk1<=2048)
    for t = 1:kk2
        if(bochang_three(i+kk1,j+t-1)>400&&bochang_three(i+kk1,j+t-1)<490)
            array_490 = [array_490;i+kk1,j+t-1,bochang_three(i+kk1,j+t-1)];
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
