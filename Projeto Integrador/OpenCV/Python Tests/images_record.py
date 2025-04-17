import os
import cv2
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3' 
import tensorflow as tf, numpy as np

raw_dataset = tf.data.TFRecordDataset('CVR EGG.v2i.tfrecord/train/egg.tfrecord')

for i, raw_record in enumerate(raw_dataset.take(1)):
    example = tf.train.Example()
    example.ParseFromString(raw_record.numpy())
    info = {"image/depth": 1}
    for k, v in example.features.feature.items():
        if k in ['image/depth', 'image/height', 'image/width']:
            info[k] = v.int64_list.value[0]
        elif k in ['image/format']:
            info[k] = v.bytes_list.value[0].decode()
        elif k in ['image/encoded']:
            info[k] = v.bytes_list.value[0]
        elif k in ['image/object/bbox/xmax', 'image/object/bbox/ymax', 'image/object/bbox/ymin', 'image/object/bbox/xmin']:
            info[k] = v.float_list.value
        elif k in ['image/object/class/label']:
            info[k] = v.int64_list.value
        elif k in ['image/object/class/text']:
            info[k] = [x.decode() for x in v.bytes_list.value]

    img_arr = cv2.imdecode(np.frombuffer(info['image/encoded'], dtype = np.uint8), cv2.IMREAD_UNCHANGED)
    
    print(img_arr)
    cv2.imwrite('output_image.png', img_arr)  # Use .jpg or .png as needed
    # You can use img_arr numpy array above to directly augment/preprocess
    # your image without saving it to .png.
    # img = PIL.Image.fromarray(img_arr)
    # img.save(f'Egg Detection.v13-2022-12-27-10-16pm-v2.tfrecord/test/Egg.tfrecord.{str(i).zfill(5)}.png')