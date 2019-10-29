//
//  SettingViewController.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/10/12.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//


import UIKit
 
final class SettingViewController: UIViewController {
 
    private let tableSections: Array = [" ", " ", " ", " "]
    private let tableRowTitles: Array = [
        ["setting_share".localized],
        ["setting_team_name_a".localized, "setting_team_name_b".localized],
        ["setting_reset".localized],
        ["app_version".localized]
    ]
    
    private let reusableCellId: String = "Cell"
    
    private var tableView: UITableView!
    public var scoreView: ScoreView = ScoreView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let width: CGFloat = self.view.frame.width
        let height: CGFloat = self.view.frame.height
        
        let navbarHeight: CGFloat = self.getNavbarHeight()
        
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: navbarHeight))
        
        let navigationItem = UINavigationItem(title: "setting_title".localized)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done(_:)))
        navigationItem.rightBarButtonItem = doneBtn
        navigationBar.setItems([navigationItem], animated: false)
        self.view.addSubview(navigationBar)

        tableView = UITableView(frame: CGRect(x: 0, y: navbarHeight, width: width, height: height))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reusableCellId)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func done(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getNavbarHeight() -> CGFloat {
        
        var height = 49.0
        if UIDevice.current.userInterfaceIdiom == .phone {
            height = 30.0
        }
        
        return CGFloat(height)
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRowTitles[section].count
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSections[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 { // シェア
            let shareText = "\(scoreView.teamLabelA.text ?? "") \(scoreView.scoreLabelA.text ?? "") - \(scoreView.scoreLabelB.text ?? "") \(scoreView.teamLabelB.text ?? "")"

            let activityItems = [shareText]

            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = scoreView
            activityViewController.popoverPresentationController?.permittedArrowDirections = .down
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: scoreView.frame.width, height: scoreView.frame.height/2)
            
            
            self.present(activityViewController, animated: true, completion: nil)
        }
        else if indexPath.section == 1 && indexPath.row == 0 {
            AlertDialog.showTeamNameEditFromSettingVC(title: "team_a_name_edit".localized, team: TEAM_NAME_A, teamLabel: scoreView.teamLabelA, tableView: tableView, indexPath: indexPath, viewController: self)
        }
        else if indexPath.section == 1 && indexPath.row == 1 {
            AlertDialog.showTeamNameEditFromSettingVC(title: "team_b_name_edit".localized, team: TEAM_NAME_B, teamLabel: scoreView.teamLabelB, tableView: tableView, indexPath: indexPath, viewController: self)
        }
        else if indexPath.section == 2 && indexPath.row == 0 { // リセット
            self.scoreView.reset()
            self.dismiss(animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reusableCellId, for: indexPath)
//        cell.textLabel!.text = "\(tableRowTitle[indexPath.row])"
        
        switch indexPath.section {
        case 0:
            switch indexPath.row { // セクション1
            case 0: //シェア
                cell.textLabel?.text = tableRowTitles[indexPath.section][indexPath.row]
                cell.textLabel?.textColor = .systemBlue
                return cell
            default:
                break
            }
        case 1:
            switch indexPath.row { // セクション2
            case 0: //チーム名前編集（左）
                
                if cell.detailTextLabel == nil {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: reusableCellId)
                }
                
                cell.textLabel?.text = tableRowTitles[indexPath.section][indexPath.row]
                cell.textLabel?.textColor = .systemBlue
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cell.detailTextLabel?.text = scoreView.teamLabelA.text ?? ""
                } else {
                    let teamNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
                    teamNameLabel.center = CGPoint(x: self.view.frame.width - 50, y: cell.frame.height/2)
                    teamNameLabel.textAlignment = .center
                    teamNameLabel.text = scoreView.teamLabelA.text ?? ""
                    teamNameLabel.textColor = .systemGray
                    cell.contentView.addSubview(teamNameLabel)
                }
                
                return cell
            case 1: //チーム名前編集（右）
                
                if cell.detailTextLabel == nil {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: reusableCellId)
                }
                
                cell.textLabel?.text = tableRowTitles[indexPath.section][indexPath.row]
                cell.textLabel?.textColor = .systemBlue
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cell.detailTextLabel?.text = scoreView.teamLabelB.text ?? ""
                } else {
                    let teamNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
                    teamNameLabel.center = CGPoint(x: self.view.frame.width - 50, y: cell.frame.height/2)
                    teamNameLabel.textAlignment = .center
                    teamNameLabel.text = scoreView.teamLabelB.text ?? ""
                    teamNameLabel.textColor = .systemGray
                    cell.contentView.addSubview(teamNameLabel)
                }
                
                return cell
            default:
                break
            }
        case 2:
            switch indexPath.row { // セクション3
            case 0://リセット
                cell.textLabel?.text = tableRowTitles[indexPath.section][indexPath.row]
                cell.textLabel?.textColor = .systemBlue
                return cell
            default:
                break
            }
        case 3:
            switch indexPath.row { // セクション4
            case 0:// バージョン
                if cell.detailTextLabel == nil {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: reusableCellId)
                }
                cell.textLabel?.text = tableRowTitles[indexPath.section][indexPath.row]
                cell.detailTextLabel?.text = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "Unknown"
                
                return cell
            default:
                break
            }
        default:
            return UITableViewCell()
        }
        
//        if indexPath.row == 0 { // リセット
//            cell.textLabel?.textColor = .systemBlue
//        }
//        else if indexPath.row == 1 { // バージョン
//            if cell.detailTextLabel == nil {
//                cell = UITableViewCell(style: .value1, reuseIdentifier: reusableCellId)
//            }
//            cell.textLabel?.text = "\(tableRowTitle[indexPath.row])"
//            cell.detailTextLabel?.text = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "Unknown"
//        }
        
        return cell
    }
    
    @objc func switchAutoBuzzer(_ sender : UISwitch!){

        if sender.isOn {
            userdefaults.set(true, forKey: BUZEER_AUTO_BEEP)
        } else {
            userdefaults.set(false, forKey: BUZEER_AUTO_BEEP)
        }
    }
}
