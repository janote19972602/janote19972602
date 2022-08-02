//
//  RestAPI.swift
//  proyectoViewController
//
//  Created by Accenture on 13-07-22.
//

import Foundation

let key = "802d82af66e46aaffd70f97f87d023b0"

class RestApi{
    
    static let shared = RestApi()
    
    func getPopular(numberPage:Int, complete: @escaping (Result<ListMoviesResponse?, URLError>) -> Void) {
        
        print(numberPage)
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(key)&language=en-US&page=\(numberPage)") else {return}
        
        //URLSESSION PERMITE CONSUMIR UN RECURSO DE UNA URL ESPECIFICA, EN ESTE CASO EL RECURSO ES UN JSON
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let urlError = error as? URLError {
                complete(Result.failure(urlError))
            }

            //VIGILA QUE EL RECURSO(JSON) VENGA ALMACENADO EN LA VARIABLE DATA Y LO GUARDA EN LA CONSTANTE jsonData
            if let jsonData = data {
                
                do {
                    //JSONDecoder().decode permite parsear un json a una clase
                    let results = try JSONDecoder().decode(ListMoviesResponse.self, from: jsonData)
                    complete(Result.success(results))
                }
                catch let error{
                    print(error)
                }
            }
        }
        task.resume()
    }
}
