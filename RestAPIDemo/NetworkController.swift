//
//  NetworkController.swift
//  RestAPIDemo
//
//  Created by Appinventiv on 20/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation

 class NetworkController{
    
    func fetchData(currentURL : URL,headers : [String:String]? = [String:String](),success : @escaping ([String:Any]) -> Void ) {
        print("Control passed from API controller to Network Controller")
    let request = NSMutableURLRequest(url: currentURL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
        
     infoLabel.text = infoLabel.text! + "Passing Raw data to Network Controller\n"
        
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error!)
        } else {
            let _ = response as? HTTPURLResponse
        }
        guard let dataObject = data else {return}
        let dataFetched =  try! JSONSerialization.jsonObject(with: dataObject, options: .mutableContainers)
        DispatchQueue.main.async {
             infoLabel.text = infoLabel.text! + "Passing JSON TO API Controller\n"
        }
        
        success(dataFetched as! [String:Any])
        
    })
    dataTask.resume()

    }
}

