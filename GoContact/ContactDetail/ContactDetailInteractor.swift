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
    
    init(contact:ContactEntity) {
        self.contact = contact
    }
}

extension ContactDetailInteractor : ContactDetailPresenterToInteractorProtocol{
    func fetchContactsFromService() {
        
    }
    
    
}
