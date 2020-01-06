//
//  AlertDialog.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/12/27.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

final class AlertDialog {
    
    static func showTeamNameEdit(title: String, team: String, teamLabel: TeamLabel, viewController: UIViewController) {
            
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            if let textFields = alert.textFields {
                
                for textField in textFields {
                    teamLabel.text = textField.text
                    if team == Consts.TEAM_NAME_A {
                        userdefaults.set(textField.text, forKey: Consts.TEAM_NAME_A)
                    }
                    else if team == Consts.TEAM_NAME_B {
                        userdefaults.set(textField.text, forKey: Consts.TEAM_NAME_B)
                    }
                }
                
                if type(of: viewController) == SettingViewController.self {
                    viewController.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "TEAM NAME"
            textField.text = teamLabel.text
        })
        viewController.present(alert, animated: true, completion: nil)
    }
        
    static func showScoreEdit(title: String, team: String, gameView: GameView, viewController: UIViewController) {
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            if let textFields = alert.textFields {
                
                for textField in textFields {
                    
                    if let textFieldText = textField.text {
                        if !textFieldText.isEmpty {
                            if team == Consts.TEAM_NAME_A {
                                gameView.scoreLabelA.text = textField.text
                                gameView.teamA.score = Int(textFieldText)!
                                userdefaults.set(textField.text, forKey: Consts.TEAM_SCORE_A)
                            }
                            else if team == Consts.TEAM_NAME_B {
                                gameView.scoreLabelB.text = textField.text
                                gameView.teamB.score = Int(textFieldText)!
                                userdefaults.set(textField.text, forKey: Consts.TEAM_SCORE_B)
                            }
                        }
                    }
                    
                }
            }
        }
        
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = String(0)
            if team == Consts.TEAM_NAME_A {
                textField.text = gameView.scoreLabelA.text
            }
            else if team == Consts.TEAM_NAME_B {
                textField.text = gameView.scoreLabelB.text
            }
            
            textField.keyboardType = UIKeyboardType.numberPad
        })
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showGameResultSaveAlertDialog(viewController: UIViewController) {
        let alert = UIAlertController(title: "game_result_save".localized, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            let game = Game()
            game.teamA = userdefaults.string(forKey: Consts.TEAM_NAME_A) ?? ""
            game.teamB = userdefaults.string(forKey: Consts.TEAM_NAME_B) ?? ""
            game.scoreA = userdefaults.integer(forKey: Consts.TEAM_SCORE_A)
            game.scoreB = userdefaults.integer(forKey: Consts.TEAM_SCORE_B)
            
            let now = Date()
            game.createdAt = now
            game.updatedAt = now
            
            do {
                let realm = try Realm()

                try realm.write {
                    realm.add(game)
                }
                AlertDialog.showSimpleAlertDialog(title: "game_result_save_success".localized, viewController: viewController)
            } catch {
                AlertDialog.showSimpleAlertDialog(title: "game_result_save_error".localized, viewController: viewController)
            }
        }
        
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showGameResultDeleteAlertDialog(viewController: UIViewController, game: Game, collectionView: UICollectionView) {
        let alert = UIAlertController(title: "game_result_delete".localized, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.delete(game)
                }
                AlertDialog.showSimpleAlertDialog(title: "game_result_delete_success".localized, viewController: viewController)
                collectionView.reloadData()
            } catch {
                AlertDialog.showSimpleAlertDialog(title: "game_result_delete_error".localized, viewController: viewController)
            }
        }
        
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showSimpleAlertDialog(title: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
