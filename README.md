# LensDamageDetection
【项目背景】

 随着高功率固体激光驱动器的建设光学元件损伤成为了当今的一个难题。目前激光驱动器上使用的大口径光学元件材料稀缺,加工工艺复杂,成本很高,极难获取,因而非常昂贵和珍贵,高通量运行条件下,如果不加控制,激光诱发的损伤很快就会使元件报废,造成激光驱动器运行成本的急剧增加,可运行发次的大量减少,极大地影响装置的效用。因此了解元件在使用过程中的损伤过程，避免元件急剧的损伤，在元件发生报废之前停止工作，拿去维护修理，防止出现不可修复的灾难性损伤，既极大地降低了研究成本，又保障了设备高效可靠的运行。
 
【国内外的研究现状】

目前激光驱动器上使用的大口径光学元件材料稀缺,加工工艺复杂,成本很高,极难获取,因而非常昂贵和珍贵,高通量运行条件下,如果不加控制,激光诱发的损伤很快就会使元件报废,造成激光驱动器运行成本的急剧增加,可运行发次的大量减少,极大地影响装置的效用。因此了解元件在使用过程中的损伤过程，避免元件急剧的损伤，在元件发生报废之前停止工作，拿去维护修理，防止出现不可修复的灾难性损伤，既极大地降低了研究成本，又保障了设备高效可靠的运行。LLNL在2007年报道了其建立在NIF上的终端损伤在线检测系统（FODI），FODI使用高分辨CCD摄像机读出数据，按照要求要能够探测和追踪所有终端集成光机组件光学元件上直径大于50微米以上的缺陷的发展变化。该检测受限于CCD尺寸的大小。国内对光学元件损伤检测主要集中在离线光学表面的缺陷和损伤阈值测量。随着高功率ICF激光驱动器的建设，国内也开展了大口径光学元件损伤在线检测研究。2002年上海光机所黄惠杰等研制了一套光学元件在线检测样机，由于该样机采用偏振消光暗场成像，受限于布鲁斯特角放置的钕玻璃起偏和检偏作用，无法实现暗场成像，采用明场成像获得的损伤图像对比度较低，损伤点的尺度无法准确测量。2006年，重庆大学的谢志江等研制了基于暗场显微成像的元件疵病检测系统，该系统分辨力较高，但是系统的工作距非常小，视场也很小。  

提出了一种自适应损伤检测算法，并描述了暗场成像和损伤特征机理，该算法采取差值去噪和阈值去噪结合完成噪声滤除，再进行波长变换，将损伤特征转化到波长域，设计 的检测窗遍历待检测图像得到单位波块，再进行自然生长和重叠检测，使得单位波块扩展为独立的最小单元。最后利用损伤特征的两大判据判断损伤区域。实验结果表明该ADD算法检测速度快，准确率高，分类准确率要优于KNN和SVM，能够高效地完成大口径透镜在强激光下的损伤检测任务。

![image](https://user-images.githubusercontent.com/30195788/158142555-550c8613-5a9c-4b3e-b223-e95c8a002cab.png)

![image](https://user-images.githubusercontent.com/30195788/158142433-4aa58b56-6793-45fd-8b64-b57bb246755a.png)

![image](https://user-images.githubusercontent.com/30195788/158142332-c753ef66-acea-4a0b-86bc-dc869fb49c5d.png)

![image](https://user-images.githubusercontent.com/30195788/158142399-da10eef5-aa06-4fc2-bd46-f0e8ede8f2c1.png)
