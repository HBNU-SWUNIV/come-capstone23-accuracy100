# %%
import os
import cv2
import torch
import torch.nn as nn
import torch.nn.functional as F
# import tensorflow as tf
import numpy as np
# import matplotlib.pyplot as plt
# import time
import natsort
from collections import defaultdict
# from numba import jit

os.environ['TF_CPP_MIN_LOG_LEVEL']='2'

# @jit(nopython=False)
def detecttext_mat(filename):
    # 옮겨서 저장하는 과정에서 resize 진행 

    test_img = cv2.imread("".join(["./image/DBimg/",filename]))
    test_img = cv2.resize(test_img,(1500,2000))
    test_img = cv2.dilate(test_img, np.ones((3, 3), np.uint8), iterations=1)
    test_img = cv2.erode(test_img, np.ones((3, 3), np.uint8), iterations=1)
    test_img = np.where(test_img > 110, 255,0)
    cv2.imwrite("savetest.jpg", test_img)

    # 글자 영역 넓게 지정 
    text_area_box = [
        [0, 700, 0, 250],  
        [0, 300, 0, 2000],
        [500, 750, 750, 1000 ],
        [1000, 1250, 750, 1000 ],
        [700, 1000, 1100, 1600],
        [0,1500,1700,2000]
    ]

    tmp_img = cv2.imread("savetest.jpg")

    ############ [Step 1] 숫자 검출 ###############
    # 글자영역에 생기는 box 제거 
    # box안에 생기는 box 제거 (ex. 0의 경우)
    # 히스토그램 평활화, CLAHE, 
    image = tmp_img
    img_gray = cv2.cvtColor(tmp_img, cv2.COLOR_BGR2GRAY)
    ret, img_binary = cv2.threshold(img_gray, 127, 255, cv2.THRESH_BINARY)
    contours, hierarchy = cv2.findContours(img_binary, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    filtered_contours = []
    counti=0
    for cnt in contours: 
        x, y, w, h = cv2.boundingRect(cnt) 
        if w*h < 500 or w*h > 15000: 
            continue 

        is_inside = False
        for other_cnt in contours :
            ox, oy, ow, oh = cv2.boundingRect(other_cnt)
            # 현재 사각형이 다른 사각형에 포함되어 있는지 확인
            is_inside = ox < x < ox + ow and oy < y < oy + oh and ox < x + w < ox + ow and oy < y + h < oy + oh and (ow*oh>500 and ow*oh<15000)
            if is_inside:
                break

        in_txt_area = False
        for txt_area in text_area_box :
            x1, x2, y1, y2 = txt_area
            # 글자영역에 있는지 확인 
            in_txt_area = x1 <= x <= x2 and y1 <= y <= y2 and x1 <= x + w <= x2 and y1 <= y + h <= y2 
            if in_txt_area :
                break
        
        if not is_inside and not in_txt_area :
            filtered_contours.append([x,y,w,h])

        # img_cp = image[:]
        # bbox_list=[] 
        counti+=1
        for cnt in filtered_contours:
            o_x, o_y, w, h = cnt 
            if w < 40 :
                if o_x > 30 :
                    x = o_x - 30 
                    w += 30
                else :
                    x = o_x
            else:
                if o_x > 10 :
                    x = o_x - 10 
                else : 
                    x = o_x 
            y = o_y - 10
            if (h+15) > 180 or h <50 :
                continue
            if w > 150 :
                continue
            # cv2.rectangle(img_cp, (x, y), (x+w+15, y+h+15), (0, 0, 255), 2)
            # bbox_list.append([x+1,x+w+15,y+1,y+h+15])

            # cv2.rectangle(img_cp, (x, y), (x+w+15, y+h+15), (0, 0, 255), 1) 
            # cv2.imwrite(f'image/crop_img/{x+1}_{x+w+15}_{y+1}_{y+h+15}.jpg',image[y+1:y+h+15,x+1:x+w+15])
            
            ## 다혜추가 -> 크롭된이미지저장할때 이름지정하고싶어 한거임
  
            name = 99
            if(y<100):
                name = 1
            elif(100<y<300):
                if(x<500):
                    name = 2
                elif(500<x<1000):
                    name = 3
                else:
                    name = 4
            elif(300<y<400):
                if(x<500):
                    name = 5
                elif(500<x<1000):
                    name = 6
                else:
                    name = 7                
            elif(400<y<600):
                if(x<800):
                    name = 8
                else:
                    name = 9
            elif(600<y<700):
                if(x<800):
                    name = 10
                else:
                    name = 11
            elif(700<y<900):
                if(x<600):
                    name = 12
                elif(600<x<1000):
                    name = 13
                else:
                    name = 14
            elif(900<y<1000):
                if(x<800):
                    name = 15
                else:
                    name = 16
            elif(1000<y<1200):
                if(x<800):
                    name = 17
                else:
                    name = 18
            elif(1200<y<1320):
                if(x<450):
                    name = 19
                elif(x<850):
                    name = 20
                elif(x<1150):
                    name = 21
                else:
                    name=22
            elif(1320<y<1500):
                if(x<450):
                    name = 23
                elif(x<850):
                    name = 24
                elif(x<1150):
                    name = 25
                else:
                    name=26
                    
            cv2.imwrite("/".join(["./image/crop_img/",filename.split(".")[0]])+"/"+"_".join([str(name).zfill(2),str(x).zfill(4)+'_',str(y).zfill(4)])+'.jpg',image[y+1:y+h+15,x+1:x+w+15])
            # cv2.imwrite('image/crop_img/'+str(y).zfill(4)+'_'+str(x).zfill(4)+'.jpg',image[y+1:y+h+15,x+1:x+w+15])
    # print(counti)
    # print(bbox_list)

def recognition_mat(folder_path,model):
    ##### [step 2] 인식 모델 수행 #####
    # model = tf.keras.models.load_model("E:/Users/dian3/CNNOCR")
    # 이미지 파일 확장자
    image_extension = '.jpg'

    # folder_path = "E:/Users/dian3/CNNOCR/image/crop_img/"
    
    image_files = [file for file in  natsort.natsorted(os.listdir(folder_path)) if file.endswith(image_extension)]
    # print(image_files)
    test_data = []
    data_name =[]
    for image_file in image_files:
        image_path = os.path.join(folder_path, image_file)
        # print(image_path.split('/')[-1])
        # print(image_path)
        image = cv2.imread(image_path)
        image = cv2.resize(image, (32,32))
        test_data.append(image)
        data_name.append(image_path.split('/')[-1])
    

    test_data = np.array(test_data)

    # print(test_data.shape)

    # tf.config.run_functions_eagerly(True)
    predictions = model.predict(test_data)
    # print(predictions)
    ##### [step 3] 앱으로 반환하는 형태 만드는 코드 #####
    pred_dict = defaultdict()
    pred_list = list()
    count = 1
    makestr=''
    # print(predictions)
    for pred, name, image in zip(predictions, data_name, test_data) :
        # print(name, " : ",pred.argmax())
        pred_dict[name]=pred.argmax()
        if str(name).split("\\")[1].startswith(str(count).zfill(2)):
            makestr=makestr+str(pred.argmax())
        elif str(name).split("\\")[1].startswith(str(count+1).zfill(2)): 
            if(len(makestr)==0):
                pred_list.append("NO")
            else:
                pred_list.append(makestr)
            makestr=str(pred.argmax())
            count+=1
        # else :
    pred_list.append(makestr)
    left = 26-len(pred_list)
    for i in range(left):
        pred_list.append("NO")    
    # print([pred_list])


    # 이미지와 예측 결과, 이름을 함께 출력
    # for pred, name, image in zip(predictions, data_name, test_data):

    #     # 이미지 시각화
    #     plt.imshow(image)
    #     plt.axis('off')
    #     plt.show()

    #     # 이미지 출력
    #     plt.show()

    #     # 예측 결과와 이름 출력
    #     print(f"Name: {name}")
    #     print("Predictions : ", pred.argmax())

    return pred_list

def detecttext_pre(filename):
    # 옮겨서 저장하는 과정에서 resize 진행 

    test_img = cv2.imread("".join(["./image/DBimg/",filename]))
    test_img = cv2.resize(test_img,(1500,2000))
    test_img = cv2.dilate(test_img, np.ones((3, 3), np.uint8), iterations=1)
    test_img = cv2.erode(test_img, np.ones((3, 3), np.uint8), iterations=1)
    test_img = np.where(test_img > 110, 255,0)
    cv2.imwrite("savetest.jpg", test_img)

    # 글자 영역 넓게 지정 
    text_area_box = [
        [0, 680, 0, 250],  
        [0, 250, 0, 2000],
        [720, 920, 750, 1000 ],
        # [1000, 1250, 750, 1000 ],
        [700, 1000, 1100, 1600],
        [0,1500,1700,2000]
    ]

    tmp_img = cv2.imread("savetest.jpg")

    ############ [Step 1] 숫자 검출 ###############
    # 글자영역에 생기는 box 제거 
    # box안에 생기는 box 제거 (ex. 0의 경우)
    # 히스토그램 평활화, CLAHE, 
    image = tmp_img
    img_gray = cv2.cvtColor(tmp_img, cv2.COLOR_BGR2GRAY)
    ret, img_binary = cv2.threshold(img_gray, 127, 255, cv2.THRESH_BINARY)
    contours, hierarchy = cv2.findContours(img_binary, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    filtered_contours = []

    for cnt in contours: 
        x, y, w, h = cv2.boundingRect(cnt) 
        if w*h < 700 or w*h > 15000 : 
            continue 

        is_inside = False
        for other_cnt in contours :
            ox, oy, ow, oh = cv2.boundingRect(other_cnt)
            # 현재 사각형이 다른 사각형에 포함되어 있는지 확인
            is_inside = ox < x < ox + ow and oy < y < oy + oh and ox < x + w < ox + ow and oy < y + h < oy + oh and (ow*oh>500 and ow*oh<15000)
            if is_inside:
                break

        in_txt_area = False
        for txt_area in text_area_box :
            x1, x2, y1, y2 = txt_area
            # 글자영역에 있는지 확인 
            in_txt_area = x1 <= x <= x2 and y1 <= y <= y2 and x1 <= x + w <= x2 and y1 <= y + h <= y2 
            if in_txt_area :
                break
        
        if not is_inside and not in_txt_area :
            filtered_contours.append([x,y,w,h])

        # img_cp = image[:]
        for cnt in filtered_contours:
            o_x, o_y, w, h = cnt 
            if w < 40 :
                if o_x > 30 :
                    x = o_x - 30 
                    w += 30
                else :
                    x = o_x
            else:
                if o_x > 10 :
                    x = o_x - 10 
                else : 
                    x = o_x 
            y = o_y - 10
            if (h+15) > 180 or h <50:
                continue
            if w > 150 :
                continue

            # cv2.rectangle(img_cp, (x, y), (x+w+15, y+h+15), (0, 0, 255), 1) 
            # cv2.imwrite(f'image/crop_img/{x+1}_{x+w+15}_{y+1}_{y+h+15}.jpg',image[y+1:y+h+15,x+1:x+w+15])
            
            ## 다혜추가 -> 크롭된이미지저장할때 이름지정하고싶어 한거임
  
            name = 99
            if(y<100):
                name = 1
            elif(100<y<300):
                if(x<500):
                    name = 2
                elif(500<x<1000):
                    name = 3
                else:
                    name = 4
            elif(300<y<400):
                if(x<500):
                    name = 5
                elif(500<x<1000):
                    name = 6
                else:
                    name = 7                
            elif(400<y<600):
                if(x<550):
                    name = 8
                elif(x<950):
                    name = 9
                else:
                    name = 10
            elif(600<y<750):
                if(x<800):
                    name = 11
                else:
                    name = 12
            elif(750<y<900):
                if(x<800):
                    name = 13
                else:
                    name = 14
            elif(900<y<1000):
                if(x<800):
                    name = 15
                else:
                    name = 16
            elif(1000<y<1200):
                if(x<800):
                    name = 17
                else:
                    name = 18
            elif(1200<y<1320):
                if(x<450):
                    name = 19
                elif(x<850):
                    name = 20
                elif(x<1150):
                    name = 21
                else:
                    name=22
            elif(1320<y<1500):
                if(x<450):
                    name = 23
                elif(x<850):
                    name = 24
                elif(x<1150):
                    name = 25
                else:
                    name=26
            cv2.imwrite("/".join(["./image/crop_img/",filename.split(".")[0]])+"/"+"_".join([str(name).zfill(2),str(x).zfill(4)+'_',str(y).zfill(4)])+'.jpg',image[y+1:y+h+15,x+1:x+w+15])
        # cv2.imwrite("a.jpg",img_cp)


def recognition_pre(folder_path,model):
    ##### [step 2] 인식 모델 수행 #####
    # model = tf.keras.models.load_model("E:/Users/dian3/CNNOCR")
    # 이미지 파일 확장자
    image_extension = '.jpg'

    # folder_path = "E:/Users/dian3/CNNOCR/image/crop_img/"

    image_files = [file for file in natsort.natsorted(os.listdir(folder_path)) if file.endswith(image_extension)]

    test_data = []
    data_name =[]
    for image_file in image_files:
        image_path = os.path.join(folder_path, image_file)
        # print(image_path.split('/')[-1])
        # print(image_path)
        image = cv2.imread(image_path)
        image = cv2.resize(image, (32,32))
        test_data.append(image)
        data_name.append(image_path.split('/')[-1])

    test_data = np.array(test_data)

    # print(test_data.shape)

    # tf.config.run_functions_eagerly(True)
    predictions = model.predict(test_data)


    ##### [step 3] 앱으로 반환하는 형태 만드는 코드 #####
    pred_dict = defaultdict()
    pred_list = list()
    count = 1
    makestr=''
    for pred, name, image in zip(predictions, data_name, test_data) :
    #   print(name, " : ",pred.argmax())
        pred_dict[name]=pred.argmax()
        if str(name).split("\\")[1].startswith(str(count).zfill(2)):
            makestr=makestr+str(pred.argmax())
        elif str(name).split("\\")[1].startswith(str(count+1).zfill(2)): 
            if(len(makestr)==0):
                pred_list.append("NO")
            else:
                pred_list.append(makestr)
            makestr=str(pred.argmax())
            count+=1
        # else :

    pred_list.append(makestr)
    left = 26-len(pred_list)
    for i in range(left):
        pred_list.append("NO")    
    # print([pred_list])


    # 이미지와 예측 결과, 이름을 함께 출력
    # for pred, name, image in zip(predictions, data_name, test_data):

    #     # 이미지 시각화
    #     plt.imshow(image)
    #     plt.axis('off')
    #     plt.show()

    #     # 이미지 출력
    #     plt.show()

    #     # 예측 결과와 이름 출력
    #     print(f"Name: {name}")
    #     print("Predictions : ", pred.argmax())

    return pred_list
