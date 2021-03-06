//
//  ServiceManager.swift
//
//  Created by Visakh Srishti on 04/05/21.
//  Copyright © 2021 Visakh M P. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

//let kBaseUrl            = "https://sicsapp.com/Aby_chalet/"
let kBaseUrl = "https://ss.stagingsdei.com:3188/" // use this Base URL (Live)
    //"https://sicsapp.com/Aby_chalet/"
    //"https://web.sicsglobal.com/aby_chalet/"


class ServiceManager: NSObject {
    
    static let sharedInstance = ServiceManager()
    
    var completionHandler : (Bool, AnyObject?, NSError?)->() = {_,_,_ in }
    
    //MARK:- Get Method for Parsing Data
    func getMethodAlamofire(_ serviceName : String, param : Parameters?,withHud isHud: Bool, completion : @escaping (Bool, AnyObject?, NSError?)->Void)
    {
        if isHud {
             //KRProgressHUD.show()
        }
        completionHandler = completion
        if let url = URL(string: kBaseUrl + serviceName) {
            AF.request(url, method: .get, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:AFDataResponse<Any>) in
                if isHud {
                    //KRProgressHUD.dismiss()
                }
                switch response.result {
                case .success(let jsonData):
                    
                    let dictionary = jsonData as! NSDictionary
                    let status:String = dictionary.object(forKey: "status") as! String
                    if(status == "ok"){
                        completion(true, response.value as AnyObject , nil)
                    }else{
                        self.completionHandler(false,nil,nil )
                    }
                case .failure(let error): completion(false,nil,error as NSError)
                    break
                }
            }
        }
    }
    
    //MARK:- Post Method for Parsing Data
    func postMethodAlamofire(_ serviceName : String, dictionary : Parameters?,withHud isHud: Bool, completion : @escaping (Bool, AnyObject?, NSError?)->Void) {
        if isHud {
            SVProgressHUD.show()
        }
        completionHandler = completion
        if let url = URL(string: kBaseUrl + serviceName) {
            let header:HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
            AF.request(url, method: .post, parameters: dictionary, encoding: URLEncoding.httpBody, headers: header ).responseJSON { (response:AFDataResponse<Any>) in
                if isHud {
                    SVProgressHUD.dismiss()
                }
                switch response.result {
                case .success(let jsonData):
                    
                    let dictionary = jsonData as! NSDictionary
                    let status:Bool = dictionary.object(forKey: "status") as! Bool
                    if status {
                        completion(true, response.value as AnyObject , nil)
                        //self.getModalObject(serviceUrl: serviceName, response: response)
                    }else{
                        self.completionHandler(true,response.value as AnyObject,nil)
                    }
                case .failure(let error): completion(false,nil,error as NSError)
                    break
                }
            }
        }
    }
    func postMethodAlamofireGetMessage(_ serviceName : String, dictionary : Parameters?,withHud isHud: Bool, completion : @escaping (Bool, AnyObject?, NSError?)->Void) {
        
        completionHandler = completion
        if let url = URL(string: kBaseUrl + serviceName) {
            let header:HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
            AF.request(url, method: .post, parameters: dictionary, encoding: URLEncoding.httpBody, headers: header ).responseJSON { (response:AFDataResponse<Any>) in
               
                switch response.result {
                case .success(let jsonData):
                    
                    let dictionary = jsonData as! NSDictionary
                    let status:Bool = dictionary.object(forKey: "status") as! Bool
                    if status {
                        completion(true, response.value as AnyObject , nil)
                        //self.getModalObject(serviceUrl: serviceName, response: response)
                    }else{
                        self.completionHandler(true,response.value as AnyObject,nil)
                    }
                case .failure(let error): completion(false,nil,error as NSError)
                    break
                }
            }
        }
    }
    func uploadSingleData(_ serviceName : String, parameters : Parameters?,imgdata : Data?,filename: String,mimetype: String,withHud isHud: Bool, completion : @escaping (Bool, AnyObject?, NSError?)->Void)
    {
        if isHud {
            SVProgressHUD.show()
        }
        completionHandler = completion
        
        let header : HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append( imgdata!, withName: filename, fileName: filename, mimeType: mimetype)
                if parameters != nil {
                    for (key, value) in parameters! {
                        multipartFormData.append(("\(value)").data(using: .utf8)!, withName: key)
                    }
                }
            },to: kBaseUrl + serviceName, method: .post , headers: header)
            .responseJSON(completionHandler: { response in
                if isHud {
                    SVProgressHUD.dismiss()
                }
                print(response)
                switch response.result {
                case .success(let jsonData):
                    
                    let dictionary = jsonData as! NSDictionary
                    let status:Bool = dictionary.object(forKey: "status") as! Bool
                    if status {
                        completion(true, response.value as AnyObject , nil)
                        //self.getModalObject(serviceUrl: serviceName, response: response)
                    }else{
                        self.completionHandler(true,response.value as AnyObject,nil)
                    }
                case .failure(let error):
                    completion(false,nil,error as NSError)
                    break
                }
            })
    }
    
    func checkBlockStatus( completion : @escaping (Bool, AnyObject?, NSError?)->Void) {
        let serviceName = "api/block_user"
        let Dic = ["userid": CAUser.currentUser.id!]
        completionHandler = completion
        if let url = URL(string: kBaseUrl + serviceName) {
            let header:HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
            AF.request(url, method: .post, parameters: Dic, encoding: URLEncoding.httpBody, headers: header ).responseJSON { (response:AFDataResponse<Any>) in
          
                switch response.result {
                case .success(let jsonData):
                    
                    let dictionary = jsonData as! NSDictionary
                    let status:Bool = dictionary.object(forKey: "status") as! Bool
                    if status {
                        completion(true, response.value as AnyObject , nil)
                        //self.getModalObject(serviceUrl: serviceName, response: response)
                    }else{
                        self.completionHandler(true,response.value as AnyObject,nil)
                    }
                case .failure(let error): completion(false,nil,error as NSError)
                    break
                }
            }
        }
    }
    func postMethodAlamofire(_ serviceName : String, dictionary : Parameters?,withHud isHud: Bool,rowData:Data, completion : @escaping (Bool, AnyObject?, NSError?)->Void) {
        if isHud {
            SVProgressHUD.show()
        }
        completionHandler = completion
        if let url = URL(string: kBaseUrl + serviceName) {
            let header:HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = rowData as Data
            request.headers = header
            AF.request(request).responseJSON { (response:AFDataResponse<Any>) in
                if isHud {
                    SVProgressHUD.dismiss()
                }
                switch response.result {
                case .success(let jsonData):
                    
                    let dictionary = jsonData as! NSDictionary
                    let status:Bool = dictionary.object(forKey: "status") as! Bool
                    if status {
                        completion(true, response.value as AnyObject , nil)
                        //self.getModalObject(serviceUrl: serviceName, response: response)
                    }else{
                        self.completionHandler(true,response.value as AnyObject,nil)
                    }
                case .failure(let error): completion(false,nil,error as NSError)
                    break
                }
            }
        }
    }
}


