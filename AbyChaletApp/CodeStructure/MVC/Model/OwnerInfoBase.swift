//
//  OwnerInfoBase.swift
//  AbyChaletApp
//
//  Created by Srishti on 22/02/22.
//
import Foundation

public class OwnerInfoBase {
    public var status : Bool?
    public var message : String?
    public var owner_details : Owner_details?

    public class func modelsFromDictionaryArray(array:NSArray) -> [OwnerInfoBase]
    {
        var models:[OwnerInfoBase] = []
        for item in array
        {
            models.append(OwnerInfoBase(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        if (dictionary["owner_details"] != nil) { owner_details = Owner_details(dictionary: dictionary["owner_details"] as! NSDictionary) }
    }

        

    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")
        dictionary.setValue(self.owner_details?.dictionaryRepresentation(), forKey: "owner_details")

        return dictionary
    }

}

public class Owner_details {
    public var id : String?
    public var owner_name : String?
    public var civil_id : String?
    public var chalet_ownership : String?
    public var agreement : String?
    public var bank_holder_name : String?
    public var bank_name : String?
    public var iban_num : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Owner_details]
    {
        var models:[Owner_details] = []
        for item in array
        {
            models.append(Owner_details(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? String
        owner_name = dictionary["owner_name"] as? String
        civil_id = dictionary["civil_id"] as? String
        chalet_ownership = dictionary["chalet_ownership"] as? String
        agreement = dictionary["agreement"] as? String
        bank_holder_name = dictionary["bank_holder_name"] as? String
        bank_name = dictionary["bank_name"] as? String
        iban_num = dictionary["iban_num"] as? String
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.owner_name, forKey: "owner_name")
        dictionary.setValue(self.civil_id, forKey: "civil_id")
        dictionary.setValue(self.chalet_ownership, forKey: "chalet_ownership")
        dictionary.setValue(self.agreement, forKey: "agreement")
        dictionary.setValue(self.bank_holder_name, forKey: "bank_holder_name")
        dictionary.setValue(self.bank_name, forKey: "bank_name")
        dictionary.setValue(self.iban_num, forKey: "iban_num")

        return dictionary
    }

}

