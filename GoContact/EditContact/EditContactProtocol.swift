//
//  EditContactProtocol.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation

//MARK: Viewcontroller and presenter
protocol EditContactViewToPresenterProtocol:class {
    var view:EditContactPresenterToViewProtocol? { get set}
    var interactor:EditContactPresenterToInteractorProtocol? { get set}
    var router:EditContactPresenterToRouterProtocol? { get set}
    
    func viewDidLoad()
    func addContact()
    //TableView
    func numberOfSection()->Int
    func numberOfRow(inSection section:Int)->Int
    func contactDetail(atIndexPath index:IndexPath)->(EditContactCellType, String)
    func selectRow(atIndexPath index:IndexPath)
}

protocol EditContactPresenterToViewProtocol:class {
    var presenter: EditContactViewToPresenterProtocol? { get set}
    func showContactDetail(forPost model: ContactEntity)
    func showErrorAlert(title:String , message:String)
    func showSuccess(message: String)
}

//MARK: Presenter and Interactor
protocol EditContactPresenterToInteractorProtocol:class {
    var presenter: EditContactInteractorToPresenterProtocol? { get set}
    var contact:ContactEntity { get set}
    func updateContacts()
    func addContacts()
    
}
protocol EditContactInteractorToPresenterProtocol:class {
    func contactUpdateRequestCompletedSuccessfully(model: ContactEntity)
    func contactUpdateRequestFailed(withError error: Error)
}

//MARK: Presenter and Router
protocol EditContactPresenterToRouterProtocol:class {
    
}
protocol EditContactRouterToPresenterProtocol:class {
    
}

protocol EditContactTextFieldDelegate: class {
    func textchange(onType type:EditContactCellType, text:String)
    
}
