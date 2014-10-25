gr2390_w3101_ios
================

Gemma Ragozzine's class project for ios class w3101
This is my final project for iOS class 3101. With my app, you can write an arbitrary number of text based notes on your phone. Each note has a title and body as well as the time of creation. The user can go back and edit notes or delete notes from the list of notes in the app. The user can also choose a photo to add to the note from the photo library, and they can email the finished note to their friends and family. Unfortunately, I was unsuccessful in making the data persistant. I understand that this is a grave limitation to my app, but please look at the code to evaluate my attempt at getting it to work. I made my note class implement the NSCoding protocol, and added the mandatory methods: encodeWithCoder and initWithCoder. In my ListViewController.m file, I have the (commented-out) method saveData to save the array of notes to a file. My problem was linking everything together; I could not figure out how to call this method at the app's termination time, and how to unload the data saved to disk upon the app's start up.


Anyway, I hope you enjoy using the working parts of my app!
