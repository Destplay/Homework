//
//  ServiceLocator.swift
//  HLApp
//
//  Created by Роман on 25.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Foundation

final class ServiceLocator {
    
    static var shared = ServiceLocator()
    private var tidingsViewModel: TidingsViewModel?
    private var tidingsServices: TidingsServices?
    
    func getTidingsViewModel() -> TidingsViewModel {
        if let viewModel = self.tidingsViewModel {
            
            return viewModel
        }
        self.tidingsViewModel = TidingsViewModel()
        
        return self.tidingsViewModel!
    }
    
    func getTidingsServices() -> TidingsServices {
        if let services = self.tidingsServices {
            
            return services
        }
        self.tidingsServices = TidingsServices(delegate: ServiceLocator.shared.getTidingsViewModel())
        
        return self.tidingsServices!
    }
}
