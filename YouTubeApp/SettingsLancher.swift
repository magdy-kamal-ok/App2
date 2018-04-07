//
//  SettingsLancher.swift
//  YouTubeApp
//
//  Created by magdy on 3/31/18.
//  Copyright © 2018 magdy. All rights reserved.
//

import UIKit
class Setting: NSObject {
    let name:settingName
    let imageName:String
    
    init(name:settingName,imageName:String) {
        self.name = name
        self.imageName = imageName
        
    }
}

enum settingName:String{
    case Cancel = "Cancel"
    case Settings = "Settings"
    case SendFeedBack = "Send Feed Back"
    case Help = "Help"
    case SwichAccount = "Switch Account"
    case TermsAndCondtions = "Terms And Conditions"
    case Empty = ""
 }
class SettingsLancher: NSObject ,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let blackView = UIView()
    let collectionView:UICollectionView={
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
        
    }()
    let settings:[Setting]={
        
        return [Setting(name: .Settings, imageName: "home"),
                Setting(name: .TermsAndCondtions, imageName: "home"),
                Setting(name: .SendFeedBack, imageName: "home"),
                Setting(name: .Help, imageName: "home"),
                Setting(name: .SwichAccount, imageName: "home"),
                Setting(name: .Cancel, imageName: "home")]
    }()
    let cellHeight:CGFloat = 50
    var homeController :HomeController?
    func showSettings(){
        // show menu
        
        if let window = UIApplication.shared.keyWindow
        {
            
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let height:CGFloat = CGFloat(settings.count) * cellHeight
            let y:CGFloat = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }, completion: nil)
            
            
        }
        
    }
    func handleDismiss(setting:Setting){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow{
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }, completion: {(completed:Bool)in
            if setting.name != .Empty && setting.name != .Cancel{
                self.homeController?.showControllerForSetting(setting:setting)
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return settings.count ?? 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)as? SettingsCell
        //cell.backgroundColor = UIColor.blue
        let setting = settings[indexPath.item]
        cell?.setting = setting
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
    }
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: "cellId")
    }
}
