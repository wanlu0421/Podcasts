# Podcasts

Structure Overview:

- Models/Podcast.swift: Defines the Podcast and PodcastResults data models.
- Services/
   - PodcastApiError.swift: Defines all network API related error types.
   - NetworkService.swift: Handles network requests and implements the pagination parameter(page).
- Protocols/FavouriteManagerProtocol.swift: Defines the FavouriteManager protocol for decoupling.
- Managers/FavouriteManger.swift: Concrete implementation of favourite state management and UserDefaults persistence.
- ViewModels/PodcastListViewModel.swift: Manages the podcast list data, loading state, pagination logic, and thread synchronization.
- Views/
   - PodcastListView.swift: The Main List View (Screen 1): Implements the List, pagination trigger(.task), and navigation.
   - PodcastRow.swift: List row view: Contains the custom layout.
   - PodcastDetail.swift: The podcast detail view (Screen 2).

