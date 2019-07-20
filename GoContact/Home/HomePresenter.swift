//
//  HomePresenter.swift
//  GoContact
//
//  Created by Mahendra Yadav on 18/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class HomePresenter: NSObject {
    weak var view:HomePresenterToViewProtocol?
    var interactor:HomePresenterToInteractorProtocol?
    var router:HomePresenterToRouterProtocol?

}

extension HomePresenter:HomeViewToPresenterProtocol{
    
    func viewDidLoad(){
        //Fetch contacts from service
        fetchContact()
    }
    
    func fetchContact(){
        
    }
    
    func addContact(){
        
    }
    
    //TableView
    func registerCells(forTableView tableView: UITableView) {
    }
    
    func numberOfSection(indexPath:IndexPath)->Int{
        return 1 //Will change later
    }
    
    func numberOfRow(inSection indexPath:IndexPath)->Int{
        return 10 //Will change later
    }
    
    func cellForRow(atIndexPath index:IndexPath)->UITableViewCell{
        return UITableViewCell() //Will change later
    }
    
    func selectRow(atIndexPath index:IndexPath){
        
    }
    
}

extension HomePresenter:HomeInteractorToPresenterProtocol{
    func contactFetchedRequestCompletedSuccessfully(modelArray:[ContactEntity]){
        self.view?.reloadTable()
    }
    
    func contactFetchedRequestFailed(withError error: Error){
        self.view?.displayError(errorMessage: error.localizedDescription)
    }
    
    
}
