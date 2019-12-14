# **Final Project Documentation**
# **The _Rainbow Tank_**

### **Overall project concept and description**
This project was created to model particles and let users play around with them in a closed box space. Particles can be created by
the user, they can be pulled and pushed around, and they can be removed from the box. 

### **Pictures and videos**
Circuit schematics:

![alt text](https://github.com/viragkiss/tiny-flower/blob/master/Final%20Project/Images%20and%20Videos/IMG_4466.jpg "Image 1")

Pictures:

![alt text](https://github.com/viragkiss/tiny-flower/blob/master/Final%20Project/Images%20and%20Videos/IMG_4462.jpg "Image 1")

![alt text](https://github.com/viragkiss/tiny-flower/blob/master/Final%20Project/Images%20and%20Videos/IMG_4463.PNG "Image 2")

Videos:

![alt text](https://github.com/viragkiss/tiny-flower/blob/master/Final%20Project/Images%20and%20Videos/IMG_4442.MOV "Video 1")

![alt text](https://github.com/viragkiss/tiny-flower/blob/master/Final%20Project/Images%20and%20Videos/001.MOV "Video 2")

![alt text](https://github.com/viragkiss/tiny-flower/blob/master/Final%20Project/Images%20and%20Videos/002.MOV "Video 3")

### **List of important parts**
* Analog joystick
* Arduino UNO with soldered breadboard
* Laptop
* Handrest with the joystick for convenient use (See Video 1)

### **Code**

The entire code is too long and complicated to insert all of it here. See Final Project/Codes folder. Link:

https://github.com/viragkiss/tiny-flower/tree/master/Final%20Project/Codes

### **How the project works**

The behaviour of the particles is commanded by the user through a combination of key holds and joystick movements.

To create particles, press the laptop mouse continuously while moving the joystick around.
To move particles around, press the UP arrow key continuously while moving the joystick.
To delete particles from the screen, press DOWN arrow key continuously while moving the joystick.
To change the background to white or black, press 'w' or 'b' key.

Processing draws data from the joystick through Arduino and maps it to its own screen's width and height. The Y coordinates have to be inversely mapped because of the orientation difference between the joystick ((0, 0) is the bottom left corner) and Processing ((0, 0) is the top left corner).

Processing then uses the X and Y coordinate inputs from Arduino to animate particles at the location of the joystick.
The rest of the interactions are written in the Processing code using Daniel Shiffman's Box2d library and object-oriented programming.

### **Building the project**

Building the project required extra work to build a platform for the joystick to be used comfortably. I thank my instructor Michael Shiloh for providing me with a soldered breadboard that already included the connections from the joystick to the Arduino pins.

Before this project came to be, my idea was in fact very different and as I kept running into problems, the project got modified.

My initial idea was to build a sketch in Processing that displays sand particles in 3D rendering mode (seen from the top) that can be 
used to make sand art with. The coordinates of the mosue would have been controlled by an Arduino 3.5 inch touchpad with display.
The touchpad had an XPT2046 touch controller, and downloading the required library made it work, however, the touchpad itself was
quite unreliable when connecting to the Arduino and then the laptop. This made me switch to using a joystick, which also had its own limitations, the biggest one being that it hardly reached the corners of the canvas because of its default circular path in its socket.

Programming the sand particles to behave nicely and in a realistic way was a great challenge and would have required a lot more time to
complete because of my lack of experinece in particle modelling. The original concept was a lattice of point or sphere objects, where the objects around the mouse would be pushed back "into" the screen and thus away from the viewer by changing their Z coordinate.
However, this solution produced a fragmented lattice and in the end could not be used.

Here are some progress photos from how the sand was going to look like:

![alt text](https://github.com/viragkiss/tiny-flower/blob/master/Final%20Project/Images%20and%20Videos/spheres.JPG "Spheres")

![alt text](https://github.com/viragkiss/tiny-flower/blob/master/Final%20Project/Images%20and%20Videos/sanpoints.JPG "Sandpoints")

![alt text](https://github.com/viragkiss/tiny-flower/blob/master/Final%20Project/Images%20and%20Videos/sandgrains_color.JPG "Colored")

Using the Box2d library solved most of the difficulty of modelling particle interactions and simplified the sketch from 3D to 2D while
keeping it interesting.

### **User testing**

During user testing, I got mixed feedback. One criticism was that the orientation of the XY axes are different in Processing and
Arduino and so it was difficult for the user to navigate the movement of the joystick. This is why I flipped the Y values in the Processing code to map the orientation of Arduino to that of Processing.

Another criticism was that without me telling the user what to do, they didn't know how to approach the project. To overcome this, I included a small set of instructions in the tank's upper left corner.
