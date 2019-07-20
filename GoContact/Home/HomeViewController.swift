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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController :UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRow(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension HomeViewController :UITableViewDelegate{
    
}

extension HomeViewController : HomePresenterToViewProtocol{
    func reloadTable(){
        self.contactTable.reloadData()
    }
    
    func displayError(errorMessage:String){
        
    }
    
}
