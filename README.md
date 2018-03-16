# SevenDay App

# Overview

SevenDay allows users to see their weekly forecast based on their zipcode.

Create a weather app using programmatic Autolayout. Your app should let the user input a zipcode, then see the 7-day forecast.  Selecting a forecast should display more information about the weather for that day, along with a random image of the city matching the zip code.  The user can favorite the image, then view a list of all of their favorited images.

# App Flow
Enter zipcode to retreive weekly forecast | Select a forecast to view additional information including a random image of the city matching the zip code and add to favorites | User can delete photos from their listof favorites
:---: | :---: | :---:

![gif](file:///Users/c4q/Desktop/Tech/SevenDaygifs/gettingForecastWithZipcode.gif)
![gif](file:///Users/c4q/Desktop/Tech/SevenDaygifs/addingToFavorites.gif)
![gif](file:///Users/c4q/Desktop/Tech/SevenDaygifs/deletingFavorites.gif)


# Future Updates

There should be 3 Main View Controllers

1. The main weather view controller
2. The weather detail view controller (with city pic)
3. The favorite images view controller

### Main weather view controller

The main weather view controller should have:

- A Label that names the city for the forecast
- A CollectionView to show the forecasts
- A TextField for the user to enter the zip code

Selecting a collection view cell should segue to a weather detail view controller

### Detail weather view controller

The weather detail view controller should have:

- A Label naming the city and the forecast date
- A random image of the city
- A Label with a longer description of the weather
- Additional information about the weather including the high, low, sunrise, sunset, windspeed and precipitation

Selecting the "Save" bar button item should save the image to your favorites and present an alert view informing the user.

## Favorite images view controller

The favorite images view controller should have:

- A table view that contains all of the images that have been favorited.

The image at the top should be the most recently favorited image.

For full credit, the cells should be self-sizing.


# Persistence

For full credit, the following types of persistence must be implemented:

1. Use User Defaults to store the most recently searched zip code
2. Use File Manager to store the images to disk

# Endpoints

1. [Aeris Weather API](https://www.aerisweather.com/support/docs/api/)
2. [Pixabay API](https://pixabay.com/api/docs/)

For full credit, all networking must be done natively without the use of external SDKs / Pods


# Autolayout

All views and Autolayout should be done programmatically.  For full credit, do not use a Storyboard or .xib files in your app. 

# Rubric


