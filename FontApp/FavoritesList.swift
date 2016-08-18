//
//  FavoritesList.swift
//  FontApp
//
//  Created by Danya on 12.08.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import Foundation
import UIKit

class FavoritesList{
    class var sharedFavoriteList : FavoritesList{
        struct Singleton {
            static let instance = FavoritesList()
        }
            return Singleton.instance
    }
    
    private(set) var favorites : [String]
    
    init(){
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedFavorites = defaults.objectForKey("favorites") as? [String]
        favorites = storedFavorites != nil ? storedFavorites! : []
    }
    
    func addFavorite(fontName : String){
        if (!favorites.contains(fontName)){
            favorites.append(fontName)
            saveFavorites()
        }
    }
    
    func removeFvorite(fontNAme : String){
        if let index = favorites.indexOf(fontNAme){
            favorites.removeAtIndex(index)
            saveFavorites()
        }
    }
    
    private func saveFavorites(){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favorites, forKey: "favorites")
        defaults.synchronize()
    }
}