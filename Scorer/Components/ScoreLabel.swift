//
//  ScoreLabel.swift
//  basket-manager
//
//  Created by Nobuhiro Harada on 2018/09/30.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import UIKit

class ScoreLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.text = "00"
        self.textAlignment = .center
        self.textColor = .yellow
        self.isUserInteractionEnabled = true
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            initPhoneAttr()
        case .pad:
            initPadAttrLandscape()
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPhoneAttr() {
        if UIScreen.main.bounds.size.width > 568 { // iPhone SEよりwidthが大きい場合
            setBig4Phone()
        } else {
            setNormal4Phone()
        }
    }
    
    func setNormal4Phone() {
        self.bounds = CGRect(x: 0, y: 0, width: 200, height: 160)
        self.font = UIFont(name: "DigitalDismay", size: 150)
    }
    
    func setBig4Phone() {
        self.bounds = CGRect(x: 0, y: 0, width: 400, height: 220)
        self.font = UIFont(name: "DigitalDismay", size: 270)
    }
    
    func initPadAttrLandscape() {
        self.bounds = CGRect(x: 0, y: 0, width: 470, height: 360)
        self.font = UIFont(name: "DigitalDismay", size: 350)
    }
}
