//
//  MainViewModelTest.swift
//  MVVM_RxSwiftTests
//
//  Created by Sugeng Wibowo on 08/02/20.
//  Copyright © 2020 Sugeng Wibowo. All rights reserved.
//

import XCTest
import RxSwift

@testable import MVVM_RxSwift

class MainViewModelTest: XCTestCase {
    
    private var viewModel: MainViewModel!
    private var dataStore: DataStore!
    
    override func setUp() {
        dataStore = DataStore()
        viewModel = MainViewModel(dataStore: dataStore)
    }
    
    func testInitialList() {
        XCTAssertEqual(
            value(of: viewModel.items),
            ["Bart", "John", "Ellana", "Thomas", "Jake"]
        )
    }
    
    func testChangesOnDataStoreShouldBeUpdatedToList() {
        dataStore.add(entry: "Joanne")
        dataStore.add(entry: "George")
        
        XCTAssertEqual(
            value(of: viewModel.items),
            ["Bart", "John", "Ellana", "Thomas", "Jake", "Joanne", "George"]
        )
    }
    
    func testSearchKeywordFilterItems() {
        viewModel.searchText.accept("a")
        
        XCTAssertEqual(
            value(of: viewModel.items),
            ["Bart", "Ellana", "Thomas", "Jake"]
        )
        
        viewModel.searchText.accept("ake")
        
        XCTAssertEqual(
            value(of: viewModel.items),
            ["Jake"]
        )
    }
    
    func testSearchKeywordCaseSensitive() {
        viewModel.searchText.accept("bart")
        
        XCTAssertEqual(
            value(of: viewModel.items),
            []
        )
        
        viewModel.searchText.accept("Bart")
        
        XCTAssertEqual(
            value(of: viewModel.items),
            ["Bart"]
        )
    }
    
    func testChangingSearchKeywordToEmptyStringShouldUnfilterList() {
        viewModel.searchText.accept("Jake")
        viewModel.searchText.accept("")
        
        XCTAssertEqual(
            value(of: viewModel.items),
            ["Bart", "John", "Ellana", "Thomas", "Jake"]
        )
    }

}
