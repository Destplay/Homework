//
//  RootView.swift
//  HLApp
//
//  Created by Роман on 02.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        TabView(selection: self.$viewModel.selectedTab) {
            SegueView().environmentObject(viewModel)
                .tabItem {
                    Image(systemName: "arrow.right.to.line.alt")
                    Text("Segue")
                }
                .tag(RootView.Tab.segue)
            ListView().environmentObject(viewModel)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("List")
                }
                .tag(RootView.Tab.list)
            ModalView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up")
                    Text("Modal")
                }
                .tag(RootView.Tab.modal)
        }
    }
}

extension RootView {
    enum Tab: Hashable {
        case segue
        case list
        case modal
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {

        RootView().environmentObject(ViewModel())
    }
}
