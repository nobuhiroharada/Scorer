//
//  TeamLabel.swift
//  basket-manager
//
//  Created by Nobuhiro Harada on 2018/09/30.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import UIKit

class TeamLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textColor = .white
        self.textAlignment = .center
        self.isUserInteractionEnabled = true
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            initPhoneAttr()
        case .pad:
            initPadAttr()
        default:
            initPhoneAttr()
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPhoneAttr() {
        
        self.font = .boldSystemFont(ofSize: 30)
        self.bounds = CGRect(x: 0, y: 0, width: 130, height: 40)
    }
    
    func initPadAttr() {
        self.font = .boldSystemFont(ofSize: 60)
        self.bounds = CGRect(x: 0, y: 0, width: 260, height: 80)
    }
}
