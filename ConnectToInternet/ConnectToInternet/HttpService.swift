//
//  HttpService.swift
//  ConnectToInternet
//
//  Created by Thanich Juthapisuth on 2017-09-24.
//  Copyright © 2017 Best in Bussiness Software Solution. All rights reserved.
//

import Foundation

class HttpService {
    
    let session:URLSession
    
    init() {
        
        // setup session
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }
    
    func getJSON(endPoint: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: endPoint) else {
            print("Error: Cannot create URL")
            return
        }
        
        let todoRequest = URLRequest(url: url)
        let task = session.dataTask(with: todoRequest) { (data, response, error) in
            // check error
            guard error == nil else {
                print("Error calling getTodo")
                return
            }
            // check response data
            guard let responseData = data else {
                print("No data is being returned")
                return
            }
            
            if let json:String = String(data: responseData, encoding: String.Encoding.utf8) {
                completion(json)
            }
            // In case the above is missed, we have to do escape completion
            completion("")
            print("Done")
        }
        task.resume()
    }
}
