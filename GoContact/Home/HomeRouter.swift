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
    
    static func createHomeModule()->UIViewController?{
        if let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController{
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
            return viewController
        }
        return nil
    }

}

extension HomeRouter : HomePresenterToRouterProtocol{
    
}
