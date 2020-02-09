//
//  Rx+MVVM.swift
//  MVVM_RxSwift
//
//  Created by Sugeng Wibowo on 10/02/20.
//  Copyright © 2020 Sugeng Wibowo. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

extension BehaviorRelay {
    func twoWayBind(to target: ControlProperty<Element>) -> Disposable {
        return CompositeDisposable(
            asDriver().drive(target),
            target.asDriver().drive(self)
        )
    }
}
