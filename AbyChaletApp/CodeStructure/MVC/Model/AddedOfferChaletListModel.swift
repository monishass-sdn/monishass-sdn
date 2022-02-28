//
//  AddedOfferChaletListModel.swift
//  AbyChaletApp
//
//  Created by Srishti on 24/02/22.
//

import Foundation

public class AddedOfferChaletListModel {
    public var status : Bool?
    public var message : String?
    public var confirm_token : String?
    public var inserted_offered_chalets : Array<Inserted_offered_chalets>?
    public var chalet_details : Array<Offered_Chalet_details>?


    public class func modelsFromDictionaryArray(array:NSArray) -> [AddedOfferChaletListModel]
    {
        var models:[AddedOfferChaletListModel] = []
        for item in array
        {
            models.append(AddedOfferChaletListModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        confirm_token = dictionary["confirm_token"] as? String
        if (dictionary["inserted_offered_chalets"] != nil) { inserted_offered_chalets = Inserted_offered_chalets.modelsFromDictionaryArray(array: dictionary["inserted_offered_chalets"] as! NSArray) }
        if (dictionary["chalet_details"] != nil) { chalet_details = Offered_Chalet_details.modelsFromDictionaryArray(array: dictionary["chalet_details"] as! NSArray) }
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")
        dictionary.setValue(self.confirm_token, forKey: "confirm_token")

        return dictionary
    }

}


public class Inserted_offered_chalets {
    public var chaletid : Int?


    public class func modelsFromDictionaryArray(array:NSArray) -> [Inserted_offered_chalets]
    {
        var models:[Inserted_offered_chalets] = []
        for item in array
        {
            models.append(Inserted_offered_chalets(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        chaletid = dictionary["chaletid"] as? Int
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.chaletid, forKey: "chaletid")

        return dictionary
    }

}


public class Offered_Chalet_details {
    public var chalet_id : Int?
    public var chalet_name : String?
    public var owner_id : Int?
    public var cover_photo : String?
    public var rent : String?
    public var discountedRent : Int?
    public var price_type : String?
    public var isFromHoliday : Bool?
    public var active_offers : Int?
    public var offerCount : Int?
    public var created_at : String?
    public var updated_at : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Offered_Chalet_details]
    {
        var models:[Offered_Chalet_details] = []
        for item in array
        {
            models.append(Offered_Chalet_details(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        chalet_id = dictionary["chalet_id"] as? Int
        chalet_name = dictionary["chalet_name"] as? String
        owner_id = dictionary["owner_id"] as? Int
        cover_photo = dictionary["cover_photo"] as? String
        rent = dictionary["rent"] as? String
        discountedRent = dictionary["discountedRent"] as? Int
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
        dictionary.setValue(self.rent, forKey: "rent")
        dictionary.setValue(self.discountedRent, forKey: "discountedRent")
        dictionary.setValue(self.price_type, forKey: "price_type")
        dictionary.setValue(self.isFromHoliday, forKey: "isFromHoliday")
        dictionary.setValue(self.active_offers, forKey: "active_offers")
        dictionary.setValue(self.offerCount, forKey: "offerCount")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")

        return dictionary
    }

}
