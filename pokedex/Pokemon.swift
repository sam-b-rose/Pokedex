//
//  Pokemon.swift
//  pokedex
//
//  Created by Sam Rose on 11/21/15.
//  Copyright © 2015 samrose3. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _attack: String!
    private var _height: String!
    private var _weight: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    var name: String {
        get {
            if _name == nil {
                return ""
            }
        return _name
        }
    }
    
    var pokedexId: Int {
        get {
            if _pokedexId == nil {
                return 1
            }
            return _pokedexId
        }
    }
    
    var description: String {
        get {
            if _description == nil {
                return ""
            }
            return _description
        }
    }
    
    var type: String {
        get {
            if _type == nil {
                return ""
            }
            return _type
        }
    }
    
    var defense: String {
        get {
            if _defense == nil {
                return ""
            }
            return _defense
        }
    }
    
    var attack: String {
        get {
            if _attack == nil {
                return ""
            }
            return _attack
        }
    }
    
    var height: String {
        get {
            if _height == nil {
                return ""
            }
            return _height
        }
    }
    
    var weight: String {
        get {
            if _weight == nil {
                return ""
            }
            return _weight
        }
    }
    
    var nextEvolutionId: String {
        get {
            if _nextEvolutionId == nil {
                return ""
            }
            return _nextEvolutionId
        }
    }
    
    var nextEvolutionTxt: String {
        get {
            if _nextEvolutionTxt == nil {
                return ""
            }
            return _nextEvolutionTxt
        }
    }
    
    var nextEvolutionLvl: String {
        get {
            if _nextEvolutionLvl == nil {
                return ""
            }
            return _nextEvolutionLvl
        }
    }

    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1{
                        for var x = 1; x < types.count ; x++ {
                            if let name = types[x]["name"] {
                             self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            let result = response.result
                        
                            if let descDict = result.value as? Dictionary<String, AnyObject>  {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                }
                            }
                            
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    if let to = evolutions[0]["to"] as? String {
                        
                        // not supporting evolutions with 'mega'
                        if to.rangeOfString("mega") == nil {
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvolutionId = num
                                self._nextEvolutionTxt = to
                                
                                if let level = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLvl = "\(level)"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}