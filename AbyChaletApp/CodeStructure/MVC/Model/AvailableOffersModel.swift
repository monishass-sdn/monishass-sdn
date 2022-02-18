//
//  AvailableOffersModel.swift
//  AbyChaletApp
//
//  Created by Srishti on 14/02/22.
//

import Foundation

public class AvailableOffersModel {
    public var status : Bool?
    public var message : String?
    public var offer_list : [Available_Offer_list]?

    public class func modelsFromDictionaryArray(array:NSArray) -> [AvailableOffersModel]
    {
        var models:[AvailableOffersModel] = []
        for item in array
        {
            models.append(AvailableOffersModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        if (dictionary["offer_list"] != nil) { offer_list = Available_Offer_list.modelsFromDictionaryArray(array: dictionary["offer_list"] as! NSArray) }
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")

        return dictionary
    }

}

public class Available_Offer_list {
    public var id : Int?
    public var offer_checkin : String?
    public var offer_checkout : String?
    public var check_in : String?
    public var check_out : String?
    public var offer_expiry : String?
    public var offercreated_at : String?
    public var offered_chalets : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Available_Offer_list]
    {
        var models:[Available_Offer_list] = []
        for item in array
        {
            models.append(Available_Offer_list(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? Int
        offer_checkin = dictionary["offer_checkin"] as? String
        offer_checkout = dictionary["offer_checkout"] as? String
        check_in = dictionary["check_in"] as? String
        check_out = dictionary["check_out"] as? String
        offer_expiry = dictionary["offer_expiry"] as? String
        offercreated_at = dictionary["offercreated_at"] as? String
        offered_chalets = dictionary["offered_chalets"] as? String
        
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.offer_checkin, forKey: "offer_checkin")
        dictionary.setValue(self.offer_checkout, forKey: "offer_checkout")
        dictionary.setValue(self.check_in, forKey: "check_in")
        dictionary.setValue(self.check_out, forKey: "check_out")
        dictionary.setValue(self.offer_expiry, forKey: "offer_expiry")
        dictionary.setValue(self.offercreated_at, forKey: "offercreated_at")
        dictionary.setValue(self.offered_chalets, forKey: "offered_chalets")

        return dictionary
    }

}

