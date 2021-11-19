//
//  BaseViewModel.swift
//  CoffeeExplorer
//
//  Created by ar on 19/11/2021.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    @Published var showError = false
    @Published var isLoading = false
    private(set) var errorMessage = ""
    
    var subscriptions: Set<AnyCancellable> = []
    let errorSubject = PassthroughSubject<NetworkError, Never>()
    
    //MARK:- Error binding
    func bindErrorSubject() {
        errorSubject
            .map { error -> String in
                error.errorDescription
            }
            .assign(to: \.errorMessage, on: self)
            .store(in: &subscriptions)
        
        errorSubject
            .map { _ in true }
            .assign(to: \.showError, on: self)
            .store(in: &subscriptions)
    }
}
