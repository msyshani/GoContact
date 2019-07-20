//
//  NetworkUtility.swift
//  GoContact
//
//  Created by Mahendra Yadav on 19/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

typealias Success = (Data) -> Void
typealias Failure = (Error) -> Void

class NetworkUtility: NSObject {
    
    var urlSession : URLSession{
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }
    
    func getRequest(url:String?)->URLRequest?{
        if let urlString = url{
            if let url = URL(string: urlString){
                let request = URLRequest.init(url: url)
                return request
            }
        }
        return nil
    }
    
    func fetchAllContacts(urlString:String, onSuccess:Success, onError:Failure){
        if let request = getRequest(url: urlString){
            urlSession.dataTask(with: request) { (data, response, error) in
                
                }.resume()
        }
    }
    
    

}
