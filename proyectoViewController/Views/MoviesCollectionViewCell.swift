//
//  SeriesCollectionViewCell.swift
//  proyectoViewController
//
//  Created by Accenture on 12-07-22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    var id: Int = 0
    var nameMovie: String = ""
    var posterURL: String = ""
    var releaseDate: String = ""
    var synopsis: String = ""
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var labelNameMovie: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    
    var isFavorite = false
    
    //Boton favoritos
    @IBAction func setFavorite(_ sender: UIButton) {
        
        let movie = Movie(
                         id: self.id,
                         nameMovie: self.nameMovie,
                         posterURL: self.posterURL,
                         releaseDate: self.releaseDate,
                         synopsis: self.synopsis
                         )
        
        let manager = FavouriteManager.shared
                
        if isFavorite == true {
            let image = UIImage(systemName: "star")
            sender.setImage(image, for: .normal)
            
            //Elimina la pelicula de favoritos
            manager.remove(favourite: movie)
            
            isFavorite = false
        }
        else {
            let image = UIImage(systemName: "star.fill")
            sender.setImage(image, for: .normal)
            
            //Agrega la pelicula a favoritos
            manager.add(favourite: movie)
            
            isFavorite = true
        }
    }
}
