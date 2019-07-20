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
            self.view?.showContactDetail(forPost: conatctsEntity)
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
        
    }
}

extension ContactDetailPresenter:  ContactDetailInteractorToPresenterProtocol{
    func contactFetchedRequestCompletedSuccessfully(modelArray: [ContactEntity]) {
        
    }
    
    func contactFetchedRequestFailed(withError error: Error) {
        
    }
    
    
}
