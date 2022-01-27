//
//  Constants.swift
//  AbyChaletApp
//
//  Created by TEJASWINI KADAM on 28/04/21.
//

import Foundation
import UIKit
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let screenHeight = UIScreen.main.bounds.height
let kScreenWidth        = UIScreen.main.bounds.width
let kScreenHeight       = UIScreen.main.bounds.height
let appName = "AbyChalet"
let kAppThemeColor   = UIColor("#2B5468")
let kAppHeaderColor = UIColor("#2B5468")
let kAppViewColor = UIColor("#1E4355")
let kPlaceHolderImage       = UIImage(named: "image-placeholder")
let kFemalePlaceHolderImage       = UIImage(named: "femaleplaceholder")
let kMalePlaceHolderImage       = UIImage(named: "maleplaceholder")
let kCurrentLanguageCode = getPreferredLocale().languageCode
let kFontAlmaraiRegular = "Almarai-Regular"
let kFontAlmaraiBold = "Almarai-Bold"
let kFontAlmaraiExtraBold = "Almarai-ExtraBold"

let kFontRobotoRegular = "Roboto-Regular"
let kFontRobotoMedium = "Roboto-Medium"
let kFontRobotoBold = "Roboto-Bold"
var kNotificationCount = 0
struct Images {
    
    static let kIconBack            = UIImage.init(named:"backIcon")?.withRenderingMode(.alwaysOriginal)
    static let kIconAdd            = UIImage.init(named:"addicon")?.withRenderingMode(.alwaysOriginal)
    static let kIconBackGreen            = UIImage.init(named:"iconprev")?.withRenderingMode(.alwaysOriginal)
    static let kIconNotification            = UIImage.init(named:"icon__Msg")?.withRenderingMode(.alwaysOriginal)
    static let kIconNoMessage            = UIImage.init(named:"icon__NoMsg")?.withRenderingMode(.alwaysOriginal)
    static let KReservationicon = UIImage.init(named: "icn_Bookings")?.withRenderingMode(.alwaysOriginal)
    static let KHideReservationicon = UIImage.init(named: "")?.withRenderingMode(.alwaysOriginal)
    static let KNoNotification = UIImage.init(named: "notification-normal")?.withRenderingMode(.alwaysOriginal)
    static let KNewNotification = UIImage.init(named: "notification-new")?.withRenderingMode(.alwaysOriginal)
   // static let KIconNotification1 = UIImage.init(named: "icon_Notification")?.withRenderingMode(.alwaysOriginal)
    
    
}

struct NotificationNames {
    
    static let kStopVideoPlayer              = "stopVideo"
    static let kUpdateProfile                = "UpdateProfile"
    static let kBlockedUser                  = "BlockedAdmin"
    static let kAlertOfferCLick               = "AlertOfferClick"
    static let KgoToSuccessPage             = "goToSuccessPage "
    static let KNotificationCountCheck       = "checkNotifiactionCount"
    
    
}

func convertDateFormat(dateStr:String) -> String {
    var dateString = ""
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: dateStr)
    dateFormatter.dateFormat = "dd/MM/yyyy"
    dateString = dateFormatter.string(from: date!)
    return dateString
}
func convertDateFormatOffer(dateStr:String) -> String {
    var dateString = ""
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    let date = dateFormatter.date(from: dateStr)
    dateFormatter.dateFormat = "dd/MM/yyyy"
    dateString = dateFormatter.string(from: date!)
    return dateString
}
func getPreferredLocale() -> Locale {
    guard let preferredIdentifier = Locale.preferredLanguages.first else {
        return Locale.current
    }
    return Locale(identifier: preferredIdentifier)
}

