# CSCI410-Project2

# Car Gallery App  

**Course**: CSCI410  
**Project Part 2**  

**Done By**:  
- Nour Alhoda Youssef  
- Joelle Sarkis  

---

## Description  
The Car Gallery App is a Flutter-based mobile application designed to display a gallery of cars with advanced filtering, searching, and request functionalities. The app leverages a RESTful API to dynamically fetch car data and enables users to perform the following tasks:

View all available cars on the home screen.
Filter cars by brand, allowing users to narrow down their preferences.
Search for cars within a specific price range to find options that suit their budget.
Request a car if a desired car is not available in the current collection.

## API Details
- The app connects to the following API endpoint to fetch car data:

- Endpoint:
    - http://csci410cargallery.atwebpages.com/getCars.php
    - http://csci410cargallery.atwebpages.com/getCarsByPrice.php?min_price=[number]&max_price=[number]

Response Format:
The API returns car data in JSON format, including details such as the car's name, brand, price, and other relevant attributes.

---

## Features  
1. Splash Screen: The app launches with a simple and visually appealing splash screen.
2. Home Screen: Displays all cars fetched from the API.
3. Car Filtering: Users can filter cars based on their brand.
4. Search Functionality: Users can search for cars within a defined price range.
5. Request a Car: Provides an option for users to request a car that is not available in the gallery.

