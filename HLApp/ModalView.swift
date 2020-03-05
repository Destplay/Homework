//
//  ModalView.swift
//  HLApp
//
//  Created by Роман on 02.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import SwiftUI

struct ModalView: View {
    
    @State var showModalScreen = false
    
    var body: some View {
        Button(action: {
            self.showModalScreen.toggle()
        }) {
            Text("Show detail information")
        }
        .sheet(isPresented: $showModalScreen) {
            DetailView()
        }
    }
}

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark")
            }
            .padding()
            Spacer()
            Text("Detail information")
            Spacer()
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
