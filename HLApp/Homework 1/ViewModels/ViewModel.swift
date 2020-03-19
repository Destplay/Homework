//
//  ViewModel.swift
//  HLApp
//
//  Created by Роман on 05.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Combine
import Foundation

struct Video: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var preview: String
}

class ViewModel: ObservableObject {
    var content = [Video(name: "WWDC 2019 Keynote — Apple", description: "Apple WWDC 2019. One big week. Even bigger announcements. Announcing updates to iOS, watchOS, and macOS.", preview: "PreviewOne"),
                          Video(name: "WWDC 2018 Keynote — Apple", description: "Apple WWDC 2018. Four OS updates. One big day. Take a look at updates for iPhone and iPad, Mac, Apple Watch, and Apple TV.", preview: "PreviewTwo"),
                          Video(name: "Apple — WWDC 2017 Keynote", description: "Apple WWDC 2017. Take a look at our latest announcements. The new iPad Pro. iMac Pro. HomePod. iOS 11. macOS High Sierra. watchOS 4. ", preview: "PreviewThree")]
    
    @Published var selectedTab: RootView.Tab = .segue
    
    @Published var openFirstCell: Bool = false
}
