# TheMovieDB
iOS app in swift using The Movie Database API to display and search movies that are currently playing
https://developers.themoviedb.org/

## Features
- Listing Now playing movies with infinite scrolling (until all pages are fetched)  https://developers.themoviedb.org/3/movies/get-now-playing
- Live search using the search API https://developers.themoviedb.org/3/search/search-movies
- Movie detail screen
- Unit tests covering view models and binding

## Followed Architectures

### Coordinator Pattern
- Handle all the logic for presentation between View Controllers and provides an encapsulations of navigation logic.

### MVVM (Model-View-ViewModel) with binding
- Model: Holds the application data models
- View: It displays a representation of the model and receives the user's interaction with the view (clicks, keyboard, gestures, etc.), and it forwards the handling of these to the view model via the data binding (properties, event callbacks, etc.) that is defined to link the view and view model.
- ViewModel: Holds the business logic exposing public properties and functions


