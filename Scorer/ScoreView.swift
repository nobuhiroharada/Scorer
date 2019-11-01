//
//  ScoreView.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/10/11.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit

final class ScoreView: UIView {
    
    // スコアA
    var scoreA: Int = 0
    var teamLabelA: TeamLabel
    var scoreLabelA: ScoreLabel
    var scoreMinusButtonA: ScoreSmallButton
    var scorePlusButtonA: ScoreSmallButton
    
    // スコアB
    var scoreB: Int = 0
    var teamLabelB: TeamLabel
    var scoreLabelB: ScoreLabel
    var scoreMinusButtonB: ScoreSmallButton
    var scorePlusButtonB: ScoreSmallButton
    
    // ブザー
    var buzzerButton: BuzzerButton
    
    // 設定ボタン
    var settingButton: SettingButton
    
    // ポゼッション
    var possessionImageA: PossesionImageView
    var possessionImageB: PossesionImageView
    var isPossessionA = true
    
    // チームファウルカウント
    var foulCountImageA1: FoulCountImageView
    var foulCountImageA2: FoulCountImageView
    var foulCountImageA3: FoulCountImageView
    var foulCountImageA4: FoulCountImageView
    var foulCountImageA5: FoulCountImageView
    
    var foulCountImageB1: FoulCountImageView
    var foulCountImageB2: FoulCountImageView
    var foulCountImageB3: FoulCountImageView
    var foulCountImageB4: FoulCountImageView
    var foulCountImageB5: FoulCountImageView
    
    var isFirstFoulA: Bool = true
    var isFirstFoulB: Bool = true
    
