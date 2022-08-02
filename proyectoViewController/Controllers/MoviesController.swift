//
//  ViewController.swift
//  proyectoViewController
//
//  Created by Accenture on 12-07-22.
//

import UIKit

class MoviesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    let api: RestApi = RestApi()
    var movies: [Movie] = []
    var numberPage: Int = 2
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMoviesInArray()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
func loadMoviesInArray(){
  
  //Consume el servicio y crea un arreglo de Movie
  RestApi.shared.getPopular(numberPage: self.numberPage) { [self] result in
      
      switch result{
          
      //PARA OBTENBER LOS VALORES DE UN OBJETO RESULT SE DEFINE UNA CONSTANTE EN EL CASE SUCCESS
      case.success(let movieResults):
                    
          movieResults?.results.forEach { movieResult in
         
                  //Crea un objeto de tipo Movie, ya que se debe concatenar la url donde se alojan las imagener al nombre de la foto de la pelicula
                  let movie = Movie(
                                   id: movieResult.id,
                                   nameMovie: movieResult.original_title,
                                   posterURL: "https://image.tmdb.org/t/p/w500/\(movieResult.poster_path)",
                                   releaseDate: movieResult.release_date ?? "",
                                   synopsis: movieResult.overview ?? ""
                                   )
                  
                  //Agrega objeto movie al arreglo de movies
                  self.movies.append(movie)
                  print("url de las imagenes: \(movie.posterURL)")
              }
              
            //Se recarga el UICollection del listado de peliculas. Esta recarga debe ser sincrona
            DispatchQueue.main.async {
              self.collectionView.reloadData()
            }
              
          case.failure(let error):
              //El servicio se cayo. Se debe mostrar un mensaje de error al usuario
              DispatchQueue.main.async {
                self.showAlert("No se pudo seguir obteniendo el listado de peliculas")
              }
          }
     	}
}
    
//cantidad de elementos que se mostrraan en el UICollectionView
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
}

//el tipo de datos que se mostraran en las celdas del UICollectionView
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let identifier = "movieCell"

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MoviesCollectionViewCell
    
    //Carga la imagen de la pelicula en el UIImage del UICollectionView
    if let urlImage = URL(string: movies[indexPath.row].posterURL) {
        cell.itemImage.load(url: urlImage)
    }
    
    //Muestra el nombre de la pelicula en el MoviesController
    cell.labelNameMovie.text = movies[indexPath.row].nameMovie
    
    //Pasa los datos de la pelicula a las propiedades de MoviesCollectionCell
    cell.id = movies[indexPath.row].id
    cell.nameMovie = movies[indexPath.row].nameMovie
    cell.posterURL = movies[indexPath.row].posterURL
    cell.releaseDate = movies[indexPath.row].releaseDate
    cell.synopsis = movies[indexPath.row].synopsis
    
    return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          
        //Controla si se llego a la ultima celda del UICollectionView, si es asi se debe aumentar en 1 el numero de la pagina y volver a llamar a la funcion que llama al servicio de la API
        if (indexPath.row == movies.count - 1 ) {
              numberPage += 1
              loadMoviesInArray()
        }
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
       //Ejecuta el Segue y pasa todos los valores de la pelicula al controlador DetailsMovieController que es el que muestra la info por pelicula
       let item = sender as? UICollectionViewCell
       let indexPath = collectionView.indexPath(for: item!)
       let detailMC = segue.destination as! DetailsMovieController
        
       detailMC.id = movies[(indexPath?.row)!].id
       detailMC.nameMovie = movies[(indexPath?.row)!].nameMovie
       detailMC.posterURL = movies[(indexPath?.row)!].posterURL
       detailMC.releaseDate = movies[(indexPath?.row)!].releaseDate
       detailMC.synopsis = movies[(indexPath?.row)!].synopsis
    }
    
    //Mensaje de alerta al usuario
    func showAlert(_ mensaje: String) {
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

//Extension del UIImageView que es necesasria para poder cargar las imagenes en las celdas del UICollectionView
extension UIImageView {

    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
