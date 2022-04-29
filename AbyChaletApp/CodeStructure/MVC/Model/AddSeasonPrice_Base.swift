//
//  AddSeasonPrice_Base.swift
//  AbyChaletApp
//
//  Created by Srishti on 08/03/22.
//

import Foundation

public class AddSeasonPrice_Base {
    public var status : Bool?
    public var message : String?
    public var season_start : String?
    public var season_end : String?
    public var chalet_details : [SeasonPrice_Chalet_details]?


    public class func modelsFromDictionaryArray(array:NSArray) -> [AddSeasonPrice_Base]
    {
        var models:[AddSeasonPrice_Base] = []
        for item in array
        {
            models.append(AddSeasonPrice_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        season_start = dictionary["season_start"] as? String
        season_end = dictionary["season_end"] as? String
        if (dictionary["chalet_details"] != nil) { chalet_details = SeasonPrice_Chalet_details.modelsFromDictionaryArray(array: dictionary["chalet_details"] as! NSArray) }
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")
        dictionary.setValue(self.season_start, forKey: "season_start")
        dictionary.setValue(self.season_end, forKey: "season_end")

        return dictionary
    }

}

public class SeasonDate {
    public var id : Int?
    public var season_start : String?
    public var season_end : String?
    public var created_at : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [SeasonDate]
    {
        var models:[SeasonDate] = []
        for item in array
        {
            models.append(SeasonDate(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? Int
        season_start = dictionary["season_start"] as? String
        season_end = dictionary["season_end"] as? String
        created_at = dictionary["created_at"] as? String
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.season_start, forKey: "season_start")
        dictionary.setValue(self.season_end, forKey: "season_end")
        dictionary.setValue(self.created_at, forKey: "created_at")

        return dictionary
    }

}

public class SeasonPrice_Chalet_details : Codable {
    public var id : Int?
    public var ownerid : Int?
    public var mainchaletid : Int?
    public var chalet_name : String?
    public var cover_photo : String?
    public var owner_id : Int?
    public var season_status : String?
    public var weekday_rent : String?
    public var weekend_rent : String?
    public var week_rent : String?
    public var week_seasonprice : String?
    public var weekend_seasonprice : String?
    public var weekdays_seasonprice : String?
    public var price_type : String?
    public var seasonPriceStatus : Bool?


    public class func modelsFromDictionaryArray(array:NSArray) -> [SeasonPrice_Chalet_details]
    {
        var models:[SeasonPrice_Chalet_details] = []
        for item in array
        {
            models.append(SeasonPrice_Chalet_details(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? Int
        ownerid = dictionary["ownerid"] as? Int
        mainchaletid = dictionary["mainchaletid"] as? Int
        chalet_name = dictionary["chalet_name"] as? String
        cover_photo = dictionary["cover_photo"] as? String
        owner_id = dictionary["owner_id"] as? Int
        season_status = dictionary["season_status"] as? String
        weekday_rent = dictionary["weekday_rent"] as? String
        weekend_rent = dictionary["weekend_rent"] as? String
        week_rent = dictionary["week_rent"] as? String
        week_seasonprice = dictionary["week_seasonprice"] as? String
        weekend_seasonprice = dictionary["weekend_seasonprice"] as? String
        weekdays_seasonprice = dictionary["weekdays_seasonprice"] as? String
        price_type = dictionary["price_type"] as? String
        seasonPriceStatus = dictionary["seasonPriceStatus"] as? Bool
    }

        

    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.ownerid, forKey: "ownerid")
        dictionary.setValue(self.mainchaletid, forKey: "mainchaletid")
        dictionary.setValue(self.chalet_name, forKey: "chalet_name")
        dictionary.setValue(self.cover_photo, forKey: "cover_photo")
        dictionary.setValue(self.owner_id, forKey: "owner_id")
        dictionary.setValue(self.season_status, forKey: "season_status")
        dictionary.setValue(self.weekday_rent, forKey: "weekday_rent")
        dictionary.setValue(self.weekend_rent, forKey: "weekend_rent")
        dictionary.setValue(self.week_rent, forKey: "week_rent")
        dictionary.setValue(self.week_seasonprice, forKey: "week_seasonprice")
        dictionary.setValue(self.weekend_seasonprice, forKey: "weekend_seasonprice")
        dictionary.setValue(self.weekdays_seasonprice, forKey: "weekdays_seasonprice")
        dictionary.setValue(self.price_type, forKey: "price_type")
        dictionary.setValue(self.seasonPriceStatus, forKey: "seasonPriceStatus")

        return dictionary
    }

}
