//
//  OfferChaletListModel.swift
//  AbyChaletApp
//
//  Created by Srishti on 15/02/22.
//

import Foundation

public class OfferChaletListModel {
    public var status : Bool?
    public var message : String?
    public var max_offer_count : String?
    public var check_in : String?
    public var check_out : String?
    public var offer_expiry : String?
    public var offercreated_at : String?
    public var offer_checkin : String?
    public var offer_checkout : String?
    public var offer_id : String?

    
    public var user_details : [Offer_Chalet_details]?

    public class func modelsFromDictionaryArray(array:NSArray) -> [OfferChaletListModel]
    {
        var models:[OfferChaletListModel] = []
        for item in array
        {
            models.append(OfferChaletListModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        max_offer_count = dictionary["max_offer_count"] as? String
        check_in = dictionary["check_in"] as? String
        check_out = dictionary["check_out"] as? String
        offer_expiry = dictionary["offer_expiry"] as? String
        offercreated_at = dictionary["offercreated_at"] as? String
        offer_checkin = dictionary["offer_checkin"] as? String
        offer_checkout = dictionary["offer_checkout"] as? String
        offer_id = dictionary["offer_id"] as? String

        if (dictionary["user_details"] != nil) { user_details = Offer_Chalet_details.modelsFromDictionaryArray(array: dictionary["user_details"] as! NSArray) }
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")
        dictionary.setValue(self.max_offer_count, forKey: "max_offer_count")
        dictionary.setValue(self.check_in, forKey: "check_in")
        dictionary.setValue(self.check_out, forKey: "check_out")
        dictionary.setValue(self.offer_expiry, forKey: "offer_expiry")
        dictionary.setValue(self.offercreated_at, forKey: "offercreated_at")
        dictionary.setValue(self.offer_checkin, forKey: "offer_checkin")
        dictionary.setValue(self.offer_checkout, forKey: "offer_checkout")
        dictionary.setValue(self.offer_id, forKey: "offer_id")


        return dictionary
    }

}


public class Offer_Chalet_details : Codable {
    public var chalet_id : Int?
    public var chalet_name : String?
    public var owner_id : Int?
    public var cover_photo : String?
    public var offer_count : Int?
    public var rent : String?
    public var price_type : String?
    public var isFromHoliday : Bool?
    public var active_offers : Int?
    public var offerCount : Int?
    public var created_at : String?
    public var updated_at : String?
    public var discount : Int?
    public var userid : Int?
    public var offerid : Int?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Offer_Chalet_details]
    {
        var models:[Offer_Chalet_details] = []
        for item in array
        {
            models.append(Offer_Chalet_details(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        chalet_id = dictionary["chalet_id"] as? Int
        chalet_name = dictionary["chalet_name"] as? String
        owner_id = dictionary["owner_id"] as? Int
        cover_photo = dictionary["cover_photo"] as? String
        offer_count = dictionary["Offer_count"] as? Int
        rent = dictionary["rent"] as? String
        price_type = dictionary["price_type"] as? String
        isFromHoliday = dictionary["isFromHoliday"] as? Bool
        active_offers = dictionary["active_offers"] as? Int
        offerCount = dictionary["offerCount"] as? Int
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
        discount = dictionary["discount"] as? Int
        userid = dictionary["userid"] as? Int
        offerid = dictionary["offerid"] as? Int
    }

        
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.chalet_id, forKey: "chalet_id")
        dictionary.setValue(self.chalet_name, forKey: "chalet_name")
        dictionary.setValue(self.owner_id, forKey: "owner_id")
        dictionary.setValue(self.cover_photo, forKey: "cover_photo")
        dictionary.setValue(self.offer_count, forKey: "Offer_count")
        dictionary.setValue(self.rent, forKey: "rent")
        dictionary.setValue(self.price_type, forKey: "price_type")
        dictionary.setValue(self.isFromHoliday, forKey: "isFromHoliday")
        dictionary.setValue(self.active_offers, forKey: "active_offers")
        dictionary.setValue(self.offerCount, forKey: "offerCount")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")
        dictionary.setValue(self.discount, forKey: "discount")
        dictionary.setValue(self.userid, forKey: "userid")
        dictionary.setValue(self.offerid, forKey: "offerid")

        return dictionary
    }

}
