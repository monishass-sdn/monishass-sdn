//
//  AddedHolidayPriceChaletList_Base.swift
//  AbyChaletApp
//
//  Created by Srishti on 08/03/22.
//

import Foundation

public class AddedHolidayPriceChaletList_Base {
    public var status : Bool?
    public var message : String?
    public var inserted_offered_chalets : [Inserted_Holiday_chaletsID]?
    public var chalet_details : [Inserted_Holiday_chalets]?
    public var confirm_token : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [AddedHolidayPriceChaletList_Base]
    {
        var models:[AddedHolidayPriceChaletList_Base] = []
        for item in array
        {
            models.append(AddedHolidayPriceChaletList_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        if (dictionary["inserted_offered_chalets"] != nil) { inserted_offered_chalets = Inserted_Holiday_chaletsID.modelsFromDictionaryArray(array: dictionary["inserted_offered_chalets"] as! NSArray) }
        if (dictionary["chalet_details"] != nil) { chalet_details = Inserted_Holiday_chalets.modelsFromDictionaryArray(array: dictionary["chalet_details"] as! NSArray) }
        confirm_token = dictionary["confirm_token"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")
        dictionary.setValue(self.confirm_token, forKey: "confirm_token")

        return dictionary
    }

}

public class Inserted_Holiday_chaletsID {
    public var chaletid : Int?


    public class func modelsFromDictionaryArray(array:NSArray) -> [Inserted_Holiday_chaletsID]
    {
        var models:[Inserted_Holiday_chaletsID] = []
        for item in array
        {
            models.append(Inserted_Holiday_chaletsID(dictionary: item as! NSDictionary)!)
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

public class Inserted_Holiday_chalets {
    public var chalet_id : Int?
    public var chalet_name : String?
    public var owner_id : Int?
    public var cover_photo : String?
    public var weekAB_rent : String?
    public var weekdays_rent : String?
    public var weekend_rent : String?
    public var price_type : String?
    public var isFromHoliday : Bool?
    public var active_offers : Int?
    public var offerCount : Int?
    public var created_at : String?
    public var updated_at : String?
    public var holiday_price : Int?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Inserted_Holiday_chalets]
    {
        var models:[Inserted_Holiday_chalets] = []
        for item in array
        {
            models.append(Inserted_Holiday_chalets(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        chalet_id = dictionary["chalet_id"] as? Int
        chalet_name = dictionary["chalet_name"] as? String
        owner_id = dictionary["owner_id"] as? Int
        cover_photo = dictionary["cover_photo"] as? String
        weekAB_rent = dictionary["weekAB_rent"] as? String
        weekdays_rent = dictionary["weekdays_rent"] as? String
        weekend_rent = dictionary["weekend_rent"] as? String
        price_type = dictionary["price_type"] as? String
        isFromHoliday = dictionary["isFromHoliday"] as? Bool
        active_offers = dictionary["active_offers"] as? Int
        offerCount = dictionary["offerCount"] as? Int
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
        holiday_price = dictionary["holiday_price"] as? Int
    }

    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.chalet_id, forKey: "chalet_id")
        dictionary.setValue(self.chalet_name, forKey: "chalet_name")
        dictionary.setValue(self.owner_id, forKey: "owner_id")
        dictionary.setValue(self.cover_photo, forKey: "cover_photo")
        dictionary.setValue(self.weekAB_rent, forKey: "weekAB_rent")
        dictionary.setValue(self.weekdays_rent, forKey: "weekdays_rent")
        dictionary.setValue(self.weekend_rent, forKey: "weekend_rent")
        dictionary.setValue(self.price_type, forKey: "price_type")
        dictionary.setValue(self.isFromHoliday, forKey: "isFromHoliday")
        dictionary.setValue(self.active_offers, forKey: "active_offers")
        dictionary.setValue(self.offerCount, forKey: "offerCount")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")
        dictionary.setValue(self.holiday_price, forKey: "holiday_price")

        return dictionary
    }

}
