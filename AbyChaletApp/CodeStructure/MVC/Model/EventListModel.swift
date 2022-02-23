//
//  EventListModel.swift
//  AbyChaletApp
//
//  Created by Srishti on 22/02/22.
//

import Foundation

public class EventListModel {
    public var status : Bool?
    public var message : String?
    public var event_details : [Event_details]?

    public class func modelsFromDictionaryArray(array:NSArray) -> [EventListModel]
    {
        var models:[EventListModel] = []
        for item in array
        {
            models.append(EventListModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        if (dictionary["event_details"] != nil) { event_details = Event_details.modelsFromDictionaryArray(array: dictionary["event_details"] as! NSArray) }
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")

        return dictionary
    }

}

public class Event_details {
    public var id : Int?
    public var event_name : String?
    public var holi_checkin : String?
    public var holi_checkout : String?
    public var check_in : String?
    public var check_out : String?
    public var holiday_status : String?
    public var holi_count : Int?
    public var created_at : String?
    public var updated_at : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Event_details]
    {
        var models:[Event_details] = []
        for item in array
        {
            models.append(Event_details(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? Int
        event_name = dictionary["event_name"] as? String
        holi_checkin = dictionary["holi_checkin"] as? String
        holi_checkout = dictionary["holi_checkout"] as? String
        check_in = dictionary["check_in"] as? String
        check_out = dictionary["check_out"] as? String
        holiday_status = dictionary["holiday_status"] as? String
        holi_count = dictionary["holi_count"] as? Int
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.event_name, forKey: "event_name")
        dictionary.setValue(self.holi_checkin, forKey: "holi_checkin")
        dictionary.setValue(self.holi_checkout, forKey: "holi_checkout")
        dictionary.setValue(self.check_in, forKey: "check_in")
        dictionary.setValue(self.check_out, forKey: "check_out")
        dictionary.setValue(self.holiday_status, forKey: "holiday_status")
        dictionary.setValue(self.holi_count, forKey: "holi_count")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")

        return dictionary
    }

}
