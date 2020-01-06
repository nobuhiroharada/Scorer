//
//  Game.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/12/24.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import Foundation
import RealmSwift

class Game: Object {
    
    @objc dynamic var teamA: String = ""
    @objc dynamic var teamB: String = ""
    @objc dynamic var scoreA: Int = 0
    @objc dynamic var scoreB: Int = 0
    @objc dynamic var createdAt: Date?
    @objc dynamic var updatedAt: Date?
}
