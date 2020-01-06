//
//  SettingViewController.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/10/12.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//


import UIKit
 
final class SettingViewController: UIViewController {
 
    private let tableSections: Array = [" ", " ", " ", " ", " ", " "]
    private let tableRowTitles: Array = [
        ["setting_game_history".localized],
        ["setting_share".localized],
        ["setting_team_name_a".localized, "setting_team_name_b".localized],
        ["setting_foulcount_display".localized],
        ["setting_reset".localized],
        ["app_version".localized]
    ]
    
    private let reusableCellId: String = "Cell"
    
    private var tableView: UITableView = UITableView()
    public var gameView: GameView = GameView()
    private var scrollView: UIScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let width: CGFloat = self.view.frame.width
        let height: CGFloat = self.view.frame.height
        
        let closeBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: self, action: #selector(close(_:)))

        self.navigationItem.title = "setting_title".localized
        self.navigationItem.leftBarButtonItem = closeBtn

        let barHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        scrollView.frame = CGRect(x: 0, y: barHeight, width: width, height: height)
        scrollView.contentSize = CGSize(width: width, height: height*2)
        scrollView.backgroundColor = .systemBackground
        scrollView.isScrollEnabled = true
        self.view.addSubview(scrollView)
        
        let smallGameView = SmallGameView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 28 + 88))
        self.scrollView.addSubview(smallGameView)

        tableView.frame = CGRect(x: 0, y: smallGameView.frame.height, width: width, height: height*2)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reusableCellId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.isScrollEnabled = false
        self.scrollView.addSubview(tableView)

//        scrollView.anchor(top: navigationBar.bottomAnchor, leading: self.tableView.leadingAnchor, bottom: tableView.bottomAnchor, trailing: self.tableView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func close(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
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
        if indexPath.section == 0 && indexPath.row == 0 { // 試合履歴
            let gameHistoryViewController = GameHistoryViewController()
            self.navigationController?.pushViewController(gameHistoryViewController, animated: true)
        }
        else if indexPath.section == 1 && indexPath.row == 0 { // シェア
            let shareText = "\(gameView.teamLabelA.text ?? "") \(gameView.scoreLabelA.text ?? "") - \(gameView.scoreLabelB.text ?? "") \(gameView.teamLabelB.text ?? "")"

//            UIGraphicsBeginImageContext(self.view.bounds.size)
//            self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
            
//            let activityItems = [shareText, image!] as [Any]
            let activityItems = [shareText]

            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = gameView
            activityViewController.popoverPresentationController?.permittedArrowDirections = .down
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: gameView.frame.width, height: gameView.frame.height/2)
            
            
            self.present(activityViewController, animated: true, completion: nil)
        }
        else if indexPath.section == 2 && indexPath.row == 0 { // チームA名前編集
            AlertDialog.showTeamNameEdit(title: "team_a_name_edit".localized, team: Consts.TEAM_NAME_A, teamLabel: gameView.teamLabelA, viewController: self)
        }
        else if indexPath.section == 2 && indexPath.row == 1 { // チームB名前編集
            AlertDialog.showTeamNameEdit(title: "team_b_name_edit".localized, team: Consts.TEAM_NAME_B, teamLabel: gameView.teamLabelB, viewController: self)
        }
        else if indexPath.section == 4 && indexPath.row == 0 { // リセット
            self.gameView.reset()
            self.dismiss(animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reusableCellId, for: indexPath)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row { // セクション1
            case 0: // 試合履歴
                cell.textLabel?.text = tableRowTitles[indexPath.section][indexPath.row]
                cell.textLabel?.textColor = .systemBlue
                return cell
            default:
                break
            }
        case 1:
            switch indexPath.row { // セクション2
            case 0: //シェア
                cell.textLabel?.text = tableRowTitles[indexPath.section][indexPath.row]
                cell.textLabel?.textColor = .systemBlue
                return cell
            default:
                break
            }
        case 2:
            switch indexPath.row { // セクション2
            case 0: //チーム名前編集（左）
                
                if cell.detailTextLabel == nil {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: reusableCellId)
                }
                
                cell.textLabel?.text = tableRowTitles[indexPath.section][indexPath.row]
                cell.textLabel?.textColor = .systemBlue
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cell.detailTextLabel?.text = gameView.teamLabelA.text ?? ""
                } else {
                    let teamNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
                    teamNameLabel.center = CGPoint(x: self.view.frame.width - 50, y: cell.frame.height/2)
                    teamNameLabel.textAlignment = .center
                    teamNameLabel.text = gameView.teamLabelA.text ?? ""
                    teamNameLabel.textColor = .systemGray
                    cell.contentView.addSubview(teamNameLabel)
                }
                
                return cell
            case 1: // チーム名前編集（右）
                
                if cell.detailTextLabel == nil {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: reusableCellId)
                }
                
                cell.textLabel?.text = tableRowTitles[indexPath.section][indexPath.row]
                cell.textLabel?.textColor = .systemBlue
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cell.detailTextLabel?.text = gameView.teamLabelB.text ?? ""
                } else {
                    let teamNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
                    teamNameLabel.center = CGPoint(x: self.view.frame.width - 50, y: cell.frame.height/2)
                    teamNameLabel.textAlignment = .center
                    teamNameLabel.text = gameView.teamLabelB.text ?? ""
                    teamNameLabel.textColor = .systemGray
                    cell.contentView.addSubview(teamNameLabel)
                }
                
                return cell
            default:
                break
            }
        case 3:
            switch indexPath.row { // セクション3
            case 0:// ファウルカウント表示
                let switchView = UISwitch(frame: .zero)

                if userdefaults.bool(forKey: Consts.DISPLAY_FOULCOUNT) {
                    switchView.setOn(true, animated: true)
                } else {
                    switchView.setOn(false, animated: true)
                }

                switchView.tag = indexPath.row
                switchView.addTarget(self, action: #selector(self.switchDisplayFounlCount(_:)), for: .valueChanged)
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cell.accessoryView = switchView
                } else {
                    switchView.center = CGPoint(x: self.view.frame.width - 50, y: cell.frame.height/2)
                    cell.contentView.addSubview(switchView)
                }
                
                cell.textLabel?.text = tableRowTitles[indexPath.section][indexPath.row]
                cell.selectionStyle = .none
                return cell
            default:
                break
            }
        case 4:
            switch indexPath.row { // セクション4
            case 0://リセット
                cell.textLabel?.text = tableRowTitles[indexPath.section][indexPath.row]
                cell.textLabel?.textColor = .systemBlue
                return cell
            default:
                break
            }
        case 5:
            switch indexPath.row { // セクション5
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
        
        return cell
    }
    
    @objc func switchDisplayFounlCount(_ sender : UISwitch!) {
        if sender.isOn {
            self.gameView.showFoulCount()
            userdefaults.set(true, forKey: Consts.DISPLAY_FOULCOUNT)
        } else {
            self.gameView.hideFoulCount()
            userdefaults.set(false, forKey: Consts.DISPLAY_FOULCOUNT)
        }
    }
}
