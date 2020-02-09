//
//  InputViewModelTest.swift
//  MVVM_RxSwiftTests
//
//  Created by Sugeng Wibowo on 10/02/20.
//  Copyright © 2020 Sugeng Wibowo. All rights reserved.
//

import XCTest
import RxSwift

@testable import MVVM_RxSwift

class InputViewModelTest: XCTestCase {

    private var viewModel: InputViewModel!
    private var dataStore: DataStore!
    
    override func setUp() {
        dataStore = DataStore()
        viewModel = InputViewModel(dataStore: dataStore)
    }
    
    func testInputIsEmptyByDefault() {
        XCTAssertEqual("", value(of: viewModel.inputText))
    }
    
    func testAddButtonDisabledByDefault() {
        XCTAssertEqual(false, value(of: viewModel.isAddEnabled))
    }
    
    func testAddButtonEnabledWhenInputChangedToNotEmpty() {
        viewModel.inputText.accept("something")
        
        XCTAssertEqual(true, value(of: viewModel.isAddEnabled))
    }
    
    func testAddButtonDisabledWhenInputChangedToEmptyOrWhitespacesOnly() {
        viewModel.inputText.accept("something")
        viewModel.inputText.accept("")
        
        XCTAssertEqual(false, value(of: viewModel.isAddEnabled))
        
        viewModel.inputText.accept("something")
        viewModel.inputText.accept("  \t   ")
        
        XCTAssertEqual(false, value(of: viewModel.isAddEnabled))
    }
    
    func testAddWillSaveEntryToDataStore() {
        viewModel.inputText.accept("random word")
        viewModel.add.accept(())
        
        XCTAssertEqual(value(of: dataStore.items), ["random word"])
    }
    
    func testAddWillSaveTrimmedEntry() {
        viewModel.inputText.accept("   word   \t\n")
        viewModel.add.accept(())
        
        XCTAssertEqual(value(of: dataStore.items), ["word"])
    }
    
    func testAddWillCallDismiss() {
        let disposeBag = DisposeBag()
        var dismissCalled = false
        viewModel.dismiss.emit(onNext: { dismissCalled = true })
            .disposed(by: disposeBag)
        
        viewModel.inputText.accept("keyword")
        
        XCTAssertFalse(dismissCalled)
        
        viewModel.add.accept(())
        
        XCTAssertTrue(dismissCalled)
    }

}
