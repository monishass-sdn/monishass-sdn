//
//  ReservationRequestResponseModel.swift
//  AbyChaletApp
//
//  Created by Srishti on 02/03/22.
//

import Foundation

public class ReservationRequestResponseModel {
    public var status : Bool?
    public var message : String?
    public var reservation_id : String?
    public var chalet_details : [Reserved_Chalet_details]?

    public class func modelsFromDictionaryArray(array:NSArray) -> [ReservationRequestResponseModel]
    {
        var models:[ReservationRequestResponseModel] = []
        for item in array
        {
            models.append(ReservationRequestResponseModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        reservation_id = dictionary["reservation_id"] as? String
        if (dictionary["chalet_details"] != nil) { chalet_details = Reserved_Chalet_details.modelsFromDictionaryArray(array: dictionary["chalet_details"] as! NSArray) }
    }

    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")
        dictionary.setValue(self.reservation_id, forKey: "reservation_id")

        return dictionary
    }

}

public class Reserved_Chalet_details {
    public var chalet_id : String?
    public var chaletName : String?
    public var check_in : String?
    public var check_out : String?
    public var total_paid : String?
    public var reward_discount : String?
    public var offer_discount : String?
    public var deposit : String?
    public var status : String?
    public var rent : String?
    public var remaining : Int?
    public var selected_package : String?
    public var payBytime : String?
    public var cover_photo : String?


    public class func modelsFromDictionaryArray(array:NSArray) -> [Reserved_Chalet_details]
    {
        var models:[Reserved_Chalet_details] = []
        for item in array
        {
            models.append(Reserved_Chalet_details(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        chalet_id = dictionary["chalet_id"] as? String
        chaletName = dictionary["chaletName"] as? String
        check_in = dictionary["check_in"] as? String
        check_out = dictionary["check_out"] as? String
        total_paid = dictionary["total_paid"] as? String
        reward_discount = dictionary["reward_discount"] as? String
        offer_discount = dictionary["offer_discount"] as? String
        deposit = dictionary["deposit"] as? String
        status = dictionary["status"] as? String
        rent = dictionary["rent"] as? String
        remaining = dictionary["remaining"] as? Int
        selected_package = dictionary["selected_package"] as? String
        payBytime = dictionary["payBytime"] as? String
        cover_photo = dictionary["cover_photo"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.chalet_id, forKey: "chalet_id")
        dictionary.setValue(self.chaletName, forKey: "chaletName")
        dictionary.setValue(self.check_in, forKey: "check_in")
        dictionary.setValue(self.check_out, forKey: "check_out")
        dictionary.setValue(self.total_paid, forKey: "total_paid")
        dictionary.setValue(self.reward_discount, forKey: "reward_discount")
        dictionary.setValue(self.offer_discount, forKey: "offer_discount")
        dictionary.setValue(self.deposit, forKey: "deposit")
        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.rent, forKey: "rent")
        dictionary.setValue(self.remaining, forKey: "remaining")
        dictionary.setValue(self.selected_package, forKey: "selected_package")
        dictionary.setValue(self.payBytime, forKey: "payBytime")
        dictionary.setValue(self.cover_photo, forKey: "cover_photo")

        return dictionary
    }

}
