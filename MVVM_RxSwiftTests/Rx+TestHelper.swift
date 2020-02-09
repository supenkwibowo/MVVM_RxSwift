//
//  Rx+TestHelper.swift
//  MVVM_RxSwiftTests
//
//  Created by Sugeng Wibowo on 09/02/20.
//  Copyright © 2020 Sugeng Wibowo. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxRelay

extension XCTestCase {
    
    /**
     Subscribes and return `BehaviorRelay` that will changed value based on subscription.
     - Parameters:
        - observable: Target for subscription. It can be `Observable`, `Single`, `Relay`, `Subject`, etc...
        - disposeBag: Used for subscription.
     - returns: Last value emitted by target, returns as `BehaviorRelay` with default value `nil`.
    */
    func observe<ObservableType>(_ observable: ObservableType,
                                 disposedBy disposeBag: DisposeBag)
        -> BehaviorRelay<ObservableType.Element?>
        where ObservableType : ObservableConvertibleType {
            let observer = BehaviorRelay<ObservableType.Element?>(value: nil)
            observable.asObservable().bind(to: observer).disposed(by: disposeBag)
            return observer
    }
    
    /**
     Subscribes and return last emitted value. It will dispose the subscription immediately before this function returns.
     
     In case disposal or value emission needs to be delayed, use `observe(_:)` instead.
     
     - parameter of: Target for subscription. It can be `Observable`, `Single`, `Relay`, `Subject`, etc...
     - returns: Last value emitted by target, it always returns `optional` because it will return `nil` if no value is ever emitted.
    */
    func value<ObservableType>(of observable: ObservableType)
        -> ObservableType.Element?
        where ObservableType : ObservableConvertibleType {
            return observe(observable, disposedBy: DisposeBag()).value
    }
}
