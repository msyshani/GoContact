//
//  GoContactUITests.swift
//  GoContactUITests
//
//  Created by Mahendra Yadav on 18/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import XCTest

class GoContactUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testContactScreen(){
        let table = app.tables.children(matching: .cell).element(boundBy: 3).staticTexts["contactScreenCell"]
        XCTAssertTrue(table.waitForExistence(timeout: 30))
        table.tap()
        
        let contactButton = app.navigationBars["Contact Detail"].buttons["Contact"]
        XCTAssertTrue(contactButton.waitForExistence(timeout: 3))
        contactButton.tap()
        
        
    }
    
    func testContactDetailScreen(){
        
        let tablesQuery = app.tables
        let table = app.tables.children(matching: .cell).element(boundBy: 3).staticTexts["contactScreenCell"]
        XCTAssertTrue(table.waitForExistence(timeout: 30))
        table.tap()
        
        app.navigationBars["Contact Detail"].buttons["Edit"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["EditContactcancelButton"]/*[[".buttons[\"cancelButton\"]",".buttons[\"EditContactcancelButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["contactDetailMessageButton"]/*[[".buttons[\"messageButton\"]",".buttons[\"contactDetailMessageButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["contactDetailCallButton"]/*[[".buttons[\"callButton\"]",".buttons[\"contactDetailCallButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["contactDetailMailButton"]/*[[".buttons[\"mailButton\"]",".buttons[\"contactDetailMailButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["contactDetailFavouriteButton"]/*[[".buttons[\"favouriteButton\"]",".buttons[\"contactDetailFavouriteButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    
    func testContactEditScreen(){
        let tablesQuery = app.tables
        let table = app.tables.children(matching: .cell).element(boundBy: 3).staticTexts["contactScreenCell"]
        XCTAssertTrue(table.waitForExistence(timeout: 60))
        table.tap()
        
        app.navigationBars["Contact Detail"].buttons["Edit"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["EditContactcancelButton"]/*[[".buttons[\"cancelButton\"]",".buttons[\"EditContactcancelButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    
    func testAddContact(){
        let addButton = app.navigationBars["Contact"].buttons["Add"]
        addButton.tap()
        
        let tablesQuery = app.tables
        let firstName = tablesQuery/*@START_MENU_TOKEN@*/.textFields["First Name"]/*[[".cells.textFields[\"First Name\"]",".textFields[\"First Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        if firstName.exists{
            firstName.tap()
            firstName.typeText("Mahendra")
        }
        
        let lastNameTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Last Name"]/*[[".cells.textFields[\"Last Name\"]",".textFields[\"Last Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        if lastNameTextField.exists{
            lastNameTextField.tap()
            lastNameTextField.typeText("Yadav")
        }
        
        let mobileTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["mobile"]/*[[".cells.textFields[\"mobile\"]",".textFields[\"mobile\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        if mobileTextField.exists{
            mobileTextField.tap()
            mobileTextField.typeText("9935523882")
        }
        
        let emailTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["email"]/*[[".cells.textFields[\"email\"]",".textFields[\"email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        if emailTextField.exists{
            emailTextField.tap()
            emailTextField.typeText("msy@gmail.com")
        }
        
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["EditContactDoneButton"]/*[[".buttons[\"doneButton\"]",".buttons[\"EditContactDoneButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let alertButton = app.alerts["GoContact"].buttons["OK"]
        XCTAssertTrue(alertButton.waitForExistence(timeout: 10))
        alertButton.tap()
        
    }
    
    func testAddContactError(){
        let addButton = app.navigationBars["Contact"].buttons["Add"]
        addButton.tap()
        
        let tablesQuery = app.tables
        let editcontactdonebuttonButton = tablesQuery/*@START_MENU_TOKEN@*/.buttons["EditContactDoneButton"]/*[[".buttons[\"doneButton\"]",".buttons[\"EditContactDoneButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(editcontactdonebuttonButton.waitForExistence(timeout: 2))
        editcontactdonebuttonButton.tap()
        
        let okButton = app.alerts["Error"].buttons["OK"]
        XCTAssertTrue(okButton.waitForExistence(timeout: 2))
        okButton.tap()
        
        let firstName = tablesQuery/*@START_MENU_TOKEN@*/.textFields["First Name"]/*[[".cells.textFields[\"First Name\"]",".textFields[\"First Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        if firstName.exists{
            firstName.tap()
            firstName.typeText("Mahendra")
        }
        
        
        editcontactdonebuttonButton.tap()
        okButton.tap()
        
        let lastNameTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Last Name"]/*[[".cells.textFields[\"Last Name\"]",".textFields[\"Last Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        if lastNameTextField.exists{
            lastNameTextField.tap()
            lastNameTextField.typeText("Yadav")
        }
        
        editcontactdonebuttonButton.tap()
        okButton.tap()
        
        let mobileTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["mobile"]/*[[".cells.textFields[\"mobile\"]",".textFields[\"mobile\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        if mobileTextField.exists{
            mobileTextField.tap()
            mobileTextField.typeText("9935523882")
        }
        
        editcontactdonebuttonButton.tap()
        okButton.tap()
        
        let emailTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["email"]/*[[".cells.textFields[\"email\"]",".textFields[\"email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        if emailTextField.exists{
            emailTextField.tap()
            emailTextField.typeText("msy@gmail.com")
        }
        
        
        editcontactdonebuttonButton.tap()
        let alertButton = app.alerts.buttons["OK"]
        XCTAssertTrue(alertButton.waitForExistence(timeout: 10))
        alertButton.tap()
        
        
    }

}
