//
//  FavouritesManager.swift
//  proyectoViewController
//
//  Created by Accenture on 14-07-22.
//

import Foundation

class FavouriteManager {
    
    //Utilizar como ejemplo el proyecto Parking

    static let shared = FavouriteManager()
    
    var favorites: Set<Movie> = []
    
    func add(favourite: Movie) {
        favorites.insert(favourite)
    }

    func remove(favourite: Movie) {
        favorites.remove(favourite)
    }

    func getFavorites() -> [Movie] {
        return Array(favorites)
    }
}

