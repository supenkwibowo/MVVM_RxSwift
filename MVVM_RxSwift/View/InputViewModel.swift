//
//  InputViewModel.swift
//  MVVM_RxSwift
//
//  Created by Sugeng Wibowo on 10/02/20.
//  Copyright © 2020 Sugeng Wibowo. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class InputViewModel {
    let inputText = BehaviorRelay<String?>(value: "")
    let isAddEnabled: Driver<Bool>
    
    let add = PublishRelay<Void>()
    let dismiss: Signal<Void>
    
    private let dataStore: DataStore
    private let disposeBag = DisposeBag()
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
        
        let cleanedInput = inputText.compactMap(cleanInput(_:))
        
        isAddEnabled = cleanedInput.map { !$0.isEmpty }
            .asDriver(onErrorDriveWith: .empty())
        
        dismiss = add.asSignal(onErrorSignalWith: .empty())
        
        add.withLatestFrom(cleanedInput)
            .subscribe(onNext: { [weak self] in self?.dataStore.add(entry: $0) })
            .disposed(by: disposeBag)
    }
}

private func cleanInput(_ text: String?) -> String {
    guard let text = text else { return "" }
    return text.trimmingCharacters(in: .whitespacesAndNewlines)
}
