//
//  MovieDTO.swift
//  LibOfMoviesNetwork
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import Foundation

public struct MovieDTO: Codable {
    var id: Int
    var backdropPath: String
    var title: String
    var releaseDate: String
    var voteAverage: Double
    var overview: String
}
