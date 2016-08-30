//
//  PokemonController.swift
//  PokeDex
//
//  Created by Justin Carver on 8/30/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import Foundation

class PokemonController {
    
    static let SharedController = PokemonController()
    
    static let baseURL = "http://pokeapi.co/api/v2/pokemon/"
    
    static func getPokemon(searchTerm: String, completion: (pokemon: Pokemon?) -> Void) {
        
        let searchURL = baseURL + searchTerm.lowercaseString
        
        guard let url = NSURL(string: searchURL) else { completion(pokemon: nil); return }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            if error != nil {
                print(error)
            }
        guard let data = data,
            JSONDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject] else { completion(pokemon:  nil); return }
            
            let pokemon = Pokemon(dictionary: JSONDictionary)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(pokemon: pokemon)
            })
        }
    }
    
    static func getSpriteEndpointForPokemon(pokemon: Pokemon, completion: (endpoint: String?) -> Void) {
        guard let url = NSURL(string: pokemon.imageEndPoint) else { completion(endpoint: nil); return }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            guard let data = data, JSONDictionary = (try?NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject], spritesDictionary = JSONDictionary["sprites"] as? [String: AnyObject], spriteEndpoint = spritesDictionary["front_default"] as? String else { completion(endpoint: nil);return }
            
            completion(endpoint: spriteEndpoint)
            
        }
    }
}