import pygame

FILE_TO_RENDER = 'output_testbench.txt'  # --------->change this line to choose which file must be rendered
SIZE_WINDOW = 128 * 5
SIZE_PIXEL = 5
info_img = []
isLoaded = True
run = True
pygame.init()

window = pygame.display.set_mode((SIZE_WINDOW, SIZE_WINDOW))
pygame.display.set_caption("Input rendered")
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
        while i < info_img[2]:
            j = 0
            while j < info_img[1]:
                start_row = i * info_img[1]
                color = info_img[start_row + j + 2]
                x = j * SIZE_PIXEL
                y = i * SIZE_PIXEL
                pygame.draw.rect(window, (color, color, color), pygame.Rect((x, y), (SIZE_PIXEL, SIZE_PIXEL)))
                j += 1
            i += 1
        isLoaded = False
pygame.quit()
