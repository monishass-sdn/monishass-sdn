//
//  Owner_Reservation_RequestBase.swift
//  AbyChaletApp
//
//  Created by Srishti on 18/04/22.
//

import Foundation

public class Owner_Reservation_RequestBase {
    public var status : Bool?
    public var message : String?
    public var request_count : String?
    public var reservation_list : [Reservation_Request_list]?


    public class func modelsFromDictionaryArray(array:NSArray) -> [Owner_Reservation_RequestBase]
    {
        var models:[Owner_Reservation_RequestBase] = []
        for item in array
        {
            models.append(Owner_Reservation_RequestBase(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        request_count = dictionary["request_count"] as? String
        if (dictionary["reservation_list"] != nil) { reservation_list = Reservation_Request_list.modelsFromDictionaryArray(array: dictionary["reservation_list"] as! NSArray) }
    }

        
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")
        dictionary.setValue(self.request_count, forKey: "request_count")

        return dictionary
    }

}

public class Reservation_Request_list {
    public var reservation_id : Int?
    public var userid : Int?
    public var chaletid : Int?
    public var request_time : Int?
    public var ownerid : String?
    public var selected_package : String?
    public var check_in : String?
    public var check_out : String?
    public var checkin_time : String?
    public var checkout_time : String?
    public var booking_status : String?
    public var total_paid : String?
    public var reward_discount : String?
    public var deposit : String?
    public var owner_commission : String?
    public var comission_percentage : String?
    public var status : String?
    public var offer_discount : String?
    public var payment_type : String?
    public var chalet_rent : String?
    public var remaining : String?
    public var chalet_details : [RequestedChalet_details]?


    public class func modelsFromDictionaryArray(array:NSArray) -> [Reservation_Request_list]
    {
        var models:[Reservation_Request_list] = []
        for item in array
        {
            models.append(Reservation_Request_list(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        reservation_id = dictionary["reservation_id"] as? Int
        userid = dictionary["userid"] as? Int
        chaletid = dictionary["chaletid"] as? Int
        request_time = dictionary["request_time"] as? Int
        ownerid = dictionary["ownerid"] as? String
        selected_package = dictionary["selected_package"] as? String
        check_in = dictionary["check_in"] as? String
        check_out = dictionary["check_out"] as? String
        checkin_time = dictionary["checkin_time"] as? String
        checkout_time = dictionary["checkout_time"] as? String
        booking_status = dictionary["booking_status"] as? String
        total_paid = dictionary["total_paid"] as? String
        reward_discount = dictionary["reward_discount"] as? String
        deposit = dictionary["deposit"] as? String
        owner_commission = dictionary["owner_commission"] as? String
        comission_percentage = dictionary["comission_percentage"] as? String
        status = dictionary["status"] as? String
        offer_discount = dictionary["offer_discount"] as? String
        payment_type = dictionary["payment_type"] as? String
        chalet_rent = dictionary["chalet_rent"] as? String
        remaining = dictionary["remaining"] as? String

        if (dictionary["chalet_details"] != nil) { chalet_details = RequestedChalet_details.modelsFromDictionaryArray(array: dictionary["chalet_details"] as! NSArray) }
    }

        
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.reservation_id, forKey: "reservation_id")
        dictionary.setValue(self.userid, forKey: "userid")
        dictionary.setValue(self.chaletid, forKey: "chaletid")
        dictionary.setValue(self.ownerid, forKey: "ownerid")
        dictionary.setValue(self.request_time, forKey: "request_time")
        dictionary.setValue(self.selected_package, forKey: "selected_package")
        dictionary.setValue(self.check_in, forKey: "check_in")
        dictionary.setValue(self.check_out, forKey: "check_out")
        dictionary.setValue(self.checkin_time, forKey: "checkin_time")
        dictionary.setValue(self.checkout_time, forKey: "checkout_time")
        dictionary.setValue(self.booking_status, forKey: "booking_status")
        dictionary.setValue(self.total_paid, forKey: "total_paid")
        dictionary.setValue(self.reward_discount, forKey: "reward_discount")
        dictionary.setValue(self.deposit, forKey: "deposit")
        dictionary.setValue(self.owner_commission, forKey: "owner_commission")
        dictionary.setValue(self.comission_percentage, forKey: "comission_percentage")
        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.offer_discount, forKey: "offer_discount")
        dictionary.setValue(self.payment_type, forKey: "payment_type")
        dictionary.setValue(self.chalet_rent, forKey: "chalet_rent")
        dictionary.setValue(self.remaining, forKey: "remaining")


        return dictionary
    }

}

public class RequestedChalet_details {
    public var chalet_id : Int?
    public var chalet_name : String?
    public var location : String?
    public var latitude : Double?
    public var longitude : Double?
    public var cover_photo : String?
    public var weekday_rent : String?
    public var weekend_rent : String?
    public var week_rent : String?
    public var created_at : String?
    public var updated_at : String?

    
    public class func modelsFromDictionaryArray(array:NSArray) -> [RequestedChalet_details]
    {
        var models:[RequestedChalet_details] = []
        for item in array
        {
            models.append(RequestedChalet_details(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        chalet_id = dictionary["chalet_id"] as? Int
        chalet_name = dictionary["chalet_name"] as? String
        location = dictionary["location"] as? String
        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        cover_photo = dictionary["cover_photo"] as? String
        weekday_rent = dictionary["weekday_rent"] as? String
        weekend_rent = dictionary["weekend_rent"] as? String
        week_rent = dictionary["week_rent"] as? String
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.chalet_id, forKey: "chalet_id")
        dictionary.setValue(self.chalet_name, forKey: "chalet_name")
        dictionary.setValue(self.location, forKey: "location")
        dictionary.setValue(self.latitude, forKey: "latitude")
        dictionary.setValue(self.longitude, forKey: "longitude")
        dictionary.setValue(self.cover_photo, forKey: "cover_photo")
        dictionary.setValue(self.weekday_rent, forKey: "weekday_rent")
        dictionary.setValue(self.weekend_rent, forKey: "weekend_rent")
        dictionary.setValue(self.week_rent, forKey: "week_rent")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")

        return dictionary
    }

}
