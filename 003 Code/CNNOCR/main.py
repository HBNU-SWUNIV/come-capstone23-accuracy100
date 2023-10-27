# %%

import cv2, os, sys
import torch
import torch.nn as nn
import torch.nn.functional as F
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
import time

os.environ['TF_CPP_MIN_LOG_LEVEL']='2'

# def cropimage(statusboard): 
#     file=cv2.imread(statusboard,cv2.IMREAD_COLOR)
#     print("1. reading",statusboard)   
    
#     file = cv2.resize(file, (610, 866))
#     # file = img_Contrast(file)
#     file = cv2.cvtColor(file, cv2.COLOR_BGR2GRAY)
#     file = np.where(file > 110, 255,0)
#     # file = cv2.dilate(file, np.ones((3, 3), np.uint8), iterations=1)
#     # file = cv2.erode(file, np.ones((3, 3), np.uint8), iterations=1)
#     # H = 66
#     # W = 40

#     # dict_maternity = {
#     #     '01_sow_no(1)': [268, 9, 268+W, H], '01_sow_no(2)': [327, 9, 327+W, H], '01_sow_no(3)': [384, 9, 384+W, H], '01_sow_no(4)': [443, 9, 443+W, H], '01_sow_no(5)': [562, 9, 562+W, H],
#     #     '02_sow_birth(Y1)': [130, 84, 130+W, H],'02_sow_birth(Y2)': [130+W, 84, 130+W+W, H], '03_sow_birth(M1)': [303, 84, 303+W, H], '03_sow_birth(M2)': [303+W, 84, 303+W+W, H], '04_sow_birth(D1)': [479, 84, 479+W, H],'04_sow_birth(D2)': [479+W, 84, 479+W+W, H],
#     #     '05_sow_buy(Y1)': [130, 84+H, 130+W, H],'05_sow_buy(Y2)': [130+W, 84+H, 130+W+W, H], '06_sow_buy(M1)': [303, 84+H, 303+W, H],'06_sow_buy(M2)': [303+W, 84+H, 303+W+W, H], '07_sow_buy(D1)': [479, 84+H, 479+W, H],'07_sow_buy(D2)': [479+W, 84+H, 479+W+W, H],
#     #     '08_sow_expectdate(M1)': [130+W, 84+(2*H), 130+W+W, H],'08_sow_expectdate(M2)': [130+W+W, 84+(2*H), 130+W+W+W, H], '09_sow_expectdate(D1)': [431, 84+(2*H), 431+W, H],'09_sow_expectdate(D2)': [431+W, 84+(2*H), 431+W+W, H],
#     #     '10_sow_givebirth(M1)': [130+W, 84+(3*H), 130+W+W, H],'10_sow_givebirth(M2)': [130+W+W, 84+(3*H), 130+W+W+W, H], '11_sow_givebirth(D1)': [431, 84+(3*H), 431+W, H],'11_sow_givebirth(D2)': [431+W, 84+(3*H), 431+W+W, H],
#     #     '12_sow_totalbaby1': [115, 84+(4*H), 115+W, H], '12_sow_totalbaby2': [115+W, 84+(4*H), 115+W+W, H], '13_sow_feedbaby1': [325, 84+(4*H), 325+W, H],'13_sow_feedbaby2': [325+W,84+(4*H),325+W+W, H], '14_sow_babyweight(L)': [510,84+(4*H),510+W,H], '14_sow_babyweight(R)': [556,84+(4*H),556+W, H],
#     #     '15_sow_sevrerdate(M1)': [171, 84+(5*H), 171+W, H],'15_sow_sevrerdate(M2)':[171+W, 84+(5*H), 171+W+W, H], '16_sow_sevrerdate(D1)': [431, 84+(5*H), 431+W, H],'16_sow_sevrerdate(D2)': [431+W, 84+(5*H), 431+W+W, H],
#     #     '17_sow_sevrerqty1': [153, 84+(6*H), 153+W, H], '17_sow_sevrerqty2': [153+W, 84+(6*H), 153+W+W, H], '18_sow_sevrerweight(L)': [435, 84+(6*H), 435+W, H], '18_sow_sevrerweight(R)': [482, 84+(6*H), 482+W, H],
#     #     '19_vaccine1(M1)': [105, 84+(7*H), 105+W, H],'19_vaccine1(M2)': [105+W, 84+(7*H), 105+W+W, H], '20_vaccine1(D1)': [210, 84+(7*H), 210+W, H],'20_vaccine1(D2)': [210+W, 84+(7*H), 210+W+W, H], '21_vaccine2(M1)': [399, 84+(7*H), 399+W, H],'21_vaccine2(M2)': [399+W, 84+(7*H), 399+W+W, H], '22_vaccine2(D1)': [514, 84+(7*H), 514+W, H],'22_vaccine2(D2)': [514+W, 84+(7*H), 514+W+W, H],
#     #     '23_vaccine3(M1)': [105, 84+(8*H), 105+W, H],'23_vaccine3(M2)': [105+W, 84+(8*H), 105+W+W, H], '24_vaccine3(D1)': [210, 84+(8*H), 210+W, H],'24_vaccine3(D2)': [210+W, 84+(8*H), 210+W+W, H], '25_vaccine4(M1)': [399, 84+(8*H), 399+W, H],'25_vaccine4(M2)': [399+W, 84+(8*H), 399+W+W, H], '26_vaccine4(D1)': [514, 84+(8*H), 514+W, H],'26_vaccine4(D2)': [514+W, 84+(8*H), 514+W+W, H],
#     #     }
#     H = 60
#     W = 40
#     dict_maternity = {
#                     '01_sow_no(1)': [268, 18, 268+W, H], '01_sow_no(2)': [327, 18, 327+W, H], '01_sow_no(3)': [384, 18, 384+W, H], '01_sow_no(4)': [443, 18, 443+W, H], '01_sow_no(5)': [555, 18, 555+W, H],
#                     '02_sow_birth(Y1)': [134, 90, 135+W, H],'02_sow_birth(Y2)': [134+W, 90, 135+W+W, H], '03_sow_birth(M1)': [303, 90, 303+W, H], '03_sow_birth(M2)': [303+W, 90, 303+W+W, H], '04_sow_birth(D1)': [476, 90, 476+W, H],'04_sow_birth(D2)': [476+W, 90, 476+W+W, H],
#                     '05_sow_buy(Y1)': [134, 84+H+10, 130+W, H],'05_sow_buy(Y2)': [134+W, 84+H+10, 130+W+W, H], '06_sow_buy(M1)': [303, 84+H+10, 303+W, H],'06_sow_buy(M2)': [303+W, 84+H+10, 303+W+W, H], '07_sow_buy(D1)': [476, 84+H+10, 476+W, H],'07_sow_buy(D2)': [476+W, 84+H+10, 476+W+W, H],
#                     '08_sow_expectdate(M1)': [134+W, 84+(2*H)+15, 134+W+W, H],'08_sow_expectdate(M2)': [134+W+W, 84+(2*H)+15, 134+W+W+W, H], '09_sow_expectdate(D1)': [429, 84+(2*H)+15, 429+W, H],'09_sow_expectdate(D2)': [429+W, 84+(2*H)+15, 429+W+W, H],
#                     '10_sow_givebirth(M1)': [134+W, 84+(3*H)+21, 134+W+W, H],'10_sow_givebirth(M2)': [134+W+W, 84+(3*H)+21, 134+W+W+W, H], '11_sow_givebirth(D1)': [429, 84+(3*H)+21, 429+W, H],'11_sow_givebirth(D2)': [429+W, 84+(3*H)+21, 429+W+W, H],
#                     '12_sow_totalbaby1': [117, 84+(4*H)+26, 117+W, H], '12_sow_totalbaby2': [117+W, 84+(4*H)+26, 117+W+W, H], '13_sow_feedbaby1': [325, 84+(4*H)+26, 325+W, H],'13_sow_feedbaby2': [325+W,84+(4*H)+26,325+W+W, H], '14_sow_babyweight(L)': [502,84+(4*H)+26,502+W,H], '14_sow_babyweight(R)': [548,84+(4*H)+26,548+W, H],
#                     '15_sow_sevrerdate(M1)': [175, 84+(5*H)+32, 175+W, H],'15_sow_sevrerdate(M2)':[175+W, 84+(5*H)+32, 175+W+W, H], '16_sow_sevrerdate(D1)': [430, 84+(5*H)+32, 430+W, H],'16_sow_sevrerdate(D2)': [430+W, 84+(5*H)+32, 430+W+W, H],
#                     '17_sow_sevrerqty1': [153, 84+(6*H)+36, 153+W, H], '17_sow_sevrerqty2': [153+W, 84+(6*H)+36, 153+W+W, H], '18_sow_sevrerweight(L)': [430, 84+(6*H)+36, 430+W, H], '18_sow_sevrerweight(R)': [477, 84+(6*H)+36, 477+W, H],
#                     '19_vaccine1(M1)': [107, 84+(7*H)+40, 107+W, H],'19_vaccine1(M2)': [107+W, 84+(7*H)+40, 107+W+W, H], '20_vaccine1(D1)': [210, 84+(7*H)+40, 210+W, H],'20_vaccine1(D2)': [210+W, 84+(7*H)+40, 210+W+W, H], '21_vaccine2(M1)': [397, 84+(7*H)+40, 397+W, H],'21_vaccine2(M2)': [397+W, 84+(7*H)+40, 397+W+W, H], '22_vaccine2(D1)': [507, 84+(7*H)+40, 507+W, H],'22_vaccine2(D2)': [507+W, 84+(7*H)+40, 507+W+W, H],
#                     '23_vaccine3(M1)': [107, 84+(8*H)+44, 107+W, H],'23_vaccine3(M2)': [107+W, 84+(8*H)+44, 107+W+W, H], '24_vaccine3(D1)': [210, 84+(8*H)+44, 210+W, H],'24_vaccine3(D2)': [210+W, 84+(8*H)+44, 210+W+W, H], '25_vaccine4(M1)': [397, 84+(8*H)+44, 397+W, H],'25_vaccine4(M2)': [397+W, 84+(8*H)+44, 397+W+W, H], '26_vaccine4(D1)': [507, 84+(8*H)+44, 507+W, H],'26_vaccine4(D2)': [507+W, 84+(8*H)+44, 507+W+W, H],
#                     }



