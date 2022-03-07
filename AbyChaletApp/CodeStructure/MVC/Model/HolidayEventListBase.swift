//
//  HolidayEventListBase.swift
//  AbyChaletApp
//
//  Created by Srishti on 07/03/22.
//

import Foundation

public class HolidayEventListBase {
    public var status : Bool?
    public var message : String?
    public var holi_event_list : [Holi_event_list]?


    public class func modelsFromDictionaryArray(array:NSArray) -> [HolidayEventListBase]
    {
        var models:[HolidayEventListBase] = []
        for item in array
        {
            models.append(HolidayEventListBase(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        if (dictionary["holi_event_list"] != nil) { holi_event_list = Holi_event_list.modelsFromDictionaryArray(array: dictionary["holi_event_list"] as! NSArray) }
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")

        return dictionary
    }

}

public class Holi_event_list {
    public var id : Int?
    public var event_name : String?
    public var event_checkin : String?
    public var event_checkout : String?
    public var check_in : String?
    public var check_out : String?
    public var no_ChaletEvent : String?
    public var eventcreated_at : String?


    public class func modelsFromDictionaryArray(array:NSArray) -> [Holi_event_list]
    {
        var models:[Holi_event_list] = []
        for item in array
        {
            models.append(Holi_event_list(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? Int
        event_name = dictionary["event_name"] as? String
        event_checkin = dictionary["event_checkin"] as? String
        event_checkout = dictionary["event_checkout"] as? String
        check_in = dictionary["check_in"] as? String
        check_out = dictionary["check_out"] as? String
        no_ChaletEvent = dictionary["No_ChaletEvent"] as? String
        eventcreated_at = dictionary["eventcreated_at"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.event_name, forKey: "event_name")
        dictionary.setValue(self.event_checkin, forKey: "event_checkin")
        dictionary.setValue(self.event_checkout, forKey: "event_checkout")
        dictionary.setValue(self.check_in, forKey: "check_in")
        dictionary.setValue(self.check_out, forKey: "check_out")
        dictionary.setValue(self.no_ChaletEvent, forKey: "No_ChaletEvent")
        dictionary.setValue(self.eventcreated_at, forKey: "eventcreated_at")

        return dictionary
    }

}
