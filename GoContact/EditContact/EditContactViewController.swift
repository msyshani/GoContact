//
//  EditContactViewController.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class EditContactViewController: UIViewController {
    @IBOutlet weak var contactEditTable: UITableView!
    @IBOutlet weak var contactImage: UIImageView!
    var presenter: EditContactViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        contactEditTable.estimatedRowHeight = 60
        contactEditTable.rowHeight = 60 //UITableView.automaticDimension
        contactImage.layer.cornerRadius = 75
        contactImage.layer.borderColor = UIColor.white.cgColor
        contactImage.layer.borderWidth = 5.0
        self.presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func registerCells(){
        self.contactEditTable.registerReusableViewCell(EditContactTableCell.self)
    }
    
    @IBAction func saveContactButtonClicked(){
        presenter?.addContact()
    }
    
    @IBAction func cancelButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonClicked(){
        
    }
    

}

extension EditContactViewController :UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRow(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EditContactTableCell = tableView.dequeueReusableViewCell(indexPath: indexPath)
        if let (key, value) = self.presenter?.contactDetail(atIndexPath: indexPath){
            cell.configureCell(key: key, value: value)
            cell.delegate = self.presenter as? EditContactTextFieldDelegate
        }
        return cell
    }
    
}

extension EditContactViewController : EditContactPresenterToViewProtocol{
    
    func setupView(){
        if let imageStr = self.presenter?.interactor?.contact.profilePicUrl{
            ImageDownloader.downloader.getDownloadedImage(urlStr: imageStr) { (image) in
                if let img = image{
                    self.contactImage.image = img
                }
            }
        }
    }
    
    func showContactDetail(forPost model: ContactEntity) {
        
    }
    
    func showSuccess(message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) {[weak self] (action) in
            //retry api call
            self?.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title:String , message:String){
        
    }
    
    func showErrorAlert(title:String , message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
