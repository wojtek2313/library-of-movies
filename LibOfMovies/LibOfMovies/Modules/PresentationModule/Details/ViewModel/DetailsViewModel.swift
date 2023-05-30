//
//  DetailsViewModel.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 30/05/2023.
//

import Foundation

// MARK: - Protocol Definition

protocol DetailsViewModelProtocol {
    var movie: Movie { get }
}

// MARK: - Class Definition

class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: - Private Properties
    
    private(set) var movie: Movie
    
    // MARK: - Initializers
    
    init(movie: Movie) {
        self.movie = movie
    }
}
