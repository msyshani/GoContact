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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loaderMessageLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        contactTable.estimatedRowHeight = 60
        contactTable.rowHeight = 60 //UITableView.automaticDimension
        fetchContact()
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
    
    @IBAction func retryLoadingContacts(){
        fetchContact()
    }
    
    func fetchContact(){
        self.presenter?.viewDidLoad()
        activityIndicator.startAnimating()
        loaderMessageLabel.isHidden = false
        retryButton.isHidden = true
        contactTable.isHidden = true
        loaderMessageLabel.text = "Plesse wait, Contacts are loading"
    }

}

extension HomeViewController :UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRow(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(self.presenter?.groupContactArray[section].first?.firstName.prefix(1) ?? "M")
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.presenter?.arrayIndexSection ?? [String]()
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
        activityIndicator.stopAnimating()
        loaderMessageLabel.isHidden = true
        contactTable.isHidden = false
        self.contactTable.reloadData()
    }
    
    func displayError(errorMessage:String){
        let alert = UIAlertController(title: "GoContact", message: errorMessage, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .destructive) { (action) in
            self.retryButton.isHidden = false
            self.loaderMessageLabel.text = "Unable to fetch contacts, Please retry"
            self.activityIndicator.stopAnimating()
        }
        let retry = UIAlertAction(title: "Retry", style: .default) { (action) in
            self.fetchContact()
        }
        
        
        alert.addAction(ok)
        alert.addAction(retry)
        self.present(alert, animated: true, completion: nil)
    }
    
}
