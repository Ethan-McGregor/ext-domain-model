//
//  unitTestNewFeat.swift
//  unitTestNewFeat
//
//  Created by studentuser on 4/12/17.
//  Copyright © 2017 Ethan.McGregor. All rights reserved.
//

import XCTest
import ExtDomainModel

class MontyTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    //Testing strign output of fmoney
    func testEuro() {
        let fiveEUR = Money(amount: 5, currency: "EUR")
        XCTAssert(fiveEUR.description() == "EUR5")
    }
    
    func testUSD() {
        let twentyUSD = Money(amount: 20, currency: "USD")
        XCTAssert(twentyUSD.description() == "USD20")
    }
    func testCAN() {
        let oneCAN = Money(amount: 1, currency: "CAN")
        XCTAssert(oneCAN.description() == "CAN1")
    }
    
    //Testing add / subtract of money
    func testAdding() {
        let money = Money(amount: 4, currency: "CAN")
        let otherMoney = Money(amount: 1, currency: "CAN")
        let resultMoney = Money(amount: 5, currency: "CAN")
        XCTAssert((money + otherMoney).amount == 5)
        XCTAssert((money + otherMoney).currency == "CAN")
        XCTAssert((money + otherMoney).amount == resultMoney.amount)
        XCTAssert((money + otherMoney).currency == resultMoney.currency)
    }
    
    func testSubtracting() {
        let money = Money(amount: 10, currency: "USD")
        let otherMoney = Money(amount: 4, currency: "USD")
        let resultMoney = Money(amount: 6, currency: "USD")
        XCTAssert((money - otherMoney).amount == 1)
        XCTAssert((money - otherMoney).currency == "USD")
        XCTAssert((money - otherMoney).amount == resultMoney.amount)
        XCTAssert((money - otherMoney).currency == resultMoney.currency)
    }
    
    
    //Testing money works with Doubles
    func testDoubleE() {
        let money1 = 12.0.EUR
        XCTAssert(money1.description() == "EUR12")
    }
    
    func testDoubleU() {
        let money2 = 34.0.USD
        XCTAssert(money2.description() == "USD34")
    }
    
    func testDoubleG() {
        let money3 = 15.0.GBP
        XCTAssert(money3.description() == "GBP15")
    }
}
