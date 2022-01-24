//
//  FAQModelData.swift
//  AbyChaletApp
//
//  Created by Srishti on 24/01/22.
//

import Foundation

public class FAQModelData {
    public var status : Bool?
    public var message : String?
    public var faq_details : Array<Faq_details>?


    public class func modelsFromDictionaryArray(array:NSArray) -> [FAQModelData]
    {
        var models:[FAQModelData] = []
        for item in array
        {
            models.append(FAQModelData(dictionary: item as! NSDictionary)!)
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

public class Faq_details {
    public var id : Int?
    public var question : String?
    public var answer : Array<Answer>?
    public var file : String?
    public var created_at : String?


    public class func modelsFromDictionaryArray(array:NSArray) -> [Faq_details]
    {
        var models:[Faq_details] = []
        for item in array
        {
            models.append(Faq_details(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? Int
        question = dictionary["question"] as? String
        if (dictionary["Answer"] != nil) { answer = Answer.modelsFromDictionaryArray(array: dictionary["Answer"] as! NSArray) }
        file = dictionary["file"] as? String
        created_at = dictionary["created_at"] as? String
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.question, forKey: "question")
        dictionary.setValue(self.file, forKey: "file")
        dictionary.setValue(self.created_at, forKey: "created_at")

        return dictionary
    }

}

public class Answer {
    public var answer : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Answer]
    {
        var models:[Answer] = []
        for item in array
        {
            models.append(Answer(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        answer = dictionary["answer"] as? String
    }


    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.answer, forKey: "answer")

        return dictionary
    }

}

