//
//  EditContactPresenter.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

enum EditContactCellType{
    case firstName
    case lastName
    case mobile
    case email
    
    var identifier: String {
        switch self {
        case .firstName:
            return "First Name"
        case .lastName:
            return "Last Name"
        case .mobile:
            return "mobile"
        case .email:
            return "email"
        }
    }

}

class EditContactPresenter: NSObject {
    weak var view : EditContactPresenterToViewProtocol?
    var interactor : EditContactPresenterToInteractorProtocol?
    var router : EditContactPresenterToRouterProtocol?
    
    var cellArray = [EditContactCellType.firstName, EditContactCellType.lastName, EditContactCellType.mobile, EditContactCellType.email]
}

extension EditContactPresenter: EditContactViewToPresenterProtocol{
    func viewDidLoad() {
        
    }
    
    func addContact(){
        if let _ = interactor?.contact.id{
            self.interactor?.updateContacts()
        }else{
            self.interactor?.addContacts()
        }
        
    }
    
    //TableView
    func numberOfSection()->Int{
        return 1 //Will change later
    }
    
    func numberOfRow(inSection section:Int)->Int{
        return 4 //Will change later
    }
    
    func contactDetail(atIndexPath index:IndexPath)->(EditContactCellType, String){
        //return conatctList[index.row] //Will change later
        guard let model = interactor?.contact else{
            return (.firstName, "")
        }
        
        switch cellArray[index.row] {
        case .firstName:
            return (EditContactCellType.firstName, model.firstName)
        case .lastName:
            return (EditContactCellType.lastName, model.lastName)
        case .mobile:
            return (EditContactCellType.mobile, model.phoneNumber ?? "")
        case .email:
            return (EditContactCellType.email, model.email ?? "")
        }
    }
    
    func selectRow(atIndexPath index:IndexPath){
        //self.router?.pushContactDetailScreen(from: self.view, forContact: conatctList[index.row])
    }
}

extension EditContactPresenter:  EditContactInteractorToPresenterProtocol{
    func contactUpdateRequestCompletedSuccessfully(model: ContactEntity) {
        DispatchQueue.main.async {
            if let _ = self.interactor?.contact.id{
                self.view?.showSuccess(message: "Contact updated successfully")
            }else{
                self.view?.showSuccess(message: "Contact added successfully")
            }
            self.interactor?.contact = model
        }
        
        
        
    }
    
    func contactUpdateRequestFailed(withError error: Error) {
        self.view?.displayError(errorMessage: error.localizedDescription)
    }
    
    
}

extension EditContactPresenter : EditContactTextFieldDelegate {
    func textchange(onType type:EditContactCellType, text:String){
        switch type {
        case .firstName:
            self.interactor?.contact.firstName = text
        case .lastName:
            self.interactor?.contact.lastName = text
        case .mobile:
            self.interactor?.contact.phoneNumber = text
        case .email:
            self.interactor?.contact.email = text
        }
    }
    
}
