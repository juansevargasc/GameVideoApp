//
//  ModelosVistas.swift
//  GameStream
//
//  Created by Juanse Vargas on 11/10/21.
//

import Foundation
import UIKit

class ViewModel: ObservableObject
{
    
    @Published var gamesInfo = [Game]()
    
    init()
    {
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games")!
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
                    JSONDecoder().decode([Game].self, from: jsonData)
                    
                    DispatchQueue.main.async
                    {
                        self.gamesInfo.append(contentsOf: decodeData)
                        
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
