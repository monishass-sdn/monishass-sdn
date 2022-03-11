//
//  SubChalet_Base.swift
//  AbyChaletApp
//
//  Created by Srishti on 10/03/22.
//

import Foundation

public class SubChalet_Base {
    public var status : Bool?
    public var message : String?
    public var user_details : [User_details]?

    public class func modelsFromDictionaryArray(array:NSArray) -> [SubChalet_Base]
    {
        var models:[SubChalet_Base] = []
        for item in array
        {
            models.append(SubChalet_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        if (dictionary["user_details"] != nil) { user_details = User_details.modelsFromDictionaryArray(array: dictionary["user_details"] as! NSArray) }
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")

        return dictionary
    }

}

public class SubChalet_details {
    public var slno : Int?
    public var chalet_id : Int?
    public var chalet_name : String?
    public var cover_photo : String?
    public var admincheck_in : String?
    public var admincheck_out : String?
    public var subchalet_available : Bool?
    public var isFromHolidaysandEvents : Bool?
    public var subchalet_count : String?
    public var holi_created : String?
    public var holi_weekdays_price : String?
    public var holi_weekend_price : String?
    public var holi_week_price : String?
    public var holi_rent : String?
    public var holi_event_name : String?
    public var holi_check_in : String?
    public var holi_check_out : String?
    public var owner_id : Int?
    public var firstname : String?
    public var lastname : String?
    public var email : String?
    public var password : String?
    public var country : String?
    public var phone : String?
    public var gender : String?
    public var profile_pic : String?
    public var default_callus : String?
    public var civil_id : String?
    public var chalet_ownership : String?
    public var bank_holder_name : String?
    public var bank_name : String?
    public var iban_num : String?
    public var min_deposit : String?
    public var deposit_percentage : String?
    public var weekAB_rent : String?
    public var weekdays_rent : String?
    public var weekend_rent : String?
    public var price_type : String?
    public var available_deposit : String?
    public var remaining_amt_pay : String?
    public var offer_expiry : String?
    public var rewarded_amt : Int?
    public var reservation_available : Int?
    public var reservation_status : Bool?
    public var rent : String?
    public var offer_available : Bool?
    public var offercreated_at : String?
    public var offer_checkin : String?
    public var check_in : String?
    public var check_out : String?



