//
//  HomeViewController.swift
//  GoContact
//
//  Created by Mahendra Yadav on 18/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var presenter: HomeViewToPresenterProtocol?
    @IBOutlet weak var contactTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        contactTable.estimatedRowHeight = 60
        contactTable.rowHeight = 60 //UITableView.automaticDimension
        self.presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func registerCells(){
        self.contactTable.registerReusableViewCell(ContactTableViewCell.self)
    }

    @IBAction func addContacts(){
        presenter?.addContact()
    }

}

extension HomeViewController :UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRow(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ContactTableViewCell = tableView.dequeueReusableViewCell(indexPath: indexPath)
        if let contactModel = self.presenter?.contact(atIndexPath: indexPath){
            cell.configureCell(model: contactModel)
        }
        cell.selectionStyle = .none
        return cell
    }
    
}

extension HomeViewController :UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.selectRow(atIndexPath: indexPath)
    }
    
}

extension HomeViewController : HomePresenterToViewProtocol{
    func reloadTable(){
        self.contactTable.reloadData()
    }
    
    func displayError(errorMessage:String){
        
    }
    
}
