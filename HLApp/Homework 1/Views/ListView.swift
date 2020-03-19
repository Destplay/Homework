//
//  ListView.swift
//  HLApp
//
//  Created by Роман on 02.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import SwiftUI

struct ListView: View { 
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.content) { video in
                    VideoCell(video: video, isOpen: self.viewModel.openFirstCell)
                    .onAppear() {
                        if self.viewModel.openFirstCell {
                            self.viewModel.openFirstCell.toggle()
                        }
                    }
                }
            }
            .navigationBarTitle("Content")
        }
    }
}

struct VideoCell: View {
    
    let video: Video
    @State var isOpen: Bool
    
    var body: some View {
        return NavigationLink(destination: DetailVideoView(video: self.video), isActive: $isOpen) {
            Image(uiImage: UIImage(named: self.video.preview)!).resizable().scaledToFit().frame(width: 134.0, height: 100.0)
            VStack(alignment: .leading) {
                Text(self.video.name)
                    .font(.headline)
                Text(self.video.description)
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct DetailVideoView: View {
    
    let video: Video
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: UIImage(named: self.video.preview)!).resizable().scaledToFit()
            Text(self.video.name)
                .font(.headline)
                .padding(5)
            Text(self.video.description)
                .font(.system(size: 12))
                .foregroundColor(Color.gray)
                .padding(5)
            Spacer()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(ViewModel())
    }
}
