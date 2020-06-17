# TheMovieDB
iOS app in swift using The Movie Database API to display and search Now Playing movies
https://developers.themoviedb.org/

## Features
- Listing Now playing movies with endless scrolling (until all pages are fetched)
- Live search using the search API
- Movie detail screen
- Unit tests covering view models and binding

## Followed Architectures

### Coordinator Pattern
- Handle all the logic for presentation between View Controllers and provides an encapsulations of navigation logic.

### MVVM (Model-View-ViewModel) with binding
- Model: Holds the application data models
- View: It displays a representation of the model and receives the user's interaction with the view (clicks, keyboard, gestures, etc.), and it forwards the handling of these to the view model via the data binding (properties, event callbacks, etc.) that is defined to link the view and view model.
- ViewModel: Holds the business logic exposing public properties and functions


