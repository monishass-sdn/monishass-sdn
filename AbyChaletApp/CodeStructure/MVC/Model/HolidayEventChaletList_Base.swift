//
//  HolidayEventChaletList_Base.swift
//  AbyChaletApp
//
//  Created by Srishti on 07/03/22.
//

import Foundation
public class HolidayEventChaletList_Base {
    public var status : Bool?
    public var message : String?
    public var user_details : [HolidayEventChaletList]?


    public class func modelsFromDictionaryArray(array:NSArray) -> [HolidayEventChaletList_Base]
    {
        var models:[HolidayEventChaletList_Base] = []
        for item in array
        {
            models.append(HolidayEventChaletList_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        if (dictionary["user_details"] != nil) { user_details = HolidayEventChaletList.modelsFromDictionaryArray(array: dictionary["user_details"] as! NSArray) }
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")

        return dictionary
    }

}

public class HolidayEventChaletList : Codable {
    public var chalet_id : Int?
    public var chalet_name : String?
    public var owner_id : Int?
    public var auto_accept : Bool?
    public var cover_photo : String?
    public var price_type : String?
    public var isOffer : Bool?
    public var chaletEventStatus : Bool?
    public var holidayPrice : String?
    public var weekAB_rent : String?
    public var weekdays_rent : String?
    public var weekend_rent : String?
    public var created_at : String?
    public var updated_at : String?
    public var userid : Int?
    public var holieventId : Int?
    public var price : Int?


    public class func modelsFromDictionaryArray(array:NSArray) -> [HolidayEventChaletList]
    {
        var models:[HolidayEventChaletList] = []
        for item in array
        {
            models.append(HolidayEventChaletList(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        chalet_id = dictionary["chalet_id"] as? Int
        chalet_name = dictionary["chalet_name"] as? String
        owner_id = dictionary["owner_id"] as? Int
        auto_accept = dictionary["auto_accept"] as? Bool
        chaletEventStatus = dictionary["chaletEventStatus"] as? Bool
        holidayPrice = dictionary["holidayPrice"] as? String
        cover_photo = dictionary["cover_photo"] as? String
        price_type = dictionary["price_type"] as? String
        isOffer = dictionary["isOffer"] as? Bool
        weekAB_rent = dictionary["weekAB_rent"] as? String
        weekdays_rent = dictionary["weekdays_rent"] as? String
        weekend_rent = dictionary["weekend_rent"] as? String
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
        userid = dictionary["userid"] as? Int
        holieventId = dictionary["holieventId"] as? Int
        price = dictionary["price"] as? Int
    }

        

    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.chalet_id, forKey: "chalet_id")
        dictionary.setValue(self.chalet_name, forKey: "chalet_name")
        dictionary.setValue(self.owner_id, forKey: "owner_id")
        dictionary.setValue(self.auto_accept, forKey: "auto_accept")
        dictionary.setValue(self.chaletEventStatus, forKey: "chaletEventStatus")
        dictionary.setValue(self.holidayPrice, forKey: "holidayPrice")
        dictionary.setValue(self.cover_photo, forKey: "cover_photo")
        dictionary.setValue(self.price_type, forKey: "price_type")
        dictionary.setValue(self.isOffer, forKey: "isOffer")
        dictionary.setValue(self.weekAB_rent, forKey: "weekAB_rent")
        dictionary.setValue(self.weekdays_rent, forKey: "weekdays_rent")
        dictionary.setValue(self.weekend_rent, forKey: "weekend_rent")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")
        dictionary.setValue(self.userid, forKey: "userid")
        dictionary.setValue(self.holieventId, forKey: "holieventId")
        dictionary.setValue(self.price, forKey: "price")


        return dictionary
    }

}
