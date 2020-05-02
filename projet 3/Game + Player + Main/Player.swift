//
//  Player.swift
//  projet 3
//
//  Created by vaillant on 18/04/2020.
//  Copyright © 2020 vaillant. All rights reserved.
//

import Foundation

class Player {
var getNamePlayer: String
var allTeams = [Character]()

init(getNamePlayer: String) {
    self.getNamePlayer = getNamePlayer
}

func displayCharactersTeam() { // affichage des informations sur les personnages d'une équipe
    for description in allTeams {
        description.displayCharacter()
    }
}
    
    func isDead() -> Bool { // fonction permettant de vérifier qu'un personnage est vivant ou mort
      var dead = false
        for character in allTeams {
        if character.hp == 0 {
          dead = true
        } else {
            return false
            }
      }
      return dead
    }
}
