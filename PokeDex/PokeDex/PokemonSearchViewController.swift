//
//  PokemonSearchViewController.swift
//  PokeDex
//
//  Created by Justin Carver on 8/30/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var baseStatLable: UILabel!
    @IBOutlet weak var moveLable: UILabel!
    @IBOutlet weak var formImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        PokemonController.getPokemon(searchTerm) { (pokemon) in
            guard let pokemon = pokemon else { return }
            
            self.nameLable.text = pokemon.name.capitalizedString
            self.baseStatLable.text = "\(pokemon.baseStat)"
            self.moveLable.text = pokemon.moves.capitalizedString
            
            PokemonController.getSpriteEndpointForPokemon(pokemon, completion: { (endpoint) in
                guard let newendpoint = endpoint else { return }
                
                ImageController.imageForURL(newendpoint, completion: { (image) in
                    guard let image = image else { return }
                    
                    self.formImage.image = image
                })
            })
        }
    }
}
