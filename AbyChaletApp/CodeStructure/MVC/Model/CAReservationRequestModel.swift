//
//  CAReservationRequestModel.swift
//  AbyChaletApp
//
//  Created by Srishti on 12/04/22.
//

import Foundation
class CAReservationRequestModel: NSObject {
    
    static var reservedDetails = CAReservationRequestModel()
    
    var chalet_id : String?
    var chaletName : String?
    var check_in : String?
    var check_out : String?
    var total_paid : String?
    var reward_discount : String?
    var offer_discount : String?
    var deposit : String?
    var status : String?
    var rent : String?
    var remaining : Int?
    var selected_package : String?
    var payBytime : String?
    var cover_photo : String?
    
    
    
    func initWithDictionary(userDictionary : NSDictionary)   {
        chalet_id      = userDictionary.value(forKey: "chalet_id")    != nil ? userDictionary.value(forKey:"chalet_id")! as! String          : ""
        chaletName   = userDictionary.value(forKey: "chaletName")   != nil ? userDictionary.value(forKey:"chaletName")! as! String  : ""
        check_in   = userDictionary.value(forKey: "check_in")   != nil ? userDictionary.value(forKey:"check_in")! as! String  : ""
        check_out   = userDictionary.value(forKey: "check_out")   != nil ? userDictionary.value(forKey:"check_out")! as! String  : ""
        total_paid   = userDictionary.value(forKey: "total_paid")   != nil ? userDictionary.value(forKey:"total_paid")! as! String  : ""
        reward_discount   = userDictionary.value(forKey: "reward_discount")   != nil ? userDictionary.value(forKey:"reward_discount")! as! String  : ""
        offer_discount   = userDictionary.value(forKey: "offer_discount")   != nil ? userDictionary.value(forKey:"offer_discount")! as! String  : ""
        deposit   = userDictionary.value(forKey: "deposit")   != nil ? userDictionary.value(forKey:"deposit")! as! String  : ""
        status   = userDictionary.value(forKey: "status")   != nil ? userDictionary.value(forKey:"status")! as! String  : ""
        rent   = userDictionary.value(forKey: "rent")   != nil ? userDictionary.value(forKey:"rent")! as! String  : ""
        remaining   = userDictionary.value(forKey: "remaining")   != nil ? userDictionary.value(forKey:"remaining")! as! Int  : 0
        selected_package   = userDictionary.value(forKey: "selected_package")   != nil ? userDictionary.value(forKey:"selected_package")! as! String  : ""
        payBytime   = userDictionary.value(forKey: "payBytime")   != nil ? userDictionary.value(forKey:"payBytime")! as! String  : ""
        cover_photo   = userDictionary.value(forKey: "cover_photo")   != nil ? userDictionary.value(forKey:"cover_photo")! as! String  : ""
       
    }
    
    //MARK:- STORE USER RESERVATION DATA
    public class func saveReservationDetails(dictDetails : NSDictionary){
        let data : NSData = NSKeyedArchiver.archivedData(withRootObject: dictDetails) as NSData
        UserDefaults.standard.set(data, forKey: "kCurrentReservationDetails")
        UserDefaults.standard.synchronize()
    }
}
