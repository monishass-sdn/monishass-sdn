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
        if (dictionary["user_details"] != nil) { user_details = Offer_Chalet_details.modelsFromDictionaryArray(array: dictionary["user_details"] as! NSArray) }
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")

        return dictionary
    }

}


public class Offer_Chalet_details {
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

        return dictionary
    }

}
