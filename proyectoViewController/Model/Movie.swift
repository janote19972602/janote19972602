//
//  Movie.swift
//  proyectoViewController
//
//  Created by Accenture on 13-07-22.
//

import Foundation

struct Movie: Hashable {

    var id: Int
    var nameMovie: String
    var posterURL: String
    var releaseDate: String
    var synopsis: String
    var genreIDS: [Int] = []
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(nameMovie)
    }

    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.nameMovie == rhs.nameMovie
    }
}
