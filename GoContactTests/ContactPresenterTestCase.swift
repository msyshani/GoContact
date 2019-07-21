//
//  ContactPresenterTestCase.swift
//  GoContactTests
//
//  Created by Mahendra Yadav on 21/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import XCTest
@testable import GoContact

class ContactPresenterTestCase: XCTestCase {
    
    var presenter:HomePresenter!
    weak var view:MockHomeView!
    var interactor:HomePresenterToInteractorProtocol!
    var router: HomePresenterToRouterProtocol!
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.presenter = HomePresenter()
        self.router = HomeRouter()
        self.interactor = HomeInteractor()
        let view = MockHomeView()
        view.presenter = self.presenter
        self.view = view
        
        self.presenter.view = self.view
        self.presenter.interactor = self.interactor
        self.presenter.router = self.router
        
        self.view.presenter = self.presenter
        self.interactor.presenter = self.presenter
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class MockHomeView: HomePresenterToViewProtocol {
        var presenter: HomeViewToPresenterProtocol?
        
        func reloadTable() {
            
        }
        
        func displayError(errorMessage: String) {
            
        }
        
    }
    
    class MockHomeInteractor: HomePresenterToInteractorProtocol {
        var presenter: HomeInteractorToPresenterProtocol?
        
        func fetchContactsFromService() {
            
        }
        
    }
    
    class MockHomeRouter: HomePresenterToRouterProtocol {
        func pushContactDetailScreen(from view: HomePresenterToViewProtocol?, forContact contact: ContactEntity) {
            
        }
        
        func pushAddContactScreen(from view: HomePresenterToViewProtocol?, forContact contact: ContactEntity) {
            
        }
        
        
    }
    
    func testModel()->[ContactEntity]?{
        let json = """
                   [{
                        "id": 7698,
                        "first_name": "mahendra",
                        "last_name": "yadav",
                        "profile_pic": "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/007/698/original/profile_pic.jpg?1563712825",
                        "favorite": true,
                        "url": "http://gojek-contacts-app.herokuapp.com/contacts/7698.json"
                    }, {
                        "id": 7577,
                        "first_name": "rahul",
                        "last_name": "0002test",
                        "profile_pic": "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/007/577/original/profile_pic.jpg?1563650937",
                        "favorite": true,
                        "url": "http://gojek-contacts-app.herokuapp.com/contacts/7577.json"
                    }, {
                        "id": 7699,
                        "first_name": "vijay",
                        "last_name": "0001test",
                        "profile_pic": "/images/missing.png",
                        "favorite": true,
                        "url": "http://gojek-contacts-app.herokuapp.com/contacts/7699.json"
                    }]
            """
        
        guard let data = json.data(using: .utf8) else{
            XCTFail("Invalid json")
            return nil
        }
        
        if let modelArray = try? JSONDecoder().decode([ContactEntity].self, from: data){
            if modelArray.count != 3{
                XCTFail("Invalid parsing")
                return nil
            }
            
            let model = modelArray.first
            XCTAssert(model?.id == 7698, "Invalid id parsing")
            XCTAssert(model?.firstName == "mahendra", "Invalid first name parsing")
            XCTAssert(model?.lastName == "yadav", "Invalid last name parsing")
            XCTAssert(model?.isFavorite == true, "Invalid favourite key parsing")
            return modelArray
        }else{
            XCTFail("Invalid parsing")
            return nil
        }
        
    }
    
    
    func testTableDataSource(){
        if let modelArray = testModel(){
            self.presenter.groupContactArray = self.presenter.getGroupArray(modelArray: modelArray)
            XCTAssert(self.presenter.groupContactArray.count == 3, "Invalid grouping of array")
            XCTAssert(self.presenter.numberOfSection() == 3, "Invalid grouping of array")
            XCTAssert(self.presenter.numberOfRow(inSection: 1) == 1, "Invalid tableview row count")
            
            let model = self.presenter.contact(atIndexPath: IndexPath(row: 0, section: 0))
            XCTAssert(model.id == 7698, "Invalid id parsing")
            XCTAssert(model.firstName == "mahendra", "Invalid first name parsing")
            XCTAssert(model.lastName == "yadav", "Invalid last name parsing")
            XCTAssert(model.isFavorite == true, "Invalid favourite key parsing")
        }
    }

    func testFetchContact() {
        self.presenter.fetchContact()
    }


}
