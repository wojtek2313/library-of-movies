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
    
    @MainActor
    var allNowPlayingMovies: [Movie] { get }
    
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
    
    // MARK: - Private Properties
    
    private var networkManager: NetworkManagerProtocol
    private var persistenceManager: PersistenceManagerProtocol
    
    @MainActor
    var allNowPlayingMovies: [Movie] = []
    {
        didSet {
            refreshCollection?()
        }
    }
    
    var favouriteMovies: [Movie] {
        persistenceManager.favouriteMovies.map { $0.toModel }
    }
    
    // MARK: - Initializers
    
    init(networkManager: NetworkManagerProtocol, persistenceManager: PersistenceManagerProtocol) {
        self.networkManager = networkManager
        self.persistenceManager = persistenceManager
        setupCollectionData()
        fetchNowPlaying()
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionData() {
        selectedIndex = { [unowned self] selectionIndex in
            print(selectionIndex)
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
        }
    }
    
    @MainActor
    public func addOrRemoveToFavourites(atIndex index: Int) {
        let movie = allNowPlayingMovies[index]
        let shouldBeRemoved = favouriteMovies.contains(where: { movie.id == $0.id })
        if shouldBeRemoved {
            persistenceManager.deleteMovieFromFavourites(movie: movie.toPOCO)
        } else {
            persistenceManager.addFavouriteMovie(movie: movie.toPOCO)
        }
        print(favouriteMovies)
    }
}
