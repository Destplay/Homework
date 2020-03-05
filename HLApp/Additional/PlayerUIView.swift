//
//  PlayerUIView.swift
//  HLApp
//
//  Created by Роман on 05.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import SwiftUI
import AVKit

struct PlayerView: UIViewRepresentable {
    
    var player: AVPlayer
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) { }
    
    func makeUIView(context: Context) -> UIView {
    
        return PlayerUIView(frame: .zero, player: self.player)
    }
    
    func play() {
        
    }
}

class PlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    private var player: AVPlayer?
    
    init(frame: CGRect, player: AVPlayer) {
        super.init(frame: frame)
        
        self.player = player
        
        self.playerLayer.player = player
        self.layer.addSublayer(playerLayer)
    }
    
    deinit {
        self.player = nil
        self.playerLayer.removeFromSuperlayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer.frame = bounds
    }
}
