//
//  DataStore.swift
//  MVVM_RxSwift
//
//  Created by Sugeng Wibowo on 10/02/20.
//  Copyright © 2020 Sugeng Wibowo. All rights reserved.
//

import Foundation
import RxSwift

final class DataStore {
    static let instance = DataStore()
    
    private let _items = BehaviorSubject(value: [String]())
    var items: Observable<[String]> { _items.asObservable() }
    
    func add(entry: String) {
        var items = currentItems()
        items.append(entry)
        _items.onNext(items)
    }
    
    private func currentItems() -> [String] {
        guard let items = try? _items.value() else { return [] }
        return items
    }
}
