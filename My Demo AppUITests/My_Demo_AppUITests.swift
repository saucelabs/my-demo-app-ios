//
//  My_Demo_AppUITests.swift
//  My Demo AppUITests
//
//  Created by Erik James on 9/30/21.
//

import XCTest

class My_Demo_AppUITests: MyDemoAppTestBase {

    
    func testAddItemToCart() {
        
        app.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.tap()
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Add To Cart"]/*[[".buttons[\"Add To Cart\"].staticTexts[\"Add To Cart\"]",".staticTexts[\"Add To Cart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 3).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
        
        
        XCTAssert(app.staticTexts["1 Items"].exists)
        
    }
    
    func testAddMultipleItems() {
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.tap()
        
        let addToCartStaticText = app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Add To Cart"]/*[[".buttons[\"Add To Cart\"].staticTexts[\"Add To Cart\"]",".staticTexts[\"Add To Cart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        addToCartStaticText.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 3).children(matching: .other).element
        let button = element.children(matching: .other).element(boundBy: 0).children(matching: .button).element
        button.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.tap()
        addToCartStaticText.tap()
        button.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.children(matching: .other).element.tap()
        addToCartStaticText.tap()
        element.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
        
        
        XCTAssert(app.staticTexts["3 Items"].exists)
        
    }

}
