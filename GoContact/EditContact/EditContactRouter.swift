//
//  EditContactRouter.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class EditContactRouter: NSObject {
    
    static var storyboard : UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func createContactEditModule(entity:ContactEntity)->UIViewController?{
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: "EditContactViewController")  as? EditContactViewController {
            let presenter: EditContactViewToPresenterProtocol & EditContactInteractorToPresenterProtocol  = EditContactPresenter()
            let interactor : EditContactPresenterToInteractorProtocol = EditContactInteractor(contact: entity)
            let router : EditContactPresenterToRouterProtocol = EditContactRouter()
            
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

extension EditContactRouter : EditContactPresenterToRouterProtocol{
    
}
