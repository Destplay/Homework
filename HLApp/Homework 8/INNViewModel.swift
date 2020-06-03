//
//  INNViewModel.swift
//  HLApp
//
//  Created by Роман on 03.06.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Combine
import SwiftUI

class INNViewModel: ObservableObject {
    @Published var text: String = "" {
        didSet {
            if self.text.count >= 10 {
                self.message = self.text.isValidINN() ? "Номер введен верно" : "Номер введен не верно"
                self.color = self.text.isValidINN() ? .green : .orange
            } else {
                self.message = "Небходимо ввести символов: \(10 - self.text.count)"
                self.color = .blue
            }
        }
    }
    
    @Published var message: String = ""
    @Published var color: Color = .black
}
