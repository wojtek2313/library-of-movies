//
//  Movie.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 30/05/2023.
//

import Foundation
import LibOfMoviesNetwork

public struct Movie {
    var id: Int
    var backdropPath: String
    var title: String
    var releaseDate: String
    var voteAverage: Double
    var overview: String
}

extension MovieDTO {
    var toModel: Movie {
        let model = Movie(id: self.id,
                          backdropPath: self.backdropPath,
                          title: self.title,
                          releaseDate: self.releaseDate,
                          voteAverage: self.voteAverage,
                          overview: self.overview)
        return model
    }
}
