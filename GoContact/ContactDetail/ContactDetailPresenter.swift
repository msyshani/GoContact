//
//  ContactDetailPresenter.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit
import MessageUI

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
        guard let phoneNumber = self.interactor?.contact.phoneNumber else{
            return
        }
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self
            self.view?.showViewController(viewToPresent: controller)
        }
    }
    
    func makeCall() {
        guard let phoneNumber = self.interactor?.contact.phoneNumber else{
            return
        }
        phoneNumber.makeACall()
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            self.view?.showViewController(viewToPresent: mail)
        } else {
            // show failure alert
        }
    }
    
    func makeFavaourite(){
        self.interactor?.contact.isFavorite.toggle()
        self.interactor?.favouriteContacts()
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
            self.view?.displayError(errorMessage: error.localizedDescription)
        }
        
    }
    
    func contactFavouriteRequestCompletedSuccessfully(model: ContactEntity) {
        DispatchQueue.main.async {
            self.interactor?.contact = model
            self.view?.showContactDetail(forContact: model)
        }
        
        
        
    }
    
    func contactFavouriteRequestFailed(withError error: Error) {
        DispatchQueue.main.async {
            self.view?.displayError(errorMessage: error.localizedDescription)
        }
    }
    
    
}


extension ContactDetailPresenter : MFMessageComposeViewControllerDelegate{
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
    }
}

extension ContactDetailPresenter : MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
