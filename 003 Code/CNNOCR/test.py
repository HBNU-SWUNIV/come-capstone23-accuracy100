import numpy as np
import cv2


img = cv2.imread('image/crop_img/26_1272__1412.jpg', cv2.IMREAD_COLOR)


print('img.shape ', img.shape)


h, w, c = img.shape

print('height ', h)
print('width ', w)
print('channel ', c)
print(w*h)