import math


INPUT_FILE = "input.txt" # file with the original decoded image
OUTPUT_FILE = "output.txt" # new file with high contrast
max_value = 0
min_value = 0
DELTA_VALUE = 0
SHIFT_VALUE = 0
loaded_img = []

with open(INPUT_FILE) as reader:
    for line in reader:
        loaded_img.append(line)
    i = 0
    dim = int(loaded_img[0]) * int(loaded_img[1])

    while i < dim:
        if int(loaded_img[2 + i]) > max_value:
            max_value = int(loaded_img[2 + i])
        elif int(loaded_img[2 + 1]) < min_value:
            min_value = int(loaded_img[2 + i])
        i += 1
    DELTA_VALUE = max_value - min_value
    SHIFT_LEVEL = 8 - int(math.log(DELTA_VALUE + 1, 2))

with open(OUTPUT_FILE, "w") as writer:
    dim = int(loaded_img[0]) * int(loaded_img[1]) + 2
    writer.write(str(int(loaded_img[0])) + '\n')
    writer.write(str(int(loaded_img[0])))
    i = 2
    while i < dim:
        temp_pixel = (int(loaded_img[i]) - min_value) << SHIFT_LEVEL
        new_pixel = min(255, temp_pixel)
        writer.write('\n' + str(new_pixel))
        i += 1


