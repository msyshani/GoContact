//
//  ContactDetailInteractor.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class ContactDetailInteractor: NSObject {
    weak var presenter:ContactDetailInteractorToPresenterProtocol?
    var contact:ContactEntity
    var networkService = NetworkUtility()
    
    init(contact:ContactEntity) {
        self.contact = contact
    }
}

extension ContactDetailInteractor : ContactDetailPresenterToInteractorProtocol{
    func fetchContactsFromService() {
        let urlString = Contstants.API.BASE_URL + Contstants.API.ENDPOINTS.GET_CONTACT.replacingOccurrences(of: "<id>", with: String(contact.id ?? 0))
        networkService.fetchAllContacts(urlString: urlString, onSuccess: { (data) in
            if let contatct = try? JSONDecoder().decode(ContactEntity.self, from: data){
                self.presenter?.contactFetchedRequestCompletedSuccessfully(model: contatct)
            }else{
                self.presenter?.contactFetchedRequestFailed(withError: NetwokError.parsing)
            }
        }) { (error) in
            self.presenter?.contactFetchedRequestFailed(withError: error)
        }
    }
    
    
}
