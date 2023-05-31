//
//  MainViewModel.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import Foundation
import LibOfMoviesNetwork
import LibOfMoviesPersistence

// MARK: - Protocol Definition

protocol MainViewModelProtocol {
    // MARK: - Callbacks
    var selectedIndex: ((Int) -> Void)? { get set }
    var selectedItem: ((Movie) -> Void)? { get set }
    var refreshCollection: (() -> Void)? { get set }
    
    // MARK: - Properties
    @MainActor
    var thrownError: Error? { get }
    var filteredMovieResults: [Movie] { get }
    var favouriteMovies: [Movie] { get }
    
    // MARK: - Methods
    func addOrRemoveToFavourites(atIndex index: Int)
}

// MARK: - Class Definition

class MainViewModel: MainViewModelProtocol {
    // MARK: - Public Callbacks
    
    var selectedIndex: ((Int) -> Void)?
    var selectedItem: ((Movie) -> Void)?
    var refreshCollection: (() -> Void)?
    
    // MARK: - Public Properties
    
    @MainActor
    var thrownError: Error? = nil
    
    var filteredMovieResults: [Movie] = [] {
        didSet {
            refreshCollection?()
        }
    }
    
    var favouriteMovies: [Movie] {
        persistenceManager.favouriteMovies.map { $0.toModel }
    }
    
    // MARK: - Private Properties
    
    private var networkManager: NetworkManagerProtocol
    private var persistenceManager: PersistenceManagerProtocol
    
    @MainActor
    private var allNowPlayingMovies: [Movie] = []
    
    // MARK: - Initializers
    
    init(networkManager: NetworkManagerProtocol, persistenceManager: PersistenceManagerProtocol) {
        self.networkManager = networkManager
        self.persistenceManager = persistenceManager
        fetchNowPlaying()
        setupCollectionData()
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionData() {
        selectedIndex = { [unowned self] selectionIndex in
            Task { @MainActor in
                filteredMovieResults = selectionIndex == 0 ? allNowPlayingMovies : favouriteMovies
            }
        }
    }
    
    // MARK: - Public Methods
    
    public func fetchNowPlaying() {
        Task { @MainActor in
            do {
                allNowPlayingMovies = try await networkManager
                    .fetchNowPlayingMovies()
                    .map { $0.toModel }
            } catch NetworkError.wrongURL {
                thrownError = NetworkError.wrongURL
            } catch NetworkError.couldntFetchData {
                thrownError = NetworkError.couldntFetchData
            }
            filteredMovieResults = allNowPlayingMovies
        }
    }
    
    @MainActor
    public func addOrRemoveToFavourites(atIndex index: Int) {
        let movie = filteredMovieResults[index]
        let shouldBeRemoved = favouriteMovies.contains(where: { movie.id == $0.id })
        if shouldBeRemoved {
            persistenceManager.deleteMovieFromFavourites(movie: movie.toPOCO)
        } else {
            persistenceManager.addFavouriteMovie(movie: movie.toPOCO)
        }
    }
}