#     dir = 'image/cropped_imgs'
#     if os.path.exists(f'{dir}')==0:
#         os.makedirs(dir)
#         # shutil.rmtree(f'{dir}')

#     for k, v in dict_maternity.items():
#         if k == 'sow_no' or k == 'sow_babyweight' or k == 'sow_sevrerweight':
#             continue
#         v[2] = v[2] - v[0]
#         x, y, w, h = v
#         cropped_img = file[y:y + h, x:x + w]
#         cv2.imwrite(f'{dir}/{k}.jpg', cropped_img)
#     print("2. cropped images -> "+dir)

def detecttext(statusboard):
    # 옮겨서 저장하는 과정에서 resize 진행 

    test_img = cv2.imread(statusboard)
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

        img_cp = image[:]
        print(len(filtered_contours))
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
            if (h+15) > 180 :
                continue
            if w > 150 :
                continue

            cv2.rectangle(img_cp, (x, y), (x+w+15, y+h+15), (0, 0, 255), 1) 
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
            cv2.imwrite('image/crop_img/'+str(name).zfill(2)+'_'+str(x).zfill(4)+'_'+str(y).zfill(4)+'.jpg',image[y+1:y+h+15,x+1:x+w+15])



def recognition(folder_path,model):
    ##### [step 2] 인식 모델 수행 #####
    # model = tf.keras.models.load_model("E:/Users/dian3/CNNOCR")
    # 이미지 파일 확장자
    image_extension = '.jpg'

    # folder_path = "E:/Users/dian3/CNNOCR/image/crop_img/"

    image_files = [file for file in os.listdir(folder_path) if file.endswith(image_extension)]

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
    pred_dict = dict()
    pred_list = list()
    count = 1
    makestr=''
    for pred, name, image in zip(predictions, data_name, test_data) :
    #   print(name, " : ",pred.argmax())
        pred_dict[name]=pred.argmax()
        if str(name).startswith(str(count).zfill(2)):
            makestr=makestr+str(pred.argmax())
        elif str(name).startswith(str(count+1).zfill(2)): 
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
        pred_list.append("No")    
    print([pred_list])


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

