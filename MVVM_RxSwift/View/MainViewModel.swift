//
//  MainViewModel.swift
//  MVVM_RxSwift
//
//  Created by Sugeng Wibowo on 08/02/20.
//  Copyright © 2020 Sugeng Wibowo. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class MainViewModel {
    let searchText = BehaviorRelay<String?>(value: "")
    let items: Driver<[String]>
    
    private let dataStore: DataStore
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
        defaultItems.forEach(dataStore.add(entry:))
        items =
            Observable.combineLatest(
                dataStore.items,
                searchText.asObservable()
            )
            .map {
                let (items, searchKeyword) = $0
                if let searchKeyword = searchKeyword, !searchKeyword.isEmpty {
                    return items.filter { $0.contains(searchKeyword) }
                } else {
                    return items
                }
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}

private struct NonEmptyString {
    let value: String
    init?(_ value: String?) {
        guard let value = value else { return nil }
        self.value = value
    }
}

private let defaultItems = [
    "Bart",
    "John",
    "Ellana",
    "Thomas",
    "Jake"
]