    override init(frame: CGRect) {
        teamLabelA = TeamLabel()
        if let teamNameA = userdefaults.string(forKey: Consts.TEAM_NAME_A) {
            teamLabelA.text = teamNameA
        } else {
            teamLabelA.text = "team_name_a".localized
        }
        
        teamLabelB = TeamLabel()
        if let teamNameB = userdefaults.string(forKey: Consts.TEAM_NAME_B) {
            teamLabelB.text = teamNameB
        } else {
            teamLabelB.text = "team_name_b".localized
        }
        
        scoreLabelA = ScoreLabel()
        scoreLabelB = ScoreLabel()
        
        let upButtonImage = UIImage(named:"up-button")!
        let downButtonImage = UIImage(named:"down-button")!
        
        scoreMinusButtonA = ScoreSmallButton()
        scoreMinusButtonA.setImage(downButtonImage, for: .normal)
        
        scorePlusButtonA = ScoreSmallButton()
        scorePlusButtonA.setImage(upButtonImage, for: .normal)
        
        scoreMinusButtonB = ScoreSmallButton()
        scoreMinusButtonB.setImage(downButtonImage, for: .normal)
        
        scorePlusButtonB = ScoreSmallButton()
        scorePlusButtonB.setImage(upButtonImage, for: .normal)
        
        buzzerButton = BuzzerButton()
        
        settingButton = SettingButton()
        
        possessionImageA = PossesionImageView(frame: CGRect.zero)
        if let imageA = UIImage(named: "posses-a-active") {
            possessionImageA.image = imageA
        }
        
        possessionImageB = PossesionImageView(frame: CGRect.zero)
        if let imageB = UIImage(named: "posses-b-inactive") {
            possessionImageB.image = imageB
        }
        
        foulCountImageA1 = FoulCountImageView(frame: CGRect.zero)
        foulCountImageA2 = FoulCountImageView(frame: CGRect.zero)
        foulCountImageA3 = FoulCountImageView(frame: CGRect.zero)
        foulCountImageA4 = FoulCountImageView(frame: CGRect.zero)
        foulCountImageA5 = FoulCountImageView(frame: CGRect.zero)
        
        foulCountImageB1 = FoulCountImageView(frame: CGRect.zero)
        foulCountImageB2 = FoulCountImageView(frame: CGRect.zero)
        foulCountImageB3 = FoulCountImageView(frame: CGRect.zero)
        foulCountImageB4 = FoulCountImageView(frame: CGRect.zero)
        foulCountImageB5 = FoulCountImageView(frame: CGRect.zero)
        
        super.init(frame: frame)
        
        self.addSubview(teamLabelA)
        self.addSubview(teamLabelB)
        self.addSubview(scoreLabelA)
        self.addSubview(scoreLabelB)
        self.addSubview(scoreMinusButtonA)
        self.addSubview(scorePlusButtonA)
        self.addSubview(scoreMinusButtonB)
        self.addSubview(scorePlusButtonB)
        self.addSubview(buzzerButton)
        self.addSubview(settingButton)
        self.addSubview(possessionImageA)
        self.addSubview(possessionImageB)
        self.addSubview(foulCountImageA1)
        self.addSubview(foulCountImageA2)
        self.addSubview(foulCountImageA3)
        self.addSubview(foulCountImageA4)
        self.addSubview(foulCountImageA5)
        self.addSubview(foulCountImageB1)
        self.addSubview(foulCountImageB2)
        self.addSubview(foulCountImageB3)
        self.addSubview(foulCountImageB4)
        self.addSubview(foulCountImageB5)
        
        self.addAccessibilityIdentifier()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkOrientation4Pad() {
        if isLandscape {
            initPadAttrLandscape()
        } else {
            initPadAttrPortrait()
        }
    }
    
//    func portrait(frame: CGRect) {
//
//        self.frame = frame
//        print(frame)
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            checkOrientation4Pad()
//        }
//
//        let teamNameY = frame.height*(1/8)
//        teamLabelA.center = CGPoint(x: frame.width*(1/4),
//                                    y: teamNameY)
//
//        teamLabelB.center = CGPoint(x: frame.width*(3/4),
//                                    y: teamNameY)
//
//        let scoreLabelY = frame.height*(1/2)
//
//        scoreLabelA.center = CGPoint(x: frame.width*(1/4),
//                                     y: scoreLabelY)
//
//        scoreLabelB.center = CGPoint(x: frame.width*(3/4),
//                                     y: scoreLabelY)
//
//        let scoreButtonY = frame.height*(7/8)
//
//        scoreMinusButtonA.center = CGPoint(x: frame.width*(1/8), y: scoreButtonY)
//
//        scorePlusButtonA.center = CGPoint(x: frame.width*(3/8), y: scoreButtonY)
//
//        scoreMinusButtonB.center = CGPoint(x: frame.width*(5/8), y: scoreButtonY)
//
//        scorePlusButtonB.center = CGPoint(x: frame.width*(7/8), y: scoreButtonY)
//    }
    
    func landscape(frame: CGRect) {
        
        self.frame = frame
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            checkOrientation4Pad()
        }
        
        let teamNameY = frame.height*(2/8)
        
        teamLabelA.center = CGPoint(x: frame.width*(3/12),
                                    y: teamNameY)
        
        teamLabelB.center = CGPoint(x: frame.width*(9/12),
                                    y: teamNameY)
        
        let scoreLabelY = frame.height*(7/12)
        
        scoreLabelA.center = CGPoint(x: frame.width*(3/12),
                                     y: scoreLabelY)
        
        scoreLabelB.center = CGPoint(x: frame.width*(9/12),
                                     y: scoreLabelY)
        
        let scoreButtonY = frame.height*(7/8)
        
        scoreMinusButtonA.center = CGPoint(x: frame.width*(2/12), y: scoreButtonY)
        
        scorePlusButtonA.center = CGPoint(x: frame.width*(4/12), y: scoreButtonY)
        
        scoreMinusButtonB.center = CGPoint(x: frame.width*(8/12), y: scoreButtonY)
        
        scorePlusButtonB.center = CGPoint(x: frame.width*(10/12), y: scoreButtonY)
        
        buzzerButton.center = CGPoint(x: frame.width*(1/2), y: scoreButtonY)
        
        settingButton.center = CGPoint(x: frame.width*(23/24), y: frame.height*(7/8))
        
        possessionImageA.center = CGPoint(x: frame.width*(1/12),
                                          y: teamNameY)
        
        possessionImageB.center = CGPoint(x: frame.width*(11/12),
                                          y: teamNameY)
        
        let foulCountY = frame.height*(1/8)
        foulCountImageA1.center = CGPoint(x: frame.width*(1/12), y: foulCountY)
        foulCountImageA2.center = CGPoint(x: frame.width*(2/12), y: foulCountY)
        foulCountImageA3.center = CGPoint(x: frame.width*(3/12), y: foulCountY)
        foulCountImageA4.center = CGPoint(x: frame.width*(4/12), y: foulCountY)
        foulCountImageA5.center = CGPoint(x: frame.width*(5/12), y: foulCountY)

        foulCountImageB1.center = CGPoint(x: frame.width*(7/12), y: foulCountY)
        foulCountImageB2.center = CGPoint(x: frame.width*(8/12), y: foulCountY)
        foulCountImageB3.center = CGPoint(x: frame.width*(9/12), y: foulCountY)
        foulCountImageB4.center = CGPoint(x: frame.width*(10/12), y: foulCountY)
        foulCountImageB5.center = CGPoint(x: frame.width*(11/12), y: foulCountY)
    }

