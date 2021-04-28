from PIL import Image
import click


@click.command()
@click.option('--file', default='1', help='Path of the image that you want to convert.')
def generate(file):
    if file == 1:
        NAME_IMAGE = 'imageToDecode.jpg'  # -------> name of the default image, change this line if you want to save
        # a default path
    else:
        NAME_IMAGE = file
    OUTPUT_FILE = 'input.txt'
    try:
        picture = Image.open(NAME_IMAGE, 'r')
        columns, rows = picture.size
        pixel_values = list(picture.getdata())
        with open(OUTPUT_FILE, 'w') as writer:
            dimension = columns * rows
            writer.write(str(dimension) + '\n' + str(columns) + '\n' + str(rows))
            for pixel in pixel_values:
                writer.write('\n' + str(pixel[0]))
        click.echo("Conversion ended successfully.")
    except FileNotFoundError:
        click.echo("No such file exists.")


if __name__ == '__main__':
    generate()
