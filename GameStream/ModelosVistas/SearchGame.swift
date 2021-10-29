//
//  SearchGame.swift
//  GameStream
//
//  Created by Juanse Vargas on 17/10/21.
//

import Foundation


class SearchGame: ObservableObject
{
    
    @Published var gameInfo = [Game]() // Dónde se guarda un arreglo de juegos
    
    func search(gameName: String)
    {
        
        gameInfo.removeAll() // Empezar sin búsquedas anterirores
        
        let gameNameSpaces = gameName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games/search?contains=\( gameNameSpaces ?? "cuphead" )")!
        
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
        
            URLSession.shared.dataTask(with: request) { (data, response, error) in
        
                do
                {
                    //
                    if let jsonData = data
                    {
                        print("tamaño del json \(jsonData)")
        
                        let decodeData = try
                        JSONDecoder().decode(Resultados.self, from: jsonData)
        
                        DispatchQueue.main.async
                        {
                            self.gameInfo.append(contentsOf: decodeData.results)
        
                        }
                    }
                    else
                    {
                        print("No existen datos en el json recuperado")
                    }
                    //
                }catch
                {
                    print("Error: \(error)")
                }
        
            }.resume()
    }
    

}
