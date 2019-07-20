//
//  HomeProtocol.swift
//  GoContact
//
//  Created by Mahendra Yadav on 18/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation

//MARK: Viewcontroller and presenter
protocol HomeViewToPresenterProtocol:class {
    func viewDidLoad()
    func fetchContact()
    func addContact()
    //TableView
    func registerCells()
    func numberOfSection()->Int
    func numberOfRow(inSection section:Int)->Int
    func contact(atIndexPath index:IndexPath)->ContactEntity
    func selectRow(atIndexPath index:IndexPath)
}

protocol HomePresenterToViewProtocol:class {
    func reloadTable()
    func displayError(errorMessage:String)
}

//MARK: Presenter and Interactor
protocol HomePresenterToInteractorProtocol:class {
    func fetchContactsFromService()
    
}
protocol HomeInteractorToPresenterProtocol:class {
    func contactFetchedRequestCompletedSuccessfully(modelArray:[ContactEntity])
    func contactFetchedRequestFailed(withError error: Error)
    
}

//MARK: Presenter and Router
protocol HomePresenterToRouterProtocol:class {
    
}
protocol HomeRouterToPresenterProtocol:class {
    
}
