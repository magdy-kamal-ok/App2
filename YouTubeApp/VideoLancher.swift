//
//  VideoLancher.swift
//  YouTubeApp
//
//  Created by magdy on 4/9/18.
//  Copyright © 2018 magdy. All rights reserved.
//

import UIKit
import AVFoundation
class VideoPlayerView: UIView {
    
    let controlsContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let activityIndicator:UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    lazy var  pausePlayButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pause", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    let videoLengthLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    let videoCurrentLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    
    lazy var videoSlider:UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .red
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    var player:AVPlayer?
    var isPlaying = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        setupGradientLayer()
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        backgroundColor = UIColor.black
        
        controlsContainerView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: controlsContainerView.rightAnchor,constant:-8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor,constant:-2).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        controlsContainerView.addSubview(videoCurrentLabel)
        videoCurrentLabel.leftAnchor.constraint(equalTo: controlsContainerView.leftAnchor,constant:8).isActive = true
        videoCurrentLabel.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor,constant:-2).isActive = true
        videoCurrentLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoCurrentLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        controlsContainerView.addSubview(videoSlider)
        
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: videoCurrentLabel.rightAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func handlePause(){
        if isPlaying{
            player?.pause()
            pausePlayButton.setTitle("Play", for: .normal)
            
        }
        else{
            player?.play()
            pausePlayButton.setTitle("Pause", for: .normal)
            
        }
        
        isPlaying = !isPlaying
    }
    
    func handleSliderChange(){
        
        if let duration = player?.currentItem?.duration
        {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
        
        
            let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        
            player?.seek(to: seekTime, completionHandler: { (CompletedSeek) in
            
            })
        }
    }
    
    private func setupPlayerView(){
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = NSURL(string: urlString){
            
            player = AVPlayer(url: url as URL)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            // track player progress
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                let seconds = Int(CMTimeGetSeconds(progressTime))
                let secondsText = String(format: "%02d", (seconds%60))
                let minutesText = String(format: "%02d", (seconds/60))
                
                self.videoCurrentLabel.text = "\(minutesText):\(secondsText)"
                
                if let duration = self.player?.currentItem?.duration
                {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    let value = Float64(seconds) / durationSeconds
                    self.videoSlider.value = Float(value)
                        
                    
                }
                
            })
        }
    }
    
    private func setupGradientLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradientLayer.locations = [0.7,1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "currentItem.loadedTimeRanges"
        {
            activityIndicator.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
            pausePlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration
            {
                
                let seconds = Int(CMTimeGetSeconds(duration))
                let secondsText = (seconds % 60)
                let minutesText = String(format: "%02d", (seconds/60))
                
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
                
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoLancher: NSObject {
    
    func showVideoPlayer(){
        
        if let keyWindow = UIApplication.shared.keyWindow
        {
            let view = UIView(frame:keyWindow.frame)
            view.backgroundColor = UIColor.white
            view.frame = CGRect(x: keyWindow.frame.width-10, y: keyWindow.frame.height-10, width: 10, height: 10)
            // 9/16 is the aspect rathio for all the HD videos
            let height = keyWindow.frame.width * 9/16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                view.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    
    
    }
}
