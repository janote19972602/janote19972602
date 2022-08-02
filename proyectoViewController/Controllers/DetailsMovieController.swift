//
//  DetailsViewController.swift
//  proyectoViewController
//
//  Created by Accenture on 12-07-22.
//

import UIKit

class DetailsMovieController: UIViewController {
    
    var id: Int = 0
    var nameMovie: String = ""
    var posterURL: String = ""
    var releaseDate: String = ""
    var synopsis: String = ""
   
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var labelAnio: UILabel!
    @IBOutlet weak var labelSinopsis: UITextView!
    //@IBOutlet weak var labelSinopsis: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Muestra informacion del detalle de la pelicula
        labelName.text = nameMovie
        labelAnio.text = releaseDate
        labelSinopsis.text = synopsis
        
        if let urlImage = URL(string: posterURL) {
            detailImage.load(url: urlImage)
        }
    }
        
}
    

