//
//  SettingViewController.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/10/12.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//


import UIKit
 
class SettingViewController: UIViewController {
 
    private let tableRowTitle: NSArray = [
        "setting_reset".localized,
        "app_version".localized
    ]
    
    private var tableView: UITableView!
    public var scoreView: ScoreView = ScoreView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let width: CGFloat = self.view.frame.width
        let height: CGFloat = self.view.frame.width
        
        let navbarHeight: CGFloat = self.getNavbarHeight()
        
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: navbarHeight))
        let navigationItem = UINavigationItem(title: "setting_title".localized)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done(_:)))
        navigationItem.rightBarButtonItem = doneBtn
        navigationBar.setItems([navigationItem], animated: false)
        self.view.addSubview(navigationBar)

        tableView = UITableView(frame: CGRect(x: 0, y: navbarHeight, width: width, height: height))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        print("Value: \(tableRowTitle[indexPath.row])")
        if indexPath.row == 0 { // リセット
            self.scoreView.reset()
            self.dismiss(animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRowTitle.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(tableRowTitle[indexPath.row])"
        
//        if indexPath.row == 0 {
//            let switchView = UISwitch(frame: .zero)
//
//            if userdefaults.bool(forKey: BUZEER_AUTO_BEEP) {
//                switchView.setOn(true, animated: true)
//            } else {
//                switchView.setOn(false, animated: true)
//            }
//
//            switchView.tag = indexPath.row // for detect which row switch Changed
//            switchView.addTarget(self, action: #selector(self.switchAutoBuzzer(_:)), for: .valueChanged)
//            cell.accessoryView = switchView
//        }
        
        if indexPath.row == 0 { // リセット
            cell.textLabel?.textColor = .systemBlue
        }
        else if indexPath.row == 1 { // バージョン
            if cell.detailTextLabel == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            }
            cell.textLabel?.text = "\(tableRowTitle[indexPath.row])"
            cell.detailTextLabel?.text = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "Unknown"
        }
        
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
