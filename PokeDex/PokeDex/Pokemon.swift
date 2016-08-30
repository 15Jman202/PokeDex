//
//  Pokemon.swift
//  PokeDex
//
//  Created by Justin Carver on 8/30/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import Foundation

class Pokemon {
    
    private let kName = "name"
    private let kForms = "forms"
    private let kURL = "url"
    private let kStats = "stats"
    private let kBaseStat = "base_stat"
    private let kMoves = "moves"
    private let kMoveName = "name"
    
    
    let name: String
    let imageEndPoint: String
    let baseStat: Int
    let moves: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let name = dictionary[kName] as? String,
            
            // Forms
            formsArray = dictionary[kForms] as? [[String: AnyObject]],
            formsDictionary = formsArray.first,
            url = formsDictionary[kURL] as? String,
            
            // Stats
            statsArray = dictionary[kStats] as? [[String: AnyObject]],
            statsDictionary = statsArray.first,
            baseStat = statsDictionary[kBaseStat] as? Int,
            
            // Moves
            movesArray = dictionary[kMoves] as? [[String: AnyObject]],
            moveDictionary = movesArray.first,
            moveDictionary2 = moveDictionary["move"],
            moves = moveDictionary2[kMoveName] as? String
            
        else { return nil }
        
        self.name = name
        self.imageEndPoint = url
        self.baseStat = baseStat
        self.moves = moves
    }
}