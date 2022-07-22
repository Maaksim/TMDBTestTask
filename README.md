# iOS TMDBTestTask
 
## Requirements
 
 - Show all popular movies on the home page.
 - Option to filter results by popular, currently broadcast, my favorites.
 - By clicking on one of the movies the movie details screen will be open and there should be possible to mark a movie as a favorite.

## Architecture

In this test task I decided to use Clean Architecture. This architecture is using a VIP cycle (view controller, interactor, presenter) to help you separate logic in your application. The ViewController is responsible for the display logic, the Interactor is responsible for the business logic and the Presenter is responsible for the presentation logic. And it helps you to divide your difficult logic to the simpler layers with own responsibilities. In Clean Architecture there are a less dependencies because your View Controller know only about your Interactor, your Interactor knows only about Presenter and Presenter knows only about View Controller.

## Libraries

- SDWebImage - to upload images.

## Features

- The main page with the option to filter assets by Popular, Now playing, and Favorite;
- End page with movie details; 
- Added pagination;
- Added refresh control; 
- Added error handling.
