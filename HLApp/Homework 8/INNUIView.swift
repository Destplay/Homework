//
//  viewINNUIView.swift
//  HLApp
//
//  Created by Роман on 03.06.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import SwiftUI

struct INNUIView: View {
    @EnvironmentObject var viewModel: INNViewModel
    
    var body: some View {
        VStack {
            Text("Валидация номера ИНН.")
            Text("Пример: 7731347089")
                .font(.footnote)
                .foregroundColor(.gray)
            TextField("Введите номер ИНН", text: self.$viewModel.text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text(self.viewModel.message)
                .foregroundColor(self.viewModel.color)
        }
    }
}

struct viewINNUIView_Previews: PreviewProvider {
    static var previews: some View {
        INNUIView().environmentObject(INNViewModel())
    }
}
