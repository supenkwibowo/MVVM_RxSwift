//
//  DataStoreTest.swift
//  MVVM_RxSwiftTests
//
//  Created by Sugeng Wibowo on 10/02/20.
//  Copyright © 2020 Sugeng Wibowo. All rights reserved.
//

import XCTest

@testable import MVVM_RxSwift

class DataStoreTest: XCTestCase {

    func testDefaultStoredItems() {
        let dataStore = DataStore()
        
        XCTAssertTrue(value(of: dataStore.items)!.isEmpty)
    }
    
    func testAddingItem() {
        let dataStore = DataStore()
        
        dataStore.add(entry: "Jenny")
        dataStore.add(entry: "Holland")
        
        XCTAssertEqual(
            value(of: dataStore.items),
            [ "Jenny", "Holland" ]
        )
    }
    
    func testInstanceShouldBeShared() {
        XCTAssertTrue(DataStore.instance === DataStore.instance)
    }

}
