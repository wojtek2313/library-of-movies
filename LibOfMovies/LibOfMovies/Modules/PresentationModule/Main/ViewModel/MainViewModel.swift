//
//  MainViewModel.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import Foundation
import LibOfMoviesNetwork

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
    
    @MainActor
    var allNowPlayingMovies: [Movie] = []
    {
        didSet {
            refreshCollection?()
        }
    }
    
    // MARK: - Initializers
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
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
}
