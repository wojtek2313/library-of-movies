//
//  Movie.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 30/05/2023.
//

import Foundation
import LibOfMoviesNetwork
import LibOfMoviesPersistence

public struct Movie {
    var id: Int
    var backdropPath: String
    var title: String
    var releaseDate: String
    var voteAverage: Double
    var overview: String
}

extension Movie {
    var toPOCO: MoviePOCO {
        let model = MoviePOCO(value: ["id": id,
                                      "backdropPath": backdropPath,
                                      "title": title,
                                      "releaseDate": releaseDate,
                                      "voteAverage": voteAverage,
                                      "overview": overview
                                     ])
        return model
    }
}

extension MoviePOCO {
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
