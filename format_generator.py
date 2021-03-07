from PIL import Image

NAME_IMAGE = 'low_contrast2.jpg' # name of the image has to be decoded
OUTPUT_FILE = 'input.txt'

picture = Image.open(NAME_IMAGE, 'r')
columns, rows = picture.size
pixel_values = list(picture.getdata())
with open(OUTPUT_FILE, 'w') as writer:
    dimension = columns * rows
    writer.write(str(dimension) + '\n' + str(columns) + '\n' + str(rows))
    for pixel in pixel_values:
        writer.write('\n' + str(pixel[0]))
