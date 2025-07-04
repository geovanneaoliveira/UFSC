import numpy as np

def get_parsed_results(results):
    parsed_results = []
    if results.masks is None:
        return "Nothing detected"
    for seg, cls_id, conf, box in zip(results.masks.data, results.boxes.cls, results.boxes.conf, results.boxes.xyxy):
        if int(cls_id) == 0:
            print("falso positivo")
            continue
        parsed_results.append({
            "class": int(cls_id),
            "score": float(conf),
            "mask": seg.cpu().numpy().astype(np.uint8),
            "box": box.cpu().numpy().tolist()
        })
    return parsed_results

def get_classes(names, results):
    classes_names = []
    for r in results:
        for c in r.boxes.cls:
            classes_names.append(names[int(c)])
    return classes_names

def get_classes_ids_from_parsed_results(parsed_results):
    classes_ids = []
    for p_result in parsed_results:
        classes_ids.append(p_result['class'])
    return classes_ids
