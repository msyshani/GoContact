//
//  ContactDetailProtocol.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation

//MARK: Viewcontroller and presenter
protocol ContactDetailViewToPresenterProtocol:class {
    var view:ContactDetailPresenterToViewProtocol? {get set}
    var interactor:ContactDetailPresenterToInteractorProtocol? {get set}
    var router:ContactDetailPresenterToRouterProtocol? {get set}
    
    func viewDidLoad()
    func sendMessage()
    func makeCall()
    func sendEmail()
    func makeFavaourite()
}

protocol ContactDetailPresenterToViewProtocol:class {
    var presenter: ContactDetailViewToPresenterProtocol? {get set}
    func showContactDetail(forPost model: ContactEntity)
    func displayError(errorMessage:String)
}

//MARK: Presenter and Interactor
protocol ContactDetailPresenterToInteractorProtocol:class {
    var presenter:ContactDetailInteractorToPresenterProtocol? {get set}
    var contact:ContactEntity {get set}
    func fetchContactsFromService()
    
}
protocol ContactDetailInteractorToPresenterProtocol:class {
    func contactFetchedRequestCompletedSuccessfully(modelArray:[ContactEntity])
    func contactFetchedRequestFailed(withError error: Error)
    
}

//MARK: Presenter and Router
protocol ContactDetailPresenterToRouterProtocol:class {
    
}
protocol ContactDetailRouterToPresenterProtocol:class {
    
}