    public class func modelsFromDictionaryArray(array:NSArray) -> [SubChalet_details]
    {
        var models:[SubChalet_details] = []
        for item in array
        {
            models.append(SubChalet_details(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        slno = dictionary["slno"] as? Int
        chalet_id = dictionary["chalet_id"] as? Int
        chalet_name = dictionary["chalet_name"] as? String
        cover_photo = dictionary["cover_photo"] as? String
        admincheck_in = dictionary["admincheck_in"] as? String
        admincheck_out = dictionary["admincheck_out"] as? String
        subchalet_available = dictionary["subchalet_available"] as? Bool
        isFromHolidaysandEvents = dictionary["isFromHolidaysandEvents"] as? Bool
        subchalet_count = dictionary["subchalet_count"] as? String
        holi_created = dictionary["holi_created"] as? String
        holi_weekdays_price = dictionary["holi_weekdays_price"] as? String
        holi_weekend_price = dictionary["holi_weekend_price"] as? String
        holi_week_price = dictionary["holi_week_price"] as? String
        holi_rent = dictionary["holi_rent"] as? String
        holi_event_name = dictionary["holi_event_name"] as? String
        holi_check_in = dictionary["holi_check_in"] as? String
        holi_check_out = dictionary["holi_check_out"] as? String
        owner_id = dictionary["owner_id"] as? Int
        firstname = dictionary["firstname"] as? String
        lastname = dictionary["lastname"] as? String
        email = dictionary["email"] as? String
        password = dictionary["password"] as? String
        country = dictionary["country"] as? String
        phone = dictionary["phone"] as? String
        gender = dictionary["gender"] as? String
        profile_pic = dictionary["profile_pic"] as? String
        default_callus = dictionary["default_callus"] as? String
        civil_id = dictionary["civil_id"] as? String
        chalet_ownership = dictionary["chalet_ownership"] as? String
        bank_holder_name = dictionary["bank_holder_name"] as? String
        bank_name = dictionary["bank_name"] as? String
        iban_num = dictionary["iban_num"] as? String
        min_deposit = dictionary["min_deposit"] as? String
        deposit_percentage = dictionary["deposit_percentage"] as? String
        weekAB_rent = dictionary["weekAB_rent"] as? String
        weekdays_rent = dictionary["weekdays_rent"] as? String
        weekend_rent = dictionary["weekend_rent"] as? String
        price_type = dictionary["price_type"] as? String
        available_deposit = dictionary["available_deposit"] as? String
        remaining_amt_pay = dictionary["remaining_amt_pay"] as? String
        offer_expiry = dictionary["offer_expiry"] as? String
        rewarded_amt = dictionary["rewarded_amt"] as? Int
        reservation_available = dictionary["reservation_available"] as? Int
        reservation_status = dictionary["reservation_status"] as? Bool
        rent = dictionary["rent"] as? String
        offercreated_at = dictionary["offercreated_at"] as? String
        offer_checkin = dictionary["offer_checkin"] as? String
        check_in = dictionary["check_in"] as? String
        check_out = dictionary["check_out"] as? String
        offer_available = dictionary["offer_available"] as? Bool


    }

        
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.slno, forKey: "slno")
        dictionary.setValue(self.chalet_id, forKey: "chalet_id")
        dictionary.setValue(self.chalet_name, forKey: "chalet_name")
        dictionary.setValue(self.cover_photo, forKey: "cover_photo")
        dictionary.setValue(self.admincheck_in, forKey: "admincheck_in")
        dictionary.setValue(self.admincheck_out, forKey: "admincheck_out")
        dictionary.setValue(self.subchalet_available, forKey: "subchalet_available")
        dictionary.setValue(self.isFromHolidaysandEvents, forKey: "isFromHolidaysandEvents")
        dictionary.setValue(self.subchalet_count, forKey: "subchalet_count")
        dictionary.setValue(self.holi_created, forKey: "holi_created")
        dictionary.setValue(self.holi_weekdays_price, forKey: "holi_weekdays_price")
        dictionary.setValue(self.holi_weekend_price, forKey: "holi_weekend_price")
        dictionary.setValue(self.holi_week_price, forKey: "holi_week_price")
        dictionary.setValue(self.holi_rent, forKey: "holi_rent")
        dictionary.setValue(self.holi_event_name, forKey: "holi_event_name")
        dictionary.setValue(self.holi_check_in, forKey: "holi_check_in")
        dictionary.setValue(self.holi_check_out, forKey: "holi_check_out")
        dictionary.setValue(self.owner_id, forKey: "owner_id")
        dictionary.setValue(self.firstname, forKey: "firstname")
        dictionary.setValue(self.lastname, forKey: "lastname")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.password, forKey: "password")
        dictionary.setValue(self.country, forKey: "country")
        dictionary.setValue(self.phone, forKey: "phone")
        dictionary.setValue(self.gender, forKey: "gender")
        dictionary.setValue(self.profile_pic, forKey: "profile_pic")
        dictionary.setValue(self.default_callus, forKey: "default_callus")
        dictionary.setValue(self.civil_id, forKey: "civil_id")
        dictionary.setValue(self.chalet_ownership, forKey: "chalet_ownership")
        dictionary.setValue(self.bank_holder_name, forKey: "bank_holder_name")
        dictionary.setValue(self.bank_name, forKey: "bank_name")
        dictionary.setValue(self.iban_num, forKey: "iban_num")
        dictionary.setValue(self.min_deposit, forKey: "min_deposit")
        dictionary.setValue(self.deposit_percentage, forKey: "deposit_percentage")
        dictionary.setValue(self.weekAB_rent, forKey: "weekAB_rent")
        dictionary.setValue(self.weekdays_rent, forKey: "weekdays_rent")
        dictionary.setValue(self.weekend_rent, forKey: "weekend_rent")
        dictionary.setValue(self.price_type, forKey: "price_type")
        dictionary.setValue(self.available_deposit, forKey: "available_deposit")
        dictionary.setValue(self.remaining_amt_pay, forKey: "remaining_amt_pay")
        dictionary.setValue(self.offer_expiry, forKey: "offer_expiry")
        dictionary.setValue(self.rewarded_amt, forKey: "rewarded_amt")
        dictionary.setValue(self.reservation_available, forKey: "reservation_available")
        dictionary.setValue(self.reservation_status, forKey: "reservation_status")
        dictionary.setValue(self.rent, forKey: "rent")
        dictionary.setValue(self.offer_available, forKey: "offer_available")
        dictionary.setValue(self.offercreated_at, forKey: "offercreated_at")
        dictionary.setValue(self.offer_checkin, forKey: "offer_checkin")
        dictionary.setValue(self.check_in, forKey: "check_in")
        dictionary.setValue(self.check_out, forKey: "check_out")


        return dictionary
    }

}
