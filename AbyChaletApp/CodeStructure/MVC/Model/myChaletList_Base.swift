//
//  myChaletList_Base.swift
//  AbyChaletApp
//
//  Created by Srishti on 14/03/22.
//

import Foundation

public class myChaletList_Base {
    public var status : Bool?
    public var message : String?
    public var chaletLists : [ChaletLists]?


    public class func modelsFromDictionaryArray(array:NSArray) -> [myChaletList_Base]
    {
        var models:[myChaletList_Base] = []
        for item in array
        {
            models.append(myChaletList_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        if (dictionary["chaletLists"] != nil) { chaletLists = ChaletLists.modelsFromDictionaryArray(array: dictionary["chaletLists"] as! NSArray) }
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")

        return dictionary
    }

}

public class ChaletLists {
    public var chalet_id : Int?
    public var chalet_name : String?
    public var owner_id : Int?
    public var cover_photo : String?
    public var ishaveSubCHalets : Bool?
    public var closed_date : Bool?
    public var reservation_available : Bool?
    public var countOfSubChalets : String?
    public var totalIncome : String?
    public var totalUnPaid : String?
    public var rejectedReservation : String?
    public var commission : String?
    public var offer_count : String?
    public var reservation_count : String?
    public var cancellationCount : String?
    public var startDate : String?
    public var created_at : String?
    public var updated_at : String?


    public class func modelsFromDictionaryArray(array:NSArray) -> [ChaletLists]
    {
        var models:[ChaletLists] = []
        for item in array
        {
            models.append(ChaletLists(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        chalet_id = dictionary["chalet_id"] as? Int
        chalet_name = dictionary["chalet_name"] as? String
        owner_id = dictionary["owner_id"] as? Int
        cover_photo = dictionary["cover_photo"] as? String
        ishaveSubCHalets = dictionary["ishaveSubCHalets"] as? Bool
        closed_date = dictionary["closed_date"] as? Bool
        reservation_available = dictionary["reservation_available"] as? Bool
        countOfSubChalets = dictionary["countOfSubChalets"] as? String
        totalIncome = dictionary["totalIncome"] as? String
        totalUnPaid = dictionary["totalUnPaid"] as? String
        rejectedReservation = dictionary["rejectedReservation"] as? String
        commission = dictionary["commission"] as? String
        offer_count = dictionary["offer_count"] as? String
        reservation_count = dictionary["reservation_count"] as? String
        cancellationCount = dictionary["cancellationCount"] as? String
        startDate = dictionary["startDate"] as? String
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.chalet_id, forKey: "chalet_id")
        dictionary.setValue(self.chalet_name, forKey: "chalet_name")
        dictionary.setValue(self.owner_id, forKey: "owner_id")
        dictionary.setValue(self.cover_photo, forKey: "cover_photo")
        dictionary.setValue(self.ishaveSubCHalets, forKey: "ishaveSubCHalets")
        dictionary.setValue(self.closed_date, forKey: "closed_date")
        dictionary.setValue(self.reservation_available, forKey: "reservation_available")
        dictionary.setValue(self.countOfSubChalets, forKey: "countOfSubChalets")
        dictionary.setValue(self.totalIncome, forKey: "totalIncome")
        dictionary.setValue(self.totalUnPaid, forKey: "totalUnPaid")
        dictionary.setValue(self.rejectedReservation, forKey: "rejectedReservation")
        dictionary.setValue(self.commission, forKey: "commission")
        dictionary.setValue(self.offer_count, forKey: "offer_count")
        dictionary.setValue(self.reservation_count, forKey: "reservation_count")
        dictionary.setValue(self.cancellationCount, forKey: "cancellationCount")
        dictionary.setValue(self.startDate, forKey: "startDate")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")

        return dictionary
    }

}
