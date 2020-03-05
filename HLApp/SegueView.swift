//
//  ContentView.swift
//  HLApp
//
//  Created by Роман on 02.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import SwiftUI

struct SegueView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                self.$viewModel.selectedTab.wrappedValue = .list
                self.$viewModel.openFirstCell.wrappedValue = true
            }) {
                Text("Segue to Tab")
            }
        }
    }
}

struct SegueView_Previews: PreviewProvider {
    static var previews: some View {
        SegueView(viewModel: ViewModel())
    }
}
