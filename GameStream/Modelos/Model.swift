//
//  Modelos.swift
//  GameStream
//
//  Created by Juanse Vargas on 11/10/21.
//

import Foundation

struct Resultados: Codable
{
    
    var results: [Game]
}


struct Games: Codable
{
    var games: [Game]
}


struct Game: Codable, Hashable
{
    
    var title: String
    var studio: String
    var contentRaiting: String // Typo de la palabra rating desde el lado backend, nos acomodamos desde el lado front mientras.
    var publicationYear: String
    var description: String
    var platforms: [String]
    var tags: [String]
    var videosUrls: videoUrl
    var galleryImages: [String]
    
    
    
    
}

struct videoUrl: Codable, Hashable
{
    var mobile: String
    var tablet: String
}
