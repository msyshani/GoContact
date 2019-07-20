//
//  HomeInteractor.swift
//  GoContact
//
//  Created by Mahendra Yadav on 18/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class HomeInteractor: NSObject {
    weak var presenter:HomeInteractorToPresenterProtocol?
    var networkService = NetworkUtility()

}

extension HomeInteractor : HomePresenterToInteractorProtocol{
    //
    func fetchContactsFromService(){
        let urlString = Contstants.API.BASE_URL + Contstants.API.ENDPOINTS.CONTACT_LIST
        networkService.fetchAllContacts(urlString: urlString, onSuccess: { (data) in
            if let contatctArray = try? JSONDecoder().decode([ContactEntity].self, from: data){
                self.presenter?.contactFetchedRequestCompletedSuccessfully(modelArray: contatctArray)
            }else{
                self.presenter?.contactFetchedRequestFailed(withError: NetwokError.parsing)
            }
        }) { (error) in
            self.presenter?.contactFetchedRequestFailed(withError: error)
        }
    }
    
}
