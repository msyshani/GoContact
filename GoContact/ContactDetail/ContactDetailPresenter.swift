//
//  ContactDetailPresenter.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class ContactDetailPresenter: NSObject {
    weak var view:ContactDetailPresenterToViewProtocol?
    var interactor:ContactDetailPresenterToInteractorProtocol?
    var router:ContactDetailPresenterToRouterProtocol?
    
    var contact:ContactEntity?{
        return self.interactor?.contact ?? nil
    }

}

extension ContactDetailPresenter: ContactDetailViewToPresenterProtocol{
    func viewDidLoad() {
        if let conatctsEntity = self.interactor?.contact {
            self.view?.showContactDetail(forContact: conatctsEntity)
            self.interactor?.fetchContactsFromService()
        }
    }
    
    func sendMessage() {
        
    }
    
    func makeCall() {
        
    }
    
    func sendEmail() {
        
    }
    
    func makeFavaourite(){
        
    }
    
    func editContact(){
        if let conatctsEntity = self.interactor?.contact {
            self.router?.pushContactEditScreen(from: self.view, forContact: conatctsEntity)
        }
        
    }
}

extension ContactDetailPresenter:  ContactDetailInteractorToPresenterProtocol{
    func contactFetchedRequestCompletedSuccessfully(model: ContactEntity) {
        DispatchQueue.main.async {
            self.interactor?.contact = model
            self.view?.showContactDetail(forContact: model)
        }
        
    }
    
    func contactFetchedRequestFailed(withError error: Error) {
        DispatchQueue.main.async {
    
        }
        
    }
    
    
}