    func initPadAttrPortrait() {
        scoreLabelA.initPadAttrPortrait()
        scoreLabelB.initPadAttrPortrait()
    }
    
    func initPadAttrLandscape() {
        scoreLabelA.initPadAttrLandscape()
        scoreLabelB.initPadAttrLandscape()
    }
    
    func reset() {
        scoreA = 0
        scoreLabelA.text = "00"
        teamLabelA.text = "team_name_a".localized
        
        scoreB = 0
        scoreLabelB.text = "00"
        teamLabelB.text = "team_name_b".localized
        
        isPossessionA = true
        possessionImageA.image = UIImage(named: "posses-a-active")
        possessionImageB.image = UIImage(named: "posses-b-inactive")
        
        foulCountImageA1.image = UIImage(named: "foulcount-inactive")
        foulCountImageA2.image = UIImage(named: "foulcount-inactive")
        foulCountImageA3.image = UIImage(named: "foulcount-inactive")
        foulCountImageA4.image = UIImage(named: "foulcount-inactive")
        foulCountImageA5.image = UIImage(named: "foulcount-inactive")
        
        foulCountImageB1.image = UIImage(named: "foulcount-inactive")
        foulCountImageB2.image = UIImage(named: "foulcount-inactive")
        foulCountImageB3.image = UIImage(named: "foulcount-inactive")
        foulCountImageB4.image = UIImage(named: "foulcount-inactive")
        foulCountImageB5.image = UIImage(named: "foulcount-inactive")
    }
    
    func togglePossession() {
        if isPossessionA {
            possessionImageA.image = UIImage(named: "posses-a-inactive")
            possessionImageB.image = UIImage(named: "posses-b-active")
        } else {
            possessionImageA.image = UIImage(named: "posses-a-active")
            possessionImageB.image = UIImage(named: "posses-b-inactive")
        }
        
        isPossessionA.toggle()
    }
    
    func tapFoulCountA1() {
        if isFirstFoulA {
            foulCountImageA1.image = UIImage(named: "foulcount-active")
        } else {
            foulCountImageA1.image = UIImage(named: "foulcount-inactive")
        }
        isFirstFoulA.toggle()
        
        foulCountImageA2.image = UIImage(named: "foulcount-inactive")
        foulCountImageA3.image = UIImage(named: "foulcount-inactive")
        foulCountImageA4.image = UIImage(named: "foulcount-inactive")
        foulCountImageA5.image = UIImage(named: "foulcount-inactive")
    }
    
    func tapFoulCountA2() {
        foulCountImageA1.image = UIImage(named: "foulcount-active")
        foulCountImageA2.image = UIImage(named: "foulcount-active")
        foulCountImageA3.image = UIImage(named: "foulcount-inactive")
        foulCountImageA4.image = UIImage(named: "foulcount-inactive")
        foulCountImageA5.image = UIImage(named: "foulcount-inactive")
        isFirstFoulA = false
    }
    
    func tapFoulCountA3() {
        foulCountImageA1.image = UIImage(named: "foulcount-active")
        foulCountImageA2.image = UIImage(named: "foulcount-active")
        foulCountImageA3.image = UIImage(named: "foulcount-active")
        foulCountImageA4.image = UIImage(named: "foulcount-inactive")
        foulCountImageA5.image = UIImage(named: "foulcount-inactive")
        isFirstFoulA = false
    }
    
    func tapFoulCountA4() {
        foulCountImageA1.image = UIImage(named: "foulcount-active")
        foulCountImageA2.image = UIImage(named: "foulcount-active")
        foulCountImageA3.image = UIImage(named: "foulcount-active")
        foulCountImageA4.image = UIImage(named: "foulcount-active")
        foulCountImageA5.image = UIImage(named: "foulcount-inactive")
        isFirstFoulA = false
    }
    
