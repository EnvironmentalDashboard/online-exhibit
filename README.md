# online-exhibit
Our code for managing our online GLSC exhibit. The purpose of this site is to deliver an online and interactive portal to the physical exhibit displayed on screens at the Science Center. There will be a large display which shows the GLSC home loop google slides. Below that, a control bar with buttons that can change the URL displayed in the main box. These buttons will be svgs that represent separate presentations. You will also be able to navigate by clicking the links within the slides.

## Setting Up

Run `./build.sh` then `./run.sh`.

## Configuration Format

Our configuration follows the format of a list of lists of objects.
The upper list is the set of button displays for the given exhibit.
The inner lists are the specific set of buttons for the set.
Finally, the objects in the innermost lists are the buttons themselves.

The button objects have various configuration options:
