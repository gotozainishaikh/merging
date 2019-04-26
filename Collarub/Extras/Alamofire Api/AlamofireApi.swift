//
//  AlamofireApi.swift
//  DivTech
//
//  Created by Talha Ahmed on 18/03/2019.
//  Copyright © 2019 Muhammad Kumail. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class AlamofireApi{
    
    var json1 : JSON = []
    
    
    func alamofireApi(url:String,completion: @escaping (JSON) -> Void){
        
        
        var json:JSON!
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.data != nil {
                    json = try? JSON(data: response.data!)
                    
                    completion(json!)
                }
        }
    }
    
    func alamofireApiWithParams(url:String,parameters: [String : String],completion: @escaping (JSON) -> Void){
        
        var json:JSON!
        var error:JSON = ["error" : "server down"]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding(destination: .queryString))
            .responseJSON { response in
                
                if response.data != nil {
                   
                    do{
                        json = try JSON(data: response.data!)
                        completion(json!)
                    }catch{
                        
                        print("error in server")
                    }
                    
                    
                }
                else{
                    error = ["errorelse" : "server down"]
                    completion(error)
                    
                }
                
        }
        
        
    }
    
    func getAlamofireApiWithParams(url:String,parameters: [String : String],completion: @escaping (JSON) -> Void){
        
        var json:JSON!
        var error:JSON = ["error" : "server down"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString))
            .responseJSON { response in
                
                if response.data != nil {
                    
                    do{
                        json = try JSON(data: response.data!)
                        completion(json!)
                    }catch{
                        print("error in server")
                    }
                    
                    
                    
                    
                }
                else{
                    error = ["errorelse" : "server down"]
                    completion(error)
                    
                }
                
        }
        
        
    }
    
}
