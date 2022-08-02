//
//  FavoritesController.swift
//  proyectoViewController
//
//  Created by Accenture on 13-07-22.
//

import UIKit

class FavoritesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    var favoriteList: [Movie] = []
    let favouriteManager = FavouriteManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Obtiene el arreglo de peliculas favoritas
        favoriteList = favouriteManager.getFavorites()
        
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.delegate = self
        
    }
    
    //Esta funcion se ejecuta cada vez que se muestra la vista
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        favoriteList = favouriteManager.getFavorites()
        favoritesCollectionView.reloadData()
        
    }
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "favoriteCell"

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FavoritesCollectionViewCell
        
        if let urlImage = URL(string: favoriteList[indexPath.row].posterURL) {
            cell.favoriteImage.load(url: urlImage)
        }
        
        cell.labelFavoriteName.text = favoriteList[indexPath.row].nameMovie
        
        return cell
    }
    
    
}
