# Automatic_screenshots
In this project I'll atempt to create a bash script to automate screenshot taking with imagemagick

The objective is to make a script that automates screenshot taking for a specific window, allowing the user to set the period between each screenshot as an argument, then prompting them with a "would you like to stop ?" , if they answer yes then the program should shut down immediately.

## 1-Overview

the basic overview of this program is the following:
- the user runs the program while specifying the screenshot period(in seconds).
- after running the program the user gets to select the window they would like to screenshot.
- imagemagick will then start to automatically take periodic screenshots of the selected window.
- at the same time the user will get prompted with the question "would you like to stop?"
- if he answers yes the script immediately shuts down and no more screenshots are taken.
- otherwise it will indefinitely keep taking screenshots.
- at the end we will display the number of screenshots taken.

## 2-How to use
 - install imagemagick if you don't have it already

for debian/ubuntu systems

```
sudo apt install imagemagick
```

if you have another distribution or OS, here's the link to the installation page:
[imagemagick download page](https://imagemagick.org/script/download.php)

 - next either you add the script file 'capture' to one of your PATH directories and run it with:

```
capture 5
```

 -  or you run it with the command:

```
bash ./capture 5 
```

- you will be then prompted to choose a window
- after choosing, the message "would you like to stop ?" will be displayed
- in the background ,the script will keep taking pictures of the specified window
- input yes in the terminal to stop taking screenshots

## 3-Extra

I left a few annotation if you are interested in the source code, but here are the core concepts of this script:

  1. **fetching the window id** by allowing the user to select the window.
   this was done with the 'xwininfo' command and piped with 'grep' in order to get the window id, and awk to further specify the id.
  
  2. **taking screenshots periodically** by looping through a function that uses imagemagick's function import :
   in order to capture a specific window with the id we previously fetched.
   the looping part is done with a combination of '&' to run the fct in the background and '$!' to store the fct PID
  
  3. **killing the process and stopping the script once yes is typed** using the fct's PID we can easily shut it down using kill.
   we then wait for the fct to shut down before exiting the script completely.