    func tapFoulCountA5() {
        foulCountImageA1.image = UIImage(named: "foulcount-five")
        foulCountImageA2.image = UIImage(named: "foulcount-five")
        foulCountImageA3.image = UIImage(named: "foulcount-five")
        foulCountImageA4.image = UIImage(named: "foulcount-five")
        foulCountImageA5.image = UIImage(named: "foulcount-five")
        isFirstFoulA = false
    }
    
    func tapFoulCountB1() {
        if isFirstFoulB {
            foulCountImageB1.image = UIImage(named: "foulcount-active")
        } else {
            foulCountImageB1.image = UIImage(named: "foulcount-inactive")
        }
        isFirstFoulB.toggle()
        
        foulCountImageB2.image = UIImage(named: "foulcount-inactive")
        foulCountImageB3.image = UIImage(named: "foulcount-inactive")
        foulCountImageB4.image = UIImage(named: "foulcount-inactive")
        foulCountImageB5.image = UIImage(named: "foulcount-inactive")
    }
    
    func tapFoulCountB2() {
        foulCountImageB1.image = UIImage(named: "foulcount-active")
        foulCountImageB2.image = UIImage(named: "foulcount-active")
        foulCountImageB3.image = UIImage(named: "foulcount-inactive")
        foulCountImageB4.image = UIImage(named: "foulcount-inactive")
        foulCountImageB5.image = UIImage(named: "foulcount-inactive")
        isFirstFoulB = false
    }
    
    func tapFoulCountB3() {
        foulCountImageB1.image = UIImage(named: "foulcount-active")
        foulCountImageB2.image = UIImage(named: "foulcount-active")
        foulCountImageB3.image = UIImage(named: "foulcount-active")
        foulCountImageB4.image = UIImage(named: "foulcount-inactive")
        foulCountImageB5.image = UIImage(named: "foulcount-inactive")
        isFirstFoulB = false
    }
    
    func tapFoulCountB4() {
        foulCountImageB1.image = UIImage(named: "foulcount-active")
        foulCountImageB2.image = UIImage(named: "foulcount-active")
        foulCountImageB3.image = UIImage(named: "foulcount-active")
        foulCountImageB4.image = UIImage(named: "foulcount-active")
        foulCountImageB5.image = UIImage(named: "foulcount-inactive")
        isFirstFoulB = false
    }
    
    func tapFoulCountB5() {
        foulCountImageB1.image = UIImage(named: "foulcount-five")
        foulCountImageB2.image = UIImage(named: "foulcount-five")
        foulCountImageB3.image = UIImage(named: "foulcount-five")
        foulCountImageB4.image = UIImage(named: "foulcount-five")
        foulCountImageB5.image = UIImage(named: "foulcount-five")
        isFirstFoulB = false
    }
    
    func addAccessibilityIdentifier() {
        
        teamLabelA.accessibilityIdentifier = "teamLabelA"
        teamLabelB.accessibilityIdentifier = "teamLabelB"
        scoreLabelA.accessibilityIdentifier = "scoreLabelA"
        scoreLabelB.accessibilityIdentifier = "scoreLabelB"
        scoreMinusButtonA.accessibilityIdentifier = "scoreMinusButtonA"
        scorePlusButtonA.accessibilityIdentifier = "scorePlusButtonA"
        scoreMinusButtonB.accessibilityIdentifier = "scoreMinusButtonB"
        scorePlusButtonB.accessibilityIdentifier = "scorePlusButtonB"
        buzzerButton.accessibilityIdentifier = "buzzerButton"
        settingButton.accessibilityIdentifier = "settingButton"
        possessionImageA.accessibilityIdentifier = "possessionImageA"
        possessionImageB.accessibilityIdentifier = "possessionImageB"
        
        foulCountImageA1.accessibilityIdentifier = "foulCountImageA1"
        foulCountImageA2.accessibilityIdentifier = "foulCountImageA2"
        foulCountImageA3.accessibilityIdentifier = "foulCountImageA3"
        foulCountImageA4.accessibilityIdentifier = "foulCountImageA4"
        foulCountImageA5.accessibilityIdentifier = "foulCountImageA5"
        
        foulCountImageB1.accessibilityIdentifier = "foulCountImageB1"
        foulCountImageB2.accessibilityIdentifier = "foulCountImageB2"
        foulCountImageB3.accessibilityIdentifier = "foulCountImageB3"
        foulCountImageB4.accessibilityIdentifier = "foulCountImageB4"
        foulCountImageB5.accessibilityIdentifier = "foulCountImageB5"
    }
}

