//
//  InputViewController.swift
//  MVVM_RxSwift
//
//  Created by Sugeng Wibowo on 10/02/20.
//  Copyright © 2020 Sugeng Wibowo. All rights reserved.
//

import UIKit
import RxSwift

class InputViewController: UIViewController {
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    private let viewModel = InputViewModel(dataStore: DataStore.instance)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CompositeDisposable(
            viewModel.inputText.twoWayBind(to: inputText.rx.text),
            viewModel.isAddEnabled.drive(addButton.rx.isEnabled),
            addButton.rx.tap.asSignal().emit(to: viewModel.add),
            viewModel.dismiss.emit(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
        ).disposed(by: disposeBag)
    }
    
}
