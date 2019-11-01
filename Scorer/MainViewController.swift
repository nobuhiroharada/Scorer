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
    var scoreView  = ScoreView()
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
        
        scoreView.scoreMinusButtonA.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let currentScoreA = self?.scoreView.scoreA else {
                    return
                }
                if currentScoreA > 0 {
                    let newScoreA = currentScoreA - 1
                    self?.scoreView.scoreA = newScoreA
                    self?.scoreView.scoreLabelA.text = String(newScoreA)
                    userdefaults.set(newScoreA, forKey: Consts.TEAM_SCORE_A)
                }
            })
            .disposed(by: disposeBag)
        
        scoreView.scorePlusButtonA.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let currentScoreA = self?.scoreView.scoreA else {
                    return
                }
                if currentScoreA < 1000 {
                    let newScoreA = currentScoreA + 1
                    self?.scoreView.scoreA = newScoreA
                    self?.scoreView.scoreLabelA.text = String(newScoreA)
                    userdefaults.set(newScoreA, forKey: Consts.TEAM_SCORE_A)
                }
            })
            .disposed(by: disposeBag)
        
        scoreView.scoreMinusButtonB.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let currentScoreB = self?.scoreView.scoreB else {
                    return
                }
                if currentScoreB > 0 {
                    let newScoreB = currentScoreB - 1
                    self?.scoreView.scoreB = newScoreB
                    self?.scoreView.scoreLabelB.text = String(newScoreB)
                    userdefaults.set(newScoreB, forKey: Consts.TEAM_SCORE_B)
                }
            })
            .disposed(by: disposeBag)
        
        scoreView.scorePlusButtonB.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let currentScoreB = self?.scoreView.scoreB else {
                    return
                }
                if currentScoreB < 1000 {
                    let newScoreB = currentScoreB + 1
                    self?.scoreView.scoreB = newScoreB
                    self?.scoreView.scoreLabelB.text = String(newScoreB)
                    userdefaults.set(newScoreB, forKey: Consts.TEAM_SCORE_B)
                }
            })
            .disposed(by: disposeBag)
        
        scoreView.settingButton.rx.tap
            .subscribe(onNext: {
                let settingViewController = SettingViewController()
                settingViewController.scoreView = self.scoreView
                self.present(settingViewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        scoreView.buzzerButton.addTarget(self, action: #selector(MainViewController.buzzerButton_touchDown), for: .touchDown)
        
        scoreView.buzzerButton.addTarget(self, action: #selector(MainViewController.buzzerButton_touchUp), for: [.touchUpInside, .touchUpOutside])
    }
    
    func addGesturerecognizer() {
        let tapTeamA = UITapGestureRecognizer()
        scoreView.teamLabelA.addGestureRecognizer(tapTeamA)
        tapTeamA.rx.event.bind { (recognizer) in
            self.showTeamNameEdit(title: "team_a_name_edit".localized, team: Consts.TEAM_NAME_A, teamLabel: self.scoreView.teamLabelA, viewController: self)
        }.disposed(by: disposeBag)
        
        let tapTeamB = UITapGestureRecognizer()
        scoreView.teamLabelB.addGestureRecognizer(tapTeamB)
        tapTeamB.rx.event.bind { (recognizer) in
            self.showTeamNameEdit(title: "team_b_name_edit".localized, team: Consts.TEAM_NAME_B, teamLabel: self.scoreView.teamLabelB, viewController: self)
        }.disposed(by: disposeBag)

        let tapScoreA = UITapGestureRecognizer()
        scoreView.scoreLabelA.addGestureRecognizer(tapScoreA)
        tapScoreA.rx.event.bind { (recognizer) in
            self.showScoreEdit(title: "team_a_score_edit".localized, team: Consts.TEAM_NAME_A, scoreView: self.scoreView, viewController: self)
        }.disposed(by: disposeBag)
        
        let tapScoreB = UITapGestureRecognizer()
        scoreView.scoreLabelB.addGestureRecognizer(tapScoreB)
        tapScoreB.rx.event.bind { (recognizer) in
            self.showScoreEdit(title: "team_b_score_edit".localized, team: Consts.TEAM_NAME_B, scoreView: self.scoreView, viewController: self)
        }.disposed(by: disposeBag)
        
        let tapPossessionA = UITapGestureRecognizer()
        scoreView.possessionImageA.addGestureRecognizer(tapPossessionA)
        tapPossessionA.rx.event.bind { (recognizer) in
            self.scoreView.togglePossession()
        }.disposed(by: disposeBag)
        
        let tapPossessionB = UITapGestureRecognizer()
        scoreView.possessionImageB.addGestureRecognizer(tapPossessionB)
        tapPossessionB.rx.event.bind { (recognizer) in
            self.scoreView.togglePossession()
        }.disposed(by: disposeBag)
        
        let tapFoulCountA1 = UITapGestureRecognizer()
        scoreView.foulCountImageA1.addGestureRecognizer(tapFoulCountA1)
        tapFoulCountA1.rx.event.bind { (recognizer) in
            self.scoreView.tapFoulCountA1()
        }.disposed(by: disposeBag)
        
        let tapFoulCountA2 = UITapGestureRecognizer()
        scoreView.foulCountImageA2.addGestureRecognizer(tapFoulCountA2)
        tapFoulCountA2.rx.event.bind { (recognizer) in
            self.scoreView.tapFoulCountA2()
        }.disposed(by: disposeBag)
        
        let tapFoulCountA3 = UITapGestureRecognizer()
        scoreView.foulCountImageA3.addGestureRecognizer(tapFoulCountA3)
        tapFoulCountA3.rx.event.bind { (recognizer) in
            self.scoreView.tapFoulCountA3()
        }.disposed(by: disposeBag)
        
        let tapFoulCountA4 = UITapGestureRecognizer()
        scoreView.foulCountImageA4.addGestureRecognizer(tapFoulCountA4)
        tapFoulCountA4.rx.event.bind { (recognizer) in
            self.scoreView.tapFoulCountA4()
        }.disposed(by: disposeBag)
        
        let tapFoulCountA5 = UITapGestureRecognizer()
        scoreView.foulCountImageA5.addGestureRecognizer(tapFoulCountA5)
        tapFoulCountA5.rx.event.bind { (recognizer) in
            self.scoreView.tapFoulCountA5()
        }.disposed(by: disposeBag)
        
        let tapFoulCountB1 = UITapGestureRecognizer()
        scoreView.foulCountImageB1.addGestureRecognizer(tapFoulCountB1)
        tapFoulCountB1.rx.event.bind { (recognizer) in
            self.scoreView.tapFoulCountB1()
        }.disposed(by: disposeBag)
        
        let tapFoulCountB2 = UITapGestureRecognizer()
        scoreView.foulCountImageB2.addGestureRecognizer(tapFoulCountB2)
        tapFoulCountB2.rx.event.bind { (recognizer) in
            self.scoreView.tapFoulCountB2()
        }.disposed(by: disposeBag)
        
        let tapFoulCountB3 = UITapGestureRecognizer()
        scoreView.foulCountImageB3.addGestureRecognizer(tapFoulCountB3)
        tapFoulCountB3.rx.event.bind { (recognizer) in
            self.scoreView.tapFoulCountB3()
        }.disposed(by: disposeBag)
        
        let tapFoulCountB4 = UITapGestureRecognizer()
        scoreView.foulCountImageB4.addGestureRecognizer(tapFoulCountB4)
        tapFoulCountB4.rx.event.bind { (recognizer) in
            self.scoreView.tapFoulCountB4()
        }.disposed(by: disposeBag)
        
        let tapFoulCountB5 = UITapGestureRecognizer()
        scoreView.foulCountImageB5.addGestureRecognizer(tapFoulCountB5)
        tapFoulCountB5.rx.event.bind { (recognizer) in
            self.scoreView.tapFoulCountB5()
        }.disposed(by: disposeBag)
        
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
    
}

extension MainViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        scoreView.buzzerButton.setImage(UIImage(named: "buzzer-up"), for: .normal)
        
    }
    
}
