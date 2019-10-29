//
//  ViewController.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/10/11.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit
import AVFoundation

final class MainViewController: UIViewController {

    let label = UILabel()
    var scoreView  = ScoreView()
    var buzzerPlayer: AVAudioPlayer?
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreView.frame = self.view.frame
        self.view.addSubview(scoreView)
         
        self.addButtonAction()
        self.addGesturerecognizer()
        
        let buzzerURL = Bundle.main.bundleURL.appendingPathComponent("buzzer.mp3")
         
        do {
            try buzzerPlayer = AVAudioPlayer(contentsOf:buzzerURL)
             
            buzzerPlayer?.prepareToPlay()
            buzzerPlayer?.volume = 2.0
            buzzerPlayer?.delegate = self
             
        } catch {
            print(error)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if isLandscape {
            self.scoreView.landscape(frame: self.view.frame)
        }
//        else {
//            self.scoreView.portrait(frame: self.view.frame)
//        }
        
    }
    
    func addButtonAction() {
        scoreView.scoreMinusButtonA.addTarget(self, action: #selector(MainViewController.scoreMinusButtonA_touched), for: .touchUpInside)
        
        scoreView.scorePlusButtonA.addTarget(self, action: #selector(MainViewController.scorePlusButtonA_touched), for: .touchUpInside)
        
        scoreView.scoreMinusButtonB.addTarget(self, action: #selector(MainViewController.scoreMinusButtonB_touched), for: .touchUpInside)
        
        scoreView.scorePlusButtonB.addTarget(self, action: #selector(MainViewController.scorePlusButtonB_touched), for: .touchUpInside)
        
        scoreView.buzzerButton.addTarget(self, action: #selector(MainViewController.buzzerButton_touchDown), for: .touchDown)
        
        scoreView.buzzerButton.addTarget(self, action: #selector(MainViewController.buzzerButton_touchUp), for: [.touchUpInside, .touchUpOutside])
        
        scoreView.settingButton.addTarget(self, action: #selector(MainViewController.settingButton_touched), for: .touchUpInside)
    }
    
    func addGesturerecognizer() {
        let tapTeamA = UITapGestureRecognizer(target: self, action: #selector(MainViewController.teamLabelA_tapped))
        scoreView.teamLabelA.addGestureRecognizer(tapTeamA)
        
        let tapTeamB = UITapGestureRecognizer(target: self, action: #selector(MainViewController.teamLabelB_tapped))
        scoreView.teamLabelB.addGestureRecognizer(tapTeamB)

        let tapScoreA = UITapGestureRecognizer(target: self, action: #selector(MainViewController.scoreLabelA_tapped))
        scoreView.scoreLabelA.addGestureRecognizer(tapScoreA)
        
        let tapScoreB = UITapGestureRecognizer(target: self, action: #selector(MainViewController.scoreLabelB_tapped))
        scoreView.scoreLabelB.addGestureRecognizer(tapScoreB)
        
        let tapPossessionA = UITapGestureRecognizer(target: self, action: #selector(MainViewController.possessionA_tapped))
        scoreView.possessionImageA.addGestureRecognizer(tapPossessionA)
        
        let tapPossessionB = UITapGestureRecognizer(target: self, action: #selector(MainViewController.possessionB_tapped))
        scoreView.possessionImageB.addGestureRecognizer(tapPossessionB)
        
        let tapFoulCountA1 = UITapGestureRecognizer(target: self, action: #selector(MainViewController.foulCountA1_tapped))
        scoreView.foulCountImageA1.addGestureRecognizer(tapFoulCountA1)
        
        let tapFoulCountA2 = UITapGestureRecognizer(target: self, action: #selector(MainViewController.foulCountA2_tapped))
        scoreView.foulCountImageA2.addGestureRecognizer(tapFoulCountA2)
        
        let tapFoulCountA3 = UITapGestureRecognizer(target: self, action: #selector(MainViewController.foulCountA3_tapped))
        scoreView.foulCountImageA3.addGestureRecognizer(tapFoulCountA3)
        
        let tapFoulCountA4 = UITapGestureRecognizer(target: self, action: #selector(MainViewController.foulCountA4_tapped))
        scoreView.foulCountImageA4.addGestureRecognizer(tapFoulCountA4)
        
        let tapFoulCountA5 = UITapGestureRecognizer(target: self, action: #selector(MainViewController.foulCountA5_tapped))
        scoreView.foulCountImageA5.addGestureRecognizer(tapFoulCountA5)
        
        let tapFoulCountB1 = UITapGestureRecognizer(target: self, action: #selector(MainViewController.foulCountB1_tapped))
        scoreView.foulCountImageB1.addGestureRecognizer(tapFoulCountB1)
        
        let tapFoulCountB2 = UITapGestureRecognizer(target: self, action: #selector(MainViewController.foulCountB2_tapped))
        scoreView.foulCountImageB2.addGestureRecognizer(tapFoulCountB2)
        
        let tapFoulCountB3 = UITapGestureRecognizer(target: self, action: #selector(MainViewController.foulCountB3_tapped))
        scoreView.foulCountImageB3.addGestureRecognizer(tapFoulCountB3)
        
        let tapFoulCountB4 = UITapGestureRecognizer(target: self, action: #selector(MainViewController.foulCountB4_tapped))
        scoreView.foulCountImageB4.addGestureRecognizer(tapFoulCountB4)
        
        let tapFoulCountB5 = UITapGestureRecognizer(target: self, action: #selector(MainViewController.foulCountB5_tapped))
        scoreView.foulCountImageB5.addGestureRecognizer(tapFoulCountB5)
        
    }

    // MARK: - addButtonAction
    @objc func scoreMinusButtonA_touched(_ sender: UIButton) {
        if scoreView.scoreA > 0 {
            scoreView.scoreA -= 1
            scoreView.scoreLabelA.text = String(scoreView.scoreA)
            userdefaults.set(scoreView.scoreA, forKey: TEAM_SCORE_A)
        }
    }
    
    @objc func scorePlusButtonA_touched(_ sender: UIButton) {
        if scoreView.scoreA < 1000 {
            scoreView.scoreA += 1
            scoreView.scoreLabelA.text = String(scoreView.scoreA)
            userdefaults.set(scoreView.scoreA, forKey: TEAM_SCORE_A)
        }
    }
    
    @objc func scoreMinusButtonB_touched(_ sender: UIButton) {
        if scoreView.scoreB > 0 {
            scoreView.scoreB -= 1
            scoreView.scoreLabelB.text = String(scoreView.scoreB)
            userdefaults.set(scoreView.scoreB, forKey: TEAM_SCORE_B)
        }
    }
    
    @objc func scorePlusButtonB_touched(_ sender: UIButton) {
        if scoreView.scoreB < 1000 {
            scoreView.scoreB += 1
            scoreView.scoreLabelB.text = String(scoreView.scoreB)
            userdefaults.set(scoreView.scoreB, forKey: TEAM_SCORE_B)
        }
    }
    
    @objc func settingButton_touched(_ sender: UIButton) {
        let settingViewController = SettingViewController()
        settingViewController.scoreView = self.scoreView
        self.present(settingViewController, animated: true, completion: nil)
    }
    
    // MARK: - addGesturerecognizer
    @objc func teamLabelA_tapped(_ sender: UITapGestureRecognizer) {
        AlertDialog.showTeamNameEdit(title: "team_a_name_edit".localized, team: TEAM_NAME_A, teamLabel: scoreView.teamLabelA, viewController: self)
    }
    
    @objc func teamLabelB_tapped(_ sender: UITapGestureRecognizer) {
        AlertDialog.showTeamNameEdit(title: "team_b_name_edit".localized, team: TEAM_NAME_B, teamLabel: scoreView.teamLabelB, viewController: self)
    }
    
    @objc func scoreLabelA_tapped(_ sender: UITapGestureRecognizer) {
        AlertDialog.showScoreEdit(title: "team_a_score_edit".localized, team: TEAM_NAME_A, scoreView: scoreView, viewController: self)
    }
    
    @objc func scoreLabelB_tapped(_ sender: UITapGestureRecognizer) {
        AlertDialog.showScoreEdit(title: "team_b_score_edit".localized, team: TEAM_NAME_B, scoreView: scoreView, viewController: self)
    }
    
    @objc func buzzerButton_touchDown(_ sender: UIButton) {
        buzzerPlayer?.play()
        scoreView.buzzerButton.setImage(UIImage(named: "buzzer-down"), for: .normal)
    }
    
    @objc func buzzerButton_touchUp(_ sender: UIButton) {
        buzzerPlayer?.stop()
        buzzerPlayer?.currentTime = 0
        scoreView.buzzerButton.setImage(UIImage(named: "buzzer-up"), for: .normal)
    }
    
    @objc func possessionA_tapped(_ sender: UITapGestureRecognizer) {
        scoreView.togglePossession()
    }
    
    @objc func possessionB_tapped(_ sender: UITapGestureRecognizer) {
        scoreView.togglePossession()
    }
    
    @objc func foulCountA1_tapped() {
        scoreView.tapFoulCountA1()
    }
    
    @objc func foulCountA2_tapped() {
        scoreView.tapFoulCountA2()
    }
    
    @objc func foulCountA3_tapped() {
        scoreView.tapFoulCountA3()
    }
    
    @objc func foulCountA4_tapped() {
        scoreView.tapFoulCountA4()
    }
    
    @objc func foulCountA5_tapped() {
        scoreView.tapFoulCountA5()
    }
    
    @objc func foulCountB1_tapped() {
        scoreView.tapFoulCountB1()
    }
    
    @objc func foulCountB2_tapped() {
        scoreView.tapFoulCountB2()
    }
    
    @objc func foulCountB3_tapped() {
        scoreView.tapFoulCountB3()
    }
    
    @objc func foulCountB4_tapped() {
        scoreView.tapFoulCountB4()
    }
    
    @objc func foulCountB5_tapped() {
        scoreView.tapFoulCountB5()
    }
    
}

extension MainViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        scoreView.buzzerButton.setImage(UIImage(named: "buzzer-up"), for: .normal)
        
    }
    
}
