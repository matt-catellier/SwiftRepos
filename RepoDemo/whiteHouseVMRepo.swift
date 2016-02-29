//
//  WhiteHouseRepo.swift
//  RepoDemo
//
//  Created by Matthew Catellier on 2016-02-28.
//  Copyright © 2016 Matthew Catellier. All rights reserved.
//

import Foundation
import UIKit

public class whiteHouseVMRepo {
    
    let url = "https://www.whitehouse.gov/facts/json/all/economy"
    
    func getJSONData( controller : MyTableViewController ) {
        
        let url:NSURL = NSURL(string: self.url)!
        let session   = NSURLSession.sharedSession()
        let request   = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let task = session.dataTaskWithRequest(request) {
        (
        let data, let response, let error) in
        
        guard let _:NSData = data, let _:NSURLResponse = response
        where error == nil else {
        print("error")
        return
        }
        
        dispatch_async(dispatch_get_main_queue(), {
        let json = NSString(data: data!,
        encoding: NSASCIIStringEncoding)
        self.extractJSON(controller, data: json!)
        return
        })
        }
        task.resume()
    }
    
    func extractJSON(controller : MyTableViewController,data:NSString) {
            var parseError: NSError?
            let jsonData:NSData = data.dataUsingEncoding(NSASCIIStringEncoding)!
            let json: AnyObject?
            do {
            json = try NSJSONSerialization.JSONObjectWithData(jsonData,
            options: [])
            print(json)
        }
            catch let error as NSError {
            parseError = error
            json = nil
            }
            if (parseError == nil) {
            if let list = json as? NSArray {
            for (var i = 0; i < list.count ; i++ ) {
            if let data_block = list[i] as? NSDictionary {
            // Automatically create object from JSON & add to array
            controller.jsonArray.append(whiteHouseVM(add: data_block))
            }
            }
            // Refresh table once data is loaded.
            controller.refreshTable()
            }
            }
    }

}
