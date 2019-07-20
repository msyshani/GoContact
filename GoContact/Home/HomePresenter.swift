//
//  HomePresenter.swift
//  GoContact
//
//  Created by Mahendra Yadav on 18/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation

class HomePresenter: NSObject {
    weak var view:HomePresenterToViewProtocol?
    var interactor:HomePresenterToInteractorProtocol?
    var router:HomePresenterToRouterProtocol?
    
    var conatctList: [ContactEntity] = []
    var contactsCount: Int {
        return conatctList.count
    }

}

extension HomePresenter:HomeViewToPresenterProtocol{

    func viewDidLoad(){
        //Fetch contacts from service
        fetchContact()
        
    }
    
    func fetchContact(){
        interactor?.fetchContactsFromService()
    }
    
    func addContact(){
        
    }
    
    //TableView
    func numberOfSection()->Int{
        return 1 //Will change later
    }
    
    func numberOfRow(inSection section:Int)->Int{
        return contactsCount //Will change later
    }
    
    func contact(atIndexPath index:IndexPath)->ContactEntity{
        return conatctList[index.row] //Will change later
    }
    
    func selectRow(atIndexPath index:IndexPath){
        
    }
    
}

extension HomePresenter:HomeInteractorToPresenterProtocol{
    func contactFetchedRequestCompletedSuccessfully(modelArray:[ContactEntity]){
        self.conatctList = modelArray
        self.view?.reloadTable()
    }
    
    func contactFetchedRequestFailed(withError error: Error){
        self.view?.displayError(errorMessage: error.localizedDescription)
    }
    
    
}
