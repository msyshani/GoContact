//
//  EditContactTableCell.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class EditContactTableCell: UITableViewCell ,ReusableViewProtocol {
    //ReuseHandler
    static var reuseIdentifier = "EditContactTableCell"
    static var nib: UINib? {
        return UINib(nibName: String(describing: EditContactTableCell.self), bundle: nil)
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var cellType: EditContactCellType?
    weak var delegate:EditContactTextFieldDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //textField.addTarget(self, action: #selector(EditContactTextValueChanged), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(key:EditContactCellType, value:String){
        self.cellType = key
        nameLabel.text = key.identifier
        textField.text = value
    }
    
    @IBAction func EditContactTextValueChanged() {
        if let delegate = self.delegate{
            delegate.textchange(onType: cellType ?? .firstName, text: textField.text ?? "")
        }
    }
    
}
