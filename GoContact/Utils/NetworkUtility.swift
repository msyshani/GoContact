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
    
    enum HTTPMethod {
        case get
        case post
        case put
    }
    
    func getRequest(url:String?, method:HTTPMethod)->URLRequest?{
        if let urlString = url{
            if let url = URL(string: urlString){
                var request = URLRequest.init(url: url)
                switch method{
                case .get:
                    request.httpMethod = "GET"
                case .post:
                    request.httpMethod = "POST"
                case .put:
                    request.httpMethod = "PUT"
                }
                return request
            }
        }
        return nil
    }
    
    func fetchAllContacts(urlString:String, onSuccess:@escaping Success, onError:@escaping Failure){
        if !Reachability.isConnectedToNetwork(){
            onError(NetwokError.noNetwork)
            return
        }
        if let request = getRequest(url: urlString, method: .get){
            urlSession.dataTask(with: request) { (data, response, error) in
                if let contactData = data{
                    onSuccess(contactData)
                }else if let err = error{
                    onError(err)
                }else{
                    onError(NetwokError.unknown)
                }
            }.resume()
        }
    }
    
    func updateContacts(param:ContactEntity, urlString:String, onSuccess:@escaping Success, onError:@escaping Failure){
        if !Reachability.isConnectedToNetwork(){
            onError(NetwokError.noNetwork)
            return
        }
        if var request = getRequest(url: urlString, method: .put){
            let data = try? JSONEncoder().encode(param)
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            urlSession.dataTask(with: request) { (data, response, error) in
                if let contactData = data{
                    onSuccess(contactData)
                }else if let err = error{
                    onError(err)
                }else{
                    onError(NetwokError.unknown)
                }
                }.resume()
        }
    }
    
    func addContacts(param:ContactEntity, urlString:String, onSuccess:@escaping Success, onError:@escaping Failure){
        if !Reachability.isConnectedToNetwork(){
            onError(NetwokError.noNetwork)
            return
        }
        if var request = getRequest(url: urlString, method: .post){
            let data = try? JSONEncoder().encode(param)
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            urlSession.dataTask(with: request) { (data, response, error) in
                if let contactData = data{
                    onSuccess(contactData)
                }else if let err = error{
                    onError(err)
                }else{
                    onError(NetwokError.unknown)
                }
                }.resume()
        }
    }
    

}
