//
//  ViewController.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/10/11.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {

    let label = UILabel()
    var gameView  = GameView()
    var buzzerPlayer: AVAudioPlayer?
    private let disposeBag = DisposeBag()
    
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
        
        gameView.frame = self.view.frame
        self.view.addSubview(gameView)
         
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
            self.gameView.landscape(frame: self.view.frame)
        }
//        else {
//            self.gameView.portrait(frame: self.view.frame)
//        }
        
    }
    
    func addButtonAction() {
        
        gameView.scoreMinusButtonA.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let currentScoreA = self?.gameView.teamA.score else {
                    return
                }
                if currentScoreA > 0 {
                    let newScoreA = self?.gameView.teamA.decrementScore(score: currentScoreA)
                    self?.gameView.teamA.score = newScoreA ?? currentScoreA
                    self?.gameView.scoreLabelA.text = String(newScoreA ?? currentScoreA)
                    userdefaults.set(newScoreA, forKey: Consts.TEAM_SCORE_A)
                }
            })
            .disposed(by: disposeBag)
        
        gameView.scorePlusButtonA.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let currentScoreA = self?.gameView.teamA.score else {
                    return
                }
                if currentScoreA < 1000 {
                    let newScoreA = self?.gameView.teamA.incrementScore(score: currentScoreA)
                    self?.gameView.teamA.score = newScoreA ?? currentScoreA
                    self?.gameView.scoreLabelA.text = String(newScoreA ?? currentScoreA)
                    userdefaults.set(newScoreA, forKey: Consts.TEAM_SCORE_A)
                }
            })
            .disposed(by: disposeBag)
        
        gameView.scoreMinusButtonB.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let currentScoreB = self?.gameView.teamB.score else {
                    return
                }
                if currentScoreB > 0 {
                    let newScoreB = self?.gameView.teamB.decrementScore(score: currentScoreB)
                    self?.gameView.teamB.score = newScoreB ?? currentScoreB
                    self?.gameView.scoreLabelB.text = String(newScoreB ?? currentScoreB)
                    userdefaults.set(newScoreB, forKey: Consts.TEAM_SCORE_B)
                }
            })
            .disposed(by: disposeBag)
        
        gameView.scorePlusButtonB.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let currentScoreB = self?.gameView.teamB.score else {
                    return
                }
                if currentScoreB < 1000 {
                    let newScoreB = self?.gameView.teamB.incrementScore(score: currentScoreB)
                    self?.gameView.teamB.score = newScoreB ?? currentScoreB
                    self?.gameView.scoreLabelB.text = String(newScoreB ?? currentScoreB)
                    userdefaults.set(newScoreB, forKey: Consts.TEAM_SCORE_B)
                }
            })
            .disposed(by: disposeBag)
        
        gameView.settingButton.rx.tap
            .subscribe(onNext: {
                let settingViewController = SettingViewController()
                settingViewController.gameView = self.gameView
                
                let navigationController = UINavigationController(rootViewController: settingViewController)
                self.present(navigationController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        gameView.buzzerButton.addTarget(self, action: #selector(MainViewController.buzzerButton_touchDown), for: .touchDown)
        
        gameView.buzzerButton.addTarget(self, action: #selector(MainViewController.buzzerButton_touchUp), for: [.touchUpInside, .touchUpOutside])
    }
    
    func addGesturerecognizer() {
        let tapTeamA = UITapGestureRecognizer()
        gameView.teamLabelA.addGestureRecognizer(tapTeamA)
        tapTeamA.rx.event.bind { (recognizer) in
            AlertDialog.showTeamNameEdit(title: "team_a_name_edit".localized, team: Consts.TEAM_NAME_A, teamLabel: self.gameView.teamLabelA, viewController: self)
        }.disposed(by: disposeBag)
        
        let tapTeamB = UITapGestureRecognizer()
        gameView.teamLabelB.addGestureRecognizer(tapTeamB)
        tapTeamB.rx.event.bind { (recognizer) in
            AlertDialog.showTeamNameEdit(title: "team_b_name_edit".localized, team: Consts.TEAM_NAME_B, teamLabel: self.gameView.teamLabelB, viewController: self)
        }.disposed(by: disposeBag)

        let tapScoreA = UITapGestureRecognizer()
        gameView.scoreLabelA.addGestureRecognizer(tapScoreA)
        tapScoreA.rx.event.bind { (recognizer) in
            AlertDialog.showScoreEdit(title: "team_a_score_edit".localized, team: Consts.TEAM_NAME_A, gameView: self.gameView, viewController: self)
        }.disposed(by: disposeBag)
        
        let tapScoreB = UITapGestureRecognizer()
        gameView.scoreLabelB.addGestureRecognizer(tapScoreB)
        tapScoreB.rx.event.bind { (recognizer) in
            AlertDialog.showScoreEdit(title: "team_b_score_edit".localized, team: Consts.TEAM_NAME_B, gameView: self.gameView, viewController: self)
        }.disposed(by: disposeBag)
        
        let tapPossessionA = UITapGestureRecognizer()
        gameView.possessionImageA.addGestureRecognizer(tapPossessionA)
        tapPossessionA.rx.event.bind { (recognizer) in
            self.gameView.togglePossession()
        }.disposed(by: disposeBag)
        
        let tapPossessionB = UITapGestureRecognizer()
        gameView.possessionImageB.addGestureRecognizer(tapPossessionB)
        tapPossessionB.rx.event.bind { (recognizer) in
            self.gameView.togglePossession()
        }.disposed(by: disposeBag)
        
        let tapFoulCountA1 = UITapGestureRecognizer()
        gameView.foulCountImageA1.addGestureRecognizer(tapFoulCountA1)
        tapFoulCountA1.rx.event.bind { (recognizer) in
            self.gameView.tapFoulCountA1()
        }.disposed(by: disposeBag)
        
        let tapFoulCountA2 = UITapGestureRecognizer()
        gameView.foulCountImageA2.addGestureRecognizer(tapFoulCountA2)
        tapFoulCountA2.rx.event.bind { (recognizer) in
            self.gameView.tapFoulCountA2()
        }.disposed(by: disposeBag)
        
        let tapFoulCountA3 = UITapGestureRecognizer()
        gameView.foulCountImageA3.addGestureRecognizer(tapFoulCountA3)
        tapFoulCountA3.rx.event.bind { (recognizer) in
            self.gameView.tapFoulCountA3()
        }.disposed(by: disposeBag)
        
        let tapFoulCountA4 = UITapGestureRecognizer()
        gameView.foulCountImageA4.addGestureRecognizer(tapFoulCountA4)
        tapFoulCountA4.rx.event.bind { (recognizer) in
            self.gameView.tapFoulCountA4()
        }.disposed(by: disposeBag)
        
        let tapFoulCountA5 = UITapGestureRecognizer()
        gameView.foulCountImageA5.addGestureRecognizer(tapFoulCountA5)
        tapFoulCountA5.rx.event.bind { (recognizer) in
            self.gameView.tapFoulCountA5()
        }.disposed(by: disposeBag)
        
        let tapFoulCountB1 = UITapGestureRecognizer()
        gameView.foulCountImageB1.addGestureRecognizer(tapFoulCountB1)
        tapFoulCountB1.rx.event.bind { (recognizer) in
            self.gameView.tapFoulCountB1()
        }.disposed(by: disposeBag)
        
        let tapFoulCountB2 = UITapGestureRecognizer()
        gameView.foulCountImageB2.addGestureRecognizer(tapFoulCountB2)
        tapFoulCountB2.rx.event.bind { (recognizer) in
            self.gameView.tapFoulCountB2()
        }.disposed(by: disposeBag)
        
        let tapFoulCountB3 = UITapGestureRecognizer()
        gameView.foulCountImageB3.addGestureRecognizer(tapFoulCountB3)
        tapFoulCountB3.rx.event.bind { (recognizer) in
            self.gameView.tapFoulCountB3()
        }.disposed(by: disposeBag)
        
        let tapFoulCountB4 = UITapGestureRecognizer()
        gameView.foulCountImageB4.addGestureRecognizer(tapFoulCountB4)
        tapFoulCountB4.rx.event.bind { (recognizer) in
            self.gameView.tapFoulCountB4()
        }.disposed(by: disposeBag)
        
        let tapFoulCountB5 = UITapGestureRecognizer()
        gameView.foulCountImageB5.addGestureRecognizer(tapFoulCountB5)
        tapFoulCountB5.rx.event.bind { (recognizer) in
            self.gameView.tapFoulCountB5()
        }.disposed(by: disposeBag)
        
    }
    
    @objc func buzzerButton_touchDown(_ sender: UIButton) {
        buzzerPlayer?.play()
        gameView.buzzerButton.setImage(UIImage(named: "buzzer-down"), for: .normal)
    }
    
    @objc func buzzerButton_touchUp(_ sender: UIButton) {
        buzzerPlayer?.stop()
        buzzerPlayer?.currentTime = 0
        gameView.buzzerButton.setImage(UIImage(named: "buzzer-up"), for: .normal)
    }
    
}

extension MainViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        gameView.buzzerButton.setImage(UIImage(named: "buzzer-up"), for: .normal)
        
    }
    
}
