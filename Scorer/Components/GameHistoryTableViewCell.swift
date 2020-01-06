//
//  GameHistoryTableViewCell.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/12/30.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit

class GameHistoryTableViewCell: UICollectionViewCell {

    var game: Game? {
        didSet {
            teamALabel.text = game?.teamA
            teamBLabel.text = game?.teamB
            
            if let scoreAString = game?.scoreA {
                scoreALabel.text = String(scoreAString)
            }
            
            if let scoreBString = game?.scoreB {
                scoreBLabel.text = String(scoreBString)
            }
            
            if let updatedAtDate = game?.updatedAt {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                updatedAtLabel.text = formatter.string(from: updatedAtDate)
            }
        }
    }
    
    private let teamALabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let teamBLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let scoreALabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DigitalDismay", size: 44.0)
        label.textAlignment = .center
        label.textColor = .yellow
        return label
    }()
    
    private let scoreBLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DigitalDismay", size: 44.0)
        label.textAlignment = .center
        label.textColor = .yellow
        return label
    }()
    
    private let updatedAtLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.layer.cornerRadius = 1
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
        [teamALabel, teamBLabel, scoreALabel, scoreBLabel, updatedAtLabel].forEach { self.addSubview($0) }
        
        teamALabel.anchor(top: self.contentView.topAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 30))

        teamBLabel.anchor(top: self.contentView.topAnchor, leading: nil, bottom: nil, trailing: self.contentView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 30))
        
        scoreALabel.anchor(top: self.teamALabel.bottomAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 20, right: 0), size: .init(width: 100, height: 30))
        
        scoreBLabel.anchor(top: self.teamBLabel.bottomAnchor, leading: nil, bottom: nil, trailing: self.contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0), size: .init(width: 100, height: 30))
        
        updatedAtLabel.anchor(top: nil, leading: nil, bottom: self.contentView.bottomAnchor, trailing: self.contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: .init(width: 100, height: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
