//
//  Weapons.swift
//  projet 3
//
//  Created by vaillant on 18/04/2020.
//  Copyright © 2020 vaillant. All rights reserved.
//

import Foundation

enum Weapons {
    case battleAxe_🪓
    case boomerang_🧲
    case sword_🗡
    case crossbow_🏹
    case bomb_💣
    case stick_🦯
    case power_💪
    case potion_🧪
    
    var action: Int {

             switch self {
             case .battleAxe_🪓:
                return 50
             case .boomerang_🧲:
                return 25
             case .sword_🗡:
                return 60
             case .crossbow_🏹:
                return 40
             case .bomb_💣:
                return 80
             case .stick_🦯:
                return 30
             case .power_💪:
                return 100
             case .potion_🧪:
                return 100
        }
    }
}
