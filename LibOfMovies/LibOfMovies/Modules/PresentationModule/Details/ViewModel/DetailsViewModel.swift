//
//  DetailsViewModel.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 30/05/2023.
//

import Foundation
import LibOfMoviesPersistence

// MARK: - Protocol Definition

protocol DetailsViewModelProtocol {
    // MARK: - Callbacks
    var favouriteMovieSet: ((Bool) -> Void)? { get set }
    
    // MARK: - Properties
    var movie: Movie { get }
    var isFavouriteMovie: Bool { get }
    
    // MARK: - Methods
    func updateFavourites()
}

// MARK: - Class Definition

class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: - Public Callbacks
    
    public var favouriteMovieSet: ((Bool) -> Void)?
    
    // MARK: - Private Properties
    
    private(set) var movie: Movie
    private(set) var isFavouriteMovie: Bool = false {
        didSet {
            self.favouriteMovieSet?(isFavouriteMovie)
        }
    }
    
    private var persistenceManager: PersistenceManager
    
    // MARK: - Initializers
    
    init(movie: Movie, persistenceManager: PersistenceManager) {
        self.movie = movie
        self.persistenceManager = persistenceManager
        setUpFavourite()
    }
    
    // MARK: - Private Methods
    
    private func setUpFavourite() {
        isFavouriteMovie = persistenceManager.favouriteMovies.contains(where: { movie.id == $0.id })
    }
    
    public func updateFavourites() {
        isFavouriteMovie ? persistenceManager.deleteMovieFromFavourites(movie: movie.toPOCO) : persistenceManager.addFavouriteMovie(movie: movie.toPOCO)
        isFavouriteMovie.toggle()
    }
}
