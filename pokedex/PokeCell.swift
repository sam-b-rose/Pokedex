//
//  PokeCell.swift
//  pokedex
//
//  Created by Sam Rose on 11/21/15.
//  Copyright © 2015 samrose3. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalizedString
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId).png")
    }

}
