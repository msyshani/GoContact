//
//  HomeProtocol.swift
//  GoContact
//
//  Created by Mahendra Yadav on 18/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation
import UIKit

//MARK: Viewcontroller and presenter
protocol HomeViewToPresenterProtocol:class {
    func viewDidLoad()
    func fetchContact()
    func addContact()
    //TableView
    func registerCells(forTableView tableView: UITableView)
    func numberOfSection(indexPath:IndexPath)->Int
    func numberOfRow(inSection indexPath:IndexPath)->Int
    func cellForRow(atIndexPath index:IndexPath)->UITableViewCell
    func selectRow(atIndexPath index:IndexPath)
}

protocol HomePresenterToViewProtocol:class {
    
}

//MARK: Presenter and Interactor
protocol HomePresenterToInteractorProtocol:class {
    
}
protocol HomeInteractorToPresenterProtocol:class {
    
}

//MARK: Presenter and Router
protocol HomePresenterToRouterProtocol:class {
    
}
protocol HomeRouterToPresenterProtocol:class {
    
}
