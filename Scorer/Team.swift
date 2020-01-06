//
//  Team.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/11/02.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

class Team {
    
    var name: String
    var score: Int
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    
    static func getNameA() -> String {
        if (userdefaults.string(forKey: Consts.TEAM_NAME_A) == nil) {
            userdefaults.set("team_name_a".localized, forKey: Consts.TEAM_NAME_A)
        }
        return userdefaults.string(forKey: Consts.TEAM_NAME_A) ?? "team_name_a".localized
    }
    
    static func getNameB() -> String {
        if (userdefaults.string(forKey: Consts.TEAM_NAME_B) == nil) {
            userdefaults.set("team_name_b".localized, forKey: Consts.TEAM_NAME_B)
        }
        return userdefaults.string(forKey: Consts.TEAM_NAME_B) ?? "team_name_b".localized
    }
    
    static func getScoreA() -> Int {
        if (userdefaults.object(forKey: Consts.TEAM_SCORE_A) == nil) {
            userdefaults.set(0, forKey: Consts.TEAM_SCORE_A)
        }
        return userdefaults.integer(forKey: Consts.TEAM_SCORE_A)
    }
    
    static func getScoreB() -> Int {
        if (userdefaults.object(forKey: Consts.TEAM_SCORE_B) == nil) {
            userdefaults.set(0, forKey: Consts.TEAM_SCORE_B)
        }
        return userdefaults.integer(forKey: Consts.TEAM_SCORE_B)
    }
    
    func incrementScore(score: Int) -> Int {
        self.score = score + 1
        return self.score
    }
    
    func decrementScore(score: Int) -> Int {
        self.score = score - 1
        return self.score
    }
    
    func resetA() {
        self.name = "team_name_a".localized
        self.score = 0
        userdefaults.set("team_name_a".localized, forKey: Consts.TEAM_NAME_A)
    }
    
    func resetB() {
        self.name = "team_name_b".localized
        self.score = 0
        userdefaults.set("team_name_b".localized, forKey: Consts.TEAM_NAME_B)
    }
}
