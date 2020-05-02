//
//  Character.swift
//  projet 3
//
//  Created by vaillant on 18/04/2020.
//  Copyright © 2020 vaillant. All rights reserved.
//

import Foundation

class Character {
    var name: String
    var hp: Int
    var maxHp = 200
    var care: Int
    var degat: Int
    var armed: Weapons
    
    init(name: String, hp: Int, care: Int, armed: Weapons, degat: Int) {
        self.hp = hp
        self.care = care
        self.armed = armed
        self.name = name
        self.degat = degat
    }
        
    func hitPoint(damage: Character) { // fonction qui permet d'attaquer son adversaire
        damage.hp -= armed.action
        print("Il reste \(damage.hp) points de vie 💔 à \(damage.name)")
        if damage.hp < 0 {
            damage.hp = 0
            print("\(name) est mort 💀")
        }
    }
    
    func superHitPoint(damage: Character) { // fonction qui déclenche une super attaque
        let power: Weapons = .power_💪
        damage.hp -= power.action
        print("Il reste \(damage.hp) points de vie à 💔 \(damage.name)")
        if damage.hp < 0 {
            damage.hp = 0
                print("\(name) est mort 💀")
            }
        }
    
    func care(restore: Character) { // fonction qui permet de soigner un équipier
        restore.hp += care
        care -= care
        print("\(restore.name) possède maintenant \(restore.hp) points de vie 💖")
        if care <= 0 {
            care = 0
            print("oups ! malheureusement il ne vous reste plus de potion pour soigner..")

        if hp >= maxHp {
            print("rappel ❗ vous ne pouvez pas aller au delà des 200 points de vie 💘")
            print("")
            hp = maxHp
        }
    }
    }
    
    func superCare(restore: Character) { // fonction qui déclenche un soin X2
        let potion: Weapons = .potion_🧪
        restore.hp += potion.action
        print("\(restore.name) possède maintenant \(restore.hp) points de vie 💖")
        if hp >= maxHp {
            print("rappel ❗ vous ne pouvez pas aller au delà des 200 points de vie 💘")
            print("")
            hp = maxHp
        }
    }
    
    func increaseCare(increase: Character) { // fonction qui permet d'augmenter de "1" la capacité de guérir son personnage
        increase.care += 1
        
    }
    
    func displayCharacter() { // affichage des informations d'un personnage choisi
        print("""
            ––––––––––––––––
            NOM   : \(name)
            VIE   : \(hp)
            SOIN  : \(care)
            ARME  : \(armed)
            DEGAT : \(degat)
            ––––––––––––––––
            """)
        
    }
}
