//
//  HomeRouter.swift
//  GoContact
//
//  Created by Mahendra Yadav on 18/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class HomeRouter: NSObject {
    
    static var bundle : Bundle? {
        return Bundle.init(identifier: "com.msy.GoContact")
    }
    
    static var storyboard : UIStoryboard {
        return UIStoryboard(name: "Main", bundle: bundle)
    }
    
    static func createHomeModule()->UINavigationController?{
        let navController:UINavigationController = storyboard.instantiateViewController(withIdentifier: "ContactsNavigationController") as! UINavigationController
        
        if let viewController = navController.children.first as? HomeViewController {
            let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol  = HomePresenter()
            let interactor : HomePresenterToInteractorProtocol = HomeInteractor()
            let router : HomePresenterToRouterProtocol = HomeRouter()
            
            //Presenter
            presenter.view = viewController
            presenter.interactor = interactor
            presenter.router = router
            //Interatcor
            interactor.presenter = presenter
            //View
            viewController.presenter = presenter
            return navController
        }
        
        return UINavigationController()
    }

}

extension HomeRouter : HomePresenterToRouterProtocol{
    func pushContactDetailScreen(from view: HomePresenterToViewProtocol?, forContact contact: ContactEntity) {
        if let contactDetailViewController = ContactDetailRouter.createContactDetailModule(entity: contact){
            if let sourceView = view as? UIViewController {
                sourceView.navigationController?.pushViewController(contactDetailViewController, animated: true)
            }
        }
    }
    
}
