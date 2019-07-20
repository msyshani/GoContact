//
//  EditContactInteractor.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class EditContactInteractor: NSObject {
    weak var presenter:EditContactInteractorToPresenterProtocol?
    var contact:ContactEntity
    var networkService = NetworkUtility()
    
    init(contact:ContactEntity) {
        self.contact = contact
    }

}

extension EditContactInteractor : EditContactPresenterToInteractorProtocol{
    func updateContacts() {
            let urlString = Contstants.API.BASE_URL + Contstants.API.ENDPOINTS.GET_CONTACT.replacingOccurrences(of: "<id>", with: String(contact.id ?? 0))
            networkService.updateContacts(param:contact,urlString: urlString, onSuccess: { (data) in
                if let contatct = try? JSONDecoder().decode(ContactEntity.self, from: data){
                    self.presenter?.contactUpdateRequestCompletedSuccessfully(model: contatct)
                }else{
                    self.presenter?.contactUpdateRequestFailed(withError: NetwokError.parsing)
                }
            }) { (error) in
                self.presenter?.contactUpdateRequestFailed(withError: error)
            }
        
    }
    
    func addContacts() {
        let urlString = Contstants.API.BASE_URL + Contstants.API.ENDPOINTS.CONTACT_LIST
        networkService.addContacts(param:contact,urlString: urlString, onSuccess: { (data) in
            if let contatct = try? JSONDecoder().decode(ContactEntity.self, from: data){
                self.presenter?.contactUpdateRequestCompletedSuccessfully(model: contatct)
            }else{
                self.presenter?.contactUpdateRequestFailed(withError: NetwokError.parsing)
            }
        }) { (error) in
            self.presenter?.contactUpdateRequestFailed(withError: error)
        }
        
    }
    
}
