//
//  FAQModel.swift
//  AbyChaletApp
//
//  Created by Srishti on 18/01/22.
//

import Foundation

public class FAQModel {
    public var status : Bool?
    public var message : String?
    public var faq_details : Array<Faq_details>?


    public class func modelsFromDictionaryArray(array:NSArray) -> [FAQModel]
    {
        var models:[FAQModel] = []
        for item in array
        {
            models.append(FAQModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        if (dictionary["faq_details"] != nil) { faq_details = Faq_details.modelsFromDictionaryArray(array: dictionary["faq_details"] as! NSArray) }
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")

        return dictionary
    }

}

public class Faq_detailss {
    public var id : Int?
    public var question : String?
    public var answer : String?
    public var file : String?
    public var created_at : String?


    public class func modelsFromDictionaryArray(array:NSArray) -> [Faq_detailss]
    {
        var models:[Faq_detailss] = []
        for item in array
        {
            models.append(Faq_detailss(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? Int
        question = dictionary["question"] as? String
        answer = dictionary["answer"] as? String
        file = dictionary["file"] as? String
        created_at = dictionary["created_at"] as? String
    }

        
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.question, forKey: "question")
        dictionary.setValue(self.answer, forKey: "answer")
        dictionary.setValue(self.file, forKey: "file")
        dictionary.setValue(self.created_at, forKey: "created_at")

        return dictionary
    }

}
