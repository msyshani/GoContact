//
//  Constants.swift
//  GoContact
//
//  Created by Mahendra Yadav on 19/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation

struct Contstants {
    struct API {
        static let BASE_URL = "http://gojek-contacts-app.herokuapp.com/"
        struct ENDPOINTS {
            static let CONTACT_LIST = "contacts.json"
            static let GET_CONTACT = "contacts/<id>.json"
        }
        
    }
}

enum NetwokError: Error {
    case unknown
    case parsing
    case invalidData
}

extension NetwokError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("Something went wrong", comment: "Unknown Error")
        case .parsing:
            return NSLocalizedString("Unable to parse data form response", comment: "Invalid Error")
        case .invalidData:
            return NSLocalizedString("Response is not is appropriate format", comment: "Invalid data")
        }
    }
}
