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
    var view:HomePresenterToViewProtocol? {get set}
    var interactor:HomePresenterToInteractorProtocol? {get set}
    var router:HomePresenterToRouterProtocol? {get set}
    
    func viewDidLoad()
    func fetchContact()
    func addContact()
    //TableView
    func numberOfSection()->Int
    func numberOfRow(inSection section:Int)->Int
    func contact(atIndexPath index:IndexPath)->ContactEntity
    func selectRow(atIndexPath index:IndexPath)
}

protocol HomePresenterToViewProtocol:class {
    var presenter: HomeViewToPresenterProtocol? {get set}
    func reloadTable()
    func displayError(errorMessage:String)
}

//MARK: Presenter and Interactor
protocol HomePresenterToInteractorProtocol:class {
    var presenter:HomeInteractorToPresenterProtocol? {get set}
    func fetchContactsFromService()
    
}
protocol HomeInteractorToPresenterProtocol:class {
    func contactFetchedRequestCompletedSuccessfully(modelArray:[ContactEntity])
    func contactFetchedRequestFailed(withError error: Error)
    
}

//MARK: Presenter and Router
protocol HomePresenterToRouterProtocol:class {
    func pushContactDetailScreen(from view: HomePresenterToViewProtocol?, forContact contact: ContactEntity)
    func pushAddContactScreen(from view: HomePresenterToViewProtocol?, forContact contact: ContactEntity)
    
}
protocol HomeRouterToPresenterProtocol:class {
    
}
