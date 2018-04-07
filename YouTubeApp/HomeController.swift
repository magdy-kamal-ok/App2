//
//  ViewController.swift
//  YouTubeApp
//
//  Created by magdy on 3/19/18.
//  Copyright © 2018 magdy. All rights reserved.
//

import UIKit
class HomeController: UICollectionViewController ,UICollectionViewDelegateFlowLayout{

//    var videos:[Video]={
//        var blankChannel = Channel()
//        blankChannel.name = "taylor Swit"
//        blankChannel.profileImageName = "images"
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "taylor swift - blank space"
//        blankSpaceVideo.thumbnailImageName = "images"
//        blankSpaceVideo.channel = blankChannel
//        blankSpaceVideo.numberOfViews = 346544646
//        
//        
//        var bloodChannel = Channel()
//        bloodChannel.name = "taylor Swit"
//        bloodChannel.profileImageName = "images"
//        var bloodSpaceVideo = Video()
//        bloodSpaceVideo.title = "taylor swift - blank space"
//        bloodSpaceVideo.thumbnailImageName = "images"
//        bloodSpaceVideo.channel = bloodChannel
//        bloodSpaceVideo.numberOfViews = 32666216
//        
//        return [blankSpaceVideo,bloodSpaceVideo]
//    }()
    
    let titles:[String] = ["   Home","   Trending","   Subscription","   Account"]
    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchVideos()
        navigationController?.navigationBar.isTranslucent = false
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.backgroundColor = UIColor.white
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        self.navigationItem.titleView = titleLabel
        //self.navigationItem.title = "Home"
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        //collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.isPagingEnabled = true
    }
    func setupNavBarButtons(){
        let searchImage = UIImage(named: "trend")?.withRenderingMode(.alwaysTemplate)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "subs")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton,searchBarButtonItem]
    }
    func handleSearch(){
        scrollToMenuIndex(menuIndex: 2)
    }
    
    func scrollToMenuIndex(menuIndex:Int)
    {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: .init(rawValue: 0), animated: true)
        setTitleForIndex(index: menuIndex)
    }
    private func setTitleForIndex(index:Int){
        if let titleLabel = navigationItem.titleView as? UILabel{
            titleLabel.text = titles[Int(index)]
        }
    }
    lazy var settingsLancher:SettingsLancher={
        let lancher = SettingsLancher()
        lancher.homeController = self
        
        return lancher
    }()
    func handleMore(){
        // show menu 
        settingsLancher.showSettings()
        
    }
    func showControllerForSetting(setting:Setting){
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        dummySettingsViewController.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    lazy var menuBar:MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb;
    }()
    
    private func setupMenuBar(){
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31, alpha: 1)
        view.addSubview(redView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = videos?.count
//        {
//            return count
//        }
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier:String
        if indexPath.item == 1{
            identifier = trendingCellId
               //return collectionView.dequeueReusableCell(withReuseIdentifier: trendingCellId, for: indexPath)
            
        }
        
        else if indexPath.item == 2{
            //return collectionView.dequeueReusableCell(withReuseIdentifier: subscriptionCellId, for: indexPath)
            identifier = subscriptionCellId
        }
        else {
            identifier = cellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)//as! VideoCell
        //cell.video = videos?[indexPath.item]
        let collors:[UIColor] = [UIColor.black,UIColor.blue,UIColor.brown,UIColor.cyan,UIColor.purple]
        cell.backgroundColor = collors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.width - 32)*9/16
        return CGSize(width: view.frame.width, height: view.frame.height-50)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x/4
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x/view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .init(rawValue: 0))
        setTitleForIndex(index: Int(index))
        
    }
    
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = videos?.count
//        {
//            return count
//        }
//        return 0
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)as! VideoCell
//        cell.video = videos?[indexPath.item]
//        //cell.backgroundColor = UIColor.blue
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.width - 32)*9/16
//        return CGSize(width: view.frame.width, height: height+16+88)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}




