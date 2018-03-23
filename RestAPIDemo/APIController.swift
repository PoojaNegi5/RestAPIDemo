//
//  APIController.swift
//  RestAPIDemo
//
//  Created by Appinventiv on 20/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation

class APIController{
    
    func getModel(userEnteredText : String, success :@escaping(DataModel) -> Void )
    {
        print("Control passed from View controller to API Controller")
        
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "6d31b713-caf8-493c-894d-5937290a7f60"
        ]
        
        let requiredText : String = userEnteredText.replacingOccurrences(of: " ", with: "+")
    
        let url : URL = URL.init(string : "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(requiredText)&key=AIzaSyDI-aWqj-fJGhW0EaKtB_Csrt6VYEA3SMc")!
        infoLabel.text = infoLabel.text! + "Control passed to Network Controller\n"
        NetworkController().fetchData(currentURL: url, headers: headers) { (dataFetched) in
            
            DispatchQueue.main.async {
                infoLabel.text = infoLabel.text! + "Passing DataModel TO View Controller\n"
            }
           success(DataModel.init(jsonData: dataFetched))
        }
            
    }
    
}
