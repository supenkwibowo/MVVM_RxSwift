//
//  MainViewController.swift
//  MVVM
//
//  Created by Sugeng Wibowo on 06/02/20.
//  Copyright © 2020 Sugeng Wibowo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = MainViewModel(dataStore: DataStore.instance)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CompositeDisposable(
            viewModel.searchText.twoWayBind(to: searchText.rx.text),
            bindToTableView(viewModel.items)
        ).disposed(by: disposeBag)
    }
    
    private func bindToTableView(_ items: Driver<[String]>) -> Disposable {
        items.drive(tableView.rx.items(cellIdentifier: "cell"))
        { _, item, cell in
            cell.textLabel?.text = item
        }
    }

}
