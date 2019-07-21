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
    
    var groupContactArray = [[ContactEntity]]()
    var conatctList: [ContactEntity] = []
    var contactsCount: Int {
        return conatctList.count
    }
    var arrayIndexSection = [String]()


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
        let contact = ContactEntity(dict: [:])
        self.router?.pushAddContactScreen(from: self.view, forContact: contact)
    }
    
    func getGroupArray(modelArray:[ContactEntity])->[[ContactEntity]]{
        self.conatctList = modelArray.sorted(by: { $0.firstName < $1.firstName })
        let groupContactArray = self.conatctList.reduce([[ContactEntity]]()) {
            guard var last = $0.last else { return [[$1]] }
            var collection = $0
            if last.first!.firstName.prefix(1) == $1.firstName.prefix(1) {
                last += [$1]
                collection[collection.count - 1] = last
            } else {
                self.arrayIndexSection.append(String([$1].first?.firstName.prefix(1) ?? "Z"))
                collection += [[$1]]
            }
            return collection
        }
        
        return groupContactArray
    }
    
    //TableView
    func numberOfSection()->Int{
        return groupContactArray.count //Will change later
    }
    
    func numberOfRow(inSection section:Int)->Int{
        return groupContactArray[section].count //Will change later
    }
    
    func contact(atIndexPath index:IndexPath)->ContactEntity{
        return  groupContactArray[index.section][index.row]//conatctList[index.row] //Will change later
    }
    
    func selectRow(atIndexPath index:IndexPath){
        self.router?.pushContactDetailScreen(from: self.view, forContact: conatctList[index.row])
    }
    
}

extension HomePresenter:HomeInteractorToPresenterProtocol{
    func contactFetchedRequestCompletedSuccessfully(modelArray:[ContactEntity]){
        DispatchQueue.main.async {
            self.groupContactArray = self.getGroupArray(modelArray: self.conatctList)
            self.view?.reloadTable()
        }
    }
    
    func contactFetchedRequestFailed(withError error: Error){
        DispatchQueue.main.async {
            self.view?.displayError(errorMessage: error.localizedDescription)
        }
        
    }
    
    
}
