//
//  ReusableHandler.swift
//  GoContact
//
//  Created by Mahendra Yadav on 19/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension ReusableViewProtocol {
    static var reuseIdentifier: String { return String(describing: Self.self) }
    static var nib: UINib? { return UINib(nibName: String(describing: Self.self), bundle: nil) }
}

extension UITableView{
    
    func registerReusableViewCell<T: UITableViewCell>(_: T.Type) where T: ReusableViewProtocol {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableViewCell<T: ReusableViewProtocol>(indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
}

extension UICollectionView{
    
    func registerReusableViewCell<T: UICollectionViewCell>(_: T.Type) where T: ReusableViewProtocol {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableViewProtocol {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
    
}
