//
//  UIViewController+.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/10/30.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showTeamNameEdit(title: String, team: String, teamLabel: TeamLabel, viewController: UIViewController) {
        
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
    
    func showScoreEdit(title: String, team: String, scoreView: ScoreView, viewController: UIViewController) {
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            if let textFields = alert.textFields {
                
                for textField in textFields {
                    
                    if let textFieldText = textField.text {
                        if !textFieldText.isEmpty {
                            if team == Consts.TEAM_NAME_A {
                                scoreView.scoreLabelA.text = textField.text
                                scoreView.teamA.score = Int(textFieldText)!
                                userdefaults.set(textField.text, forKey: Consts.TEAM_SCORE_A)
                            }
                            else if team == Consts.TEAM_NAME_B {
                                scoreView.scoreLabelB.text = textField.text
                                scoreView.teamB.score = Int(textFieldText)!
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
                textField.text = scoreView.scoreLabelA.text
            }
            else if team == Consts.TEAM_NAME_B {
                textField.text = scoreView.scoreLabelB.text
            }
            
            textField.keyboardType = UIKeyboardType.numberPad
        })
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
