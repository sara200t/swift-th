//
//  main.swift
//  ConnectToInternet
//
//  Created by Thanich Juthapisuth on 2017-09-24.
//  Copyright © 2017 Best in Bussiness Software Solution. All rights reserved.
//

import Foundation
/*************************************************************
 Connect to the Internet
 URL Loading System
 - URL (Prepare URL)
 - URLSession (Create Session)
 - URLSessionConfiguration (Config/setup session)
 - URLRequest (Create Request)
 - URLSessionTask (Use Session Task: Data Task, Download Task, Upload Task)
 *************************************************************/
// https://jsonplaceholder.typicode.com/todos/1

// HttpService ----> Web
let service = HttpService()
service.getJSON(endPoint: "https://jsonplaceholder.typicode.com/todos/1", completion: { (json) in
    print(json)
})

let text = readLine()
