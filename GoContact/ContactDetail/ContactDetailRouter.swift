//
//  ContactDetailRouter.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class ContactDetailRouter: NSObject {
    
    static var storyboard : UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func createContactDetailModule(entity:ContactEntity)->UIViewController?{
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ContactDetailViewController")  as? ContactDetailViewController {
            let presenter: ContactDetailViewToPresenterProtocol & ContactDetailInteractorToPresenterProtocol  = ContactDetailPresenter()
            let interactor : ContactDetailPresenterToInteractorProtocol = ContactDetailInteractor(contact: entity)
            let router : ContactDetailPresenterToRouterProtocol = ContactDetailRouter()
            
            //Presenter
            presenter.view = viewController
            presenter.interactor = interactor
            presenter.router = router
            //Interatcor
            interactor.presenter = presenter
            //View
            viewController.presenter = presenter
            return viewController
        }
        
        return nil
    }

}

extension ContactDetailRouter : ContactDetailPresenterToRouterProtocol{
    
}
