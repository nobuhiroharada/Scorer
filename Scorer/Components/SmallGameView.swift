//
//  SmallGameView.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/12/24.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit

class SmallGameView: UIView {

    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "setting_game_result".localized
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private let teamLabelA: UILabel = {
        let label = UILabel()
        label.text = userdefaults.string(forKey: Consts.TEAM_NAME_A)
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let teamLabelB: UILabel = {
        let label = UILabel()
        label.text = userdefaults.string(forKey: Consts.TEAM_NAME_B)
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private let scoreLabelA: UILabel = {
        let label = UILabel()
        label.text = String(userdefaults.integer(forKey: Consts.TEAM_SCORE_A))
        label.font = UIFont(name: "DigitalDismay", size: 44.0)
        label.textColor = .yellow
        label.textAlignment = .center
        return label
    }()
    
    private let scoreLabelB: UILabel = {
        let label = UILabel()
        label.text = String(userdefaults.integer(forKey: Consts.TEAM_SCORE_B))
        label.font = UIFont(name: "DigitalDismay", size: 44.0)
        label.textColor = .yellow
        label.textAlignment = .center
        return label
    }()
    
    private let saveButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .black
        button.setTitle("SAVE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.text = "SAVE"
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 17.0)
        button.addTarget(self, action: #selector(SmallGameView.saveButton_tapped), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        headerTitle.text = "setting_game_result".localized
        
        [headerView, headerTitle, teamLabelA, teamLabelB, scoreLabelA, scoreLabelB, saveButton].forEach { self.addSubview($0) }

        headerTitle.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: 100, height: 28))
        
        headerView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.leadingAnchor, bottom: teamLabelA.topAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 28))
        
        teamLabelA.anchor(top: nil, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: scoreLabelA.topAnchor, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: 100, height: 36))

        teamLabelB.anchor(top: teamLabelA.topAnchor, leading: teamLabelA.trailingAnchor, bottom: scoreLabelB.topAnchor, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: 100, height: 36))
        
        scoreLabelA.anchor(top: nil, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: 100, height: 50))
        
        scoreLabelB.anchor(top: nil, leading: scoreLabelA.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: 100, height: 50))
        
        saveButton.anchor(top: teamLabelA.topAnchor, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 60), size: .init(width: 50, height: 50))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func saveButton_tapped() {
        let topVC = self.topViewController()
        AlertDialog.showGameResultSaveAlertDialog(viewController: topVC ?? SettingViewController())
    }
}
