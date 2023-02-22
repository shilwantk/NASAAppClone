#  NASA App Clone

# Table of Contents
1. [NASA App Clone](#NASA App Clone)
2. [Description](#description)
3. [Getting started](#getting-started)
4. [Arhitecture](#arhitecture)
5. [Structure](#structure)
6. [Running the tests](#running-the-tests)
7. [Dependencies](#dependencies)

# NASA App Clone
A simple project that fetches NASA images and displays them in a 3*3 grid

# Description
<p>The project lets the user browse through a list of images curated by NASA parsed from a local JSON file.

# Getting started
<p> The project runs on both, iPhone and iPad and the minimum deployment version is iOS 16.0.

# Architecture
* The project is implemented using the <strong>Model-View-ViewModel (MVVM)</strong> architecture pattern.
* Model has the struct for the a single Image listing.
* View handles how the individual collection view cells for the list and the detailed view of an image will look.
* Controller is responsible for displaying list of images to the user and letting them navigate between a detailed view of the selected image and the list.
* The ViewModel is responsible for handling the data fetching from the JSON file, and keeping track of the current selected image and the index.
* Project doesn't have a database or persistent storage.<br><br>

# Structure 
* "Data": Files for fetching data from, here a local JSON file named "Data".
* "Modules": Files for App and Scene Delegates.
* "Service Manager": Files for handling data fetching and parsing. 

# Running the tests
<p>Theproject can be tested using the built-in framework XCTest.<br>

# Dependencies
Swift Package Manager is used as a dependency manager.
List of dependencies: 
* [KingFisher](https://github.com/onevcat/Kingfisher) is used for downloading and caching images from the web
