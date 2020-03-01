import argparse
import os
import cv2
import numpy as np
from picamera import PiCamera
from time import sleep


# for custom yolov3 object detection
# https://blog.francium.tech/custom-object-training-and-detection-with-yolov3-darknet-and-opencv-41542f2ff44e
def main(args):
    # camera = PiCamera()
    # print('hello world')

    # load the COCO class labels our YOLO model was trained on
    # labelsPath = os.path.sep.join([args["yolo"], "coco.names"])
    labelsPath = args.names
    LABELS = open(labelsPath).read().strip().split("\n")

    # initialize a list of colors to represent each possible class label
    np.random.seed(42)
    COLORS = np.random.randint(0, 255, size=(len(LABELS), 3),
	    dtype="uint8")


    # derive the paths to the YOLO weights and model configuration
    weightsPath = args.weights 
    configPath = args.config

    # load our YOLO object detector trained on COCO dataset (80 classes)
    # and determine only the *output* layer names that we need from YOLO
    print("[INFO] loading YOLO from disk...")
    net = cv2.dnn.readNetFromDarknet(configPath, weightsPath)
    ln = net.getLayerNames()
    ln = [ln[i[0] - 1] for i in net.getUnconnectedOutLayers()]
    

    print(ln[:10])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument("--image", default='samples/image.jpg', help="image for prediction")
    parser.add_argument("--config", default='yolo-coco/yolov3-320/yolov3.cfg', help="YOLO config path")
    parser.add_argument("--weights", default='yolo-coco/yolov3-320/yolov3.weights', help="YOLO weights path")
    parser.add_argument("--names", default='yolo-coco/yolov3-320/coco.names', help="class names path")
    args = parser.parse_args()


    main(args)
