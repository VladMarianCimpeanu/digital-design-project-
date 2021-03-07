import pygame

FILE_TO_RENDER = 'output.txt' # change this line to choose which file has to be rendered
SIZE_WINDOW = 128 * 8
SIZE_PIXEL = 8
info_img = []
pixels = []
isLoaded = True
run = True
pygame.init()

window = pygame.display.set_mode((SIZE_WINDOW, SIZE_WINDOW))
pygame.display.set_caption("input_rendered")
with open(FILE_TO_RENDER) as reader:
    for line in reader:
        info_img.append(int(line))
while run:
    pygame.time.delay(100)
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            run = False

    pygame.display.update()
    if isLoaded:
        i = 0
        while i < info_img[1]:
            j = 0
            while j < info_img[0]:
                start_row = i * info_img[0]
                color = info_img[start_row + j + 2]
                x = j * SIZE_PIXEL
                y = i * SIZE_PIXEL
                pygame.draw.rect(window, (color, color, color), pygame.Rect((x, y), (SIZE_PIXEL, SIZE_PIXEL)))
                j += 1
            i += 1
        isLoaded = False
pygame.quit()
