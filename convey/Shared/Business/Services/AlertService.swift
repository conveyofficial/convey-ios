//
//  AlertService.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/3/21.
//

import Combine
import Foundation

class AlertService {

    var loadingPublisher = CurrentValueSubject<Bool, Never>(false)
    var alertMessagePublisher = CurrentValueSubject<String, Never>("")
    var alertLoadingPublisher = CurrentValueSubject<Bool, Never>(false)
    var splashLoadingPublisher = CurrentValueSubject<Bool, Never>(false)

    var cancellables = Set<AnyCancellable>()

    init() {
        
        loadingPublisher.sink { status in
            print("LOADER UPDATE WITH STATUS: \(status)")
        }.store(in: &cancellables)
    }

}
