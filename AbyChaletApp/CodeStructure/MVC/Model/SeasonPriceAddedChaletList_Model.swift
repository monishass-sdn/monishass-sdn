//
//  SeasonPriceAddedChaletList_Model.swift
//  AbyChaletApp
//
//  Created by Srishti on 09/03/22.
//

import Foundation

public class SeasonPriceAddedChaletList_Model {
    public var status : Bool?
    public var message : String?
    public var chalet_details : [SeasonPriceAdded_Chalet_details]?
    public var confirm_token : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [SeasonPriceAddedChaletList_Model]
    {
        var models:[SeasonPriceAddedChaletList_Model] = []
        for item in array
        {
            models.append(SeasonPriceAddedChaletList_Model(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        if (dictionary["chalet_details"] != nil) { chalet_details = SeasonPriceAdded_Chalet_details.modelsFromDictionaryArray(array: dictionary["chalet_details"] as! NSArray) }
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

public class SeasonPriceAdded_Chalet_details {
    public var chaletid : Int?
    public var userid : Int?
    public var chalet_name : String?
    public var price_type : String?
    public var season_status : String?
    public var coverphoto : String?
    public var weekday_rent : String?
    public var weekend_rent : String?
    public var week_rent : String?
    public var week_seasonprice : String?
    public var weekend_seasonprice : String?
    public var weekdays_seasonprice : String?


    public class func modelsFromDictionaryArray(array:NSArray) -> [SeasonPriceAdded_Chalet_details]
    {
        var models:[SeasonPriceAdded_Chalet_details] = []
        for item in array
        {
            models.append(SeasonPriceAdded_Chalet_details(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        chaletid = dictionary["chaletid"] as? Int
        userid = dictionary["userid"] as? Int
        chalet_name = dictionary["chalet_name"] as? String
        price_type = dictionary["price_type"] as? String
        season_status = dictionary["season_status"] as? String
        coverphoto = dictionary["coverphoto"] as? String
        weekday_rent = dictionary["weekday_rent"] as? String
        weekend_rent = dictionary["weekend_rent"] as? String
        week_rent = dictionary["week_rent"] as? String
        week_seasonprice = dictionary["week_seasonprice"] as? String
        weekend_seasonprice = dictionary["weekend_seasonprice"] as? String
        weekdays_seasonprice = dictionary["weekdays_seasonprice"] as? String
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.chaletid, forKey: "chaletid")
        dictionary.setValue(self.userid, forKey: "userid")
        dictionary.setValue(self.chalet_name, forKey: "chalet_name")
        dictionary.setValue(self.price_type, forKey: "price_type")
        dictionary.setValue(self.season_status, forKey: "season_status")
        dictionary.setValue(self.coverphoto, forKey: "coverphoto")
        dictionary.setValue(self.weekday_rent, forKey: "weekday_rent")
        dictionary.setValue(self.weekend_rent, forKey: "weekend_rent")
        dictionary.setValue(self.week_rent, forKey: "week_rent")
        dictionary.setValue(self.week_seasonprice, forKey: "week_seasonprice")
        dictionary.setValue(self.weekend_seasonprice, forKey: "weekend_seasonprice")
        dictionary.setValue(self.weekdays_seasonprice, forKey: "weekdays_seasonprice")

        return dictionary
    }

}

