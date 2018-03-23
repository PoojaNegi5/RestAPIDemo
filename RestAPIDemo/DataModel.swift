//
//  DataModel.swift
//  RestAPIDemo
//
//  Created by Appinventiv on 20/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation

struct DataModel {
    var results:[Results]
    init(jsonData :[String:Any])
    {
        let resultArr = jsonData["results"] as? [[String:Any]] ?? []
        results = resultArr.map({Results.init(json: $0)})
    }
}
struct Results{
    var name : String
    var address : String
    init(json:[String:Any]){
        name = json["name"] as? String ?? ""
        address = json["formatted_address"] as? String ?? ""
    }
}

