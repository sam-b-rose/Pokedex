//
//  PokemonDetailsVC.swift
//  pokedex
//
//  Created by Sam Rose on 11/22/15.
//  Copyright © 2015 samrose3. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Views to hide then show when done loading
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var evoStack: UIStackView!
    @IBOutlet weak var evoBar: UIView!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.capitalizedString
        let image = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = image
        nextEvoImg.image = image
        currentEvoImg.image = image
        showActivityIndicator()
            
        pokemon.downloadPokemonDetails { () -> () in
            self.UIInit()
            self.hideActivityIndicator()
        }
    }
    
    func UIInit() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        defenseLbl.text = pokemon.defense
        baseAttackLbl.text = pokemon.attack
        
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
            }
            
            evoLbl.text = str;
        }
        
    }
    
    func showActivityIndicator() {
        mainStack.layer.hidden = true
        evoStack.layer.hidden = true
        evoLbl.layer.hidden = true
        
        spinner.layer.hidden = false
        spinner.startAnimating()
    }
    
    func hideActivityIndicator() {
        mainStack.layer.hidden = false
        evoStack.layer.hidden = false
        evoLbl.layer.hidden = false
        
        spinner.stopAnimating()
        spinner.layer.hidden = true
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
