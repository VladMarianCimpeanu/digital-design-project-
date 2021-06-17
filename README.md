# digital-design-project-
This is the final project of the course "Digital design systems" in 2021 at Politecnico di Milano.
Goal of this project is to design an image equalizer in VHDL. The equalizer takes in input a black and white image stored in RAM represented by the following format:
- first byte: image width
- second byte: image height
- the next bytes contains color information.

---

| Sections | Points | Total | 
| ----------- | ----------- | ----------- |
| Behavioural test | 9 | 9 |
| Tests with reset | 1 | 1 |
| Multiple images without reset | 1 | 1 |
| Synthesis | 3 | 3 |
| Report | 30 | 30 |
| Project | 30 | 30 |

Final grade: 30/30

---
## How to see the equalizer output
With the python scripts in python directory it is possible to see the equalizer output.
First, choose an image, for example '\img.png' and run the following command on cmd/bash:


`py format_generator.py --file=img.png`


This command will convert an image into the correct format that the equalizer can read, so you will find in the same directory the 'input.txt' file.


After that, you can run the equalizer.VHD simulation with the testbench python\testbench.VHD. Once the simulation is ended, it will generate a new file 'testbench_output.txt' in the directory specified. It is recommended to set the output diorectory the same in which is render.py. Make sure that the read file is 'input.txt'.


Run the following command:


`py render.py`


This command will render the output image.


Dependencies: in order to run these scripts you should install pillow, click and pygame.
