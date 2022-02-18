//
//  DayinHoursCountDownTimer.swift
//  AbyChaletApp
//
//  Created by Srishti on 15/02/22.
//
import Foundation

func defaultUpdateActionHandlerr(string:String)->(){

}

func defaultCompletionActionHandlerr()->(){

}

public class DayInHoursCountDownTimer{

    var countdownTimer: Timer!
    var totalTime = 60
    var dateString = "March 4, 2018 13:20:10" as String
    var UpdateActionHandler:(String)->() = defaultUpdateActionHandlerr
    var CompletionActionHandler:()->() = defaultCompletionActionHandlerr

    public init(){
        countdownTimer = Timer()
        totalTime = 60
        dateString = "March 4, 2018 13:20:10" as String
        UpdateActionHandler = defaultUpdateActionHandlerr
        CompletionActionHandler = defaultCompletionActionHandlerr
    }

    public func initializeTimer(_ date: String) {

        self.dateString = date

        // Setting Today's Date
        let currentDate = Date()

        // Setting TargetDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = NSTimeZone.local
        if let targedDate = dateFormatter.date(from: dateString) {

            let currentD = dateFormatter.string(from: currentDate)
            let cuD = dateFormatter.date(from: currentD)
        // Calculating the difference of dates for timer
            let calendar = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: cuD!, to: targedDate)
        let days = calendar.day!
        let hours = calendar.hour!
        let minutes = calendar.minute!
        let seconds = calendar.second!
        totalTime = hours * 60 * 60 + minutes * 60 + seconds
        totalTime = days * 60 * 60 * 24 + totalTime
    }
    }

    func numberOfDaysInMonth(month:Int) -> Int{
        let dateComponents = DateComponents(year: 2015, month: 7)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        //print(numDays)
        return numDays
    }

    public func startTimer1(pUpdateActionHandler:@escaping (String)->(),pCompletionActionHandler:@escaping ()->()) {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.CompletionActionHandler = pCompletionActionHandler
        self.UpdateActionHandler = pUpdateActionHandler
    }

    @objc func updateTime() {
       // self.UpdateActionHandler(timeFormatted(totalTime))
        self.UpdateActionHandler(secondsToHoursMinutesSeconds(totalTime))

        if totalTime > 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }

    func endTimer() {
        self.CompletionActionHandler()
        countdownTimer.invalidate()
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> String {
        let hours: Int = seconds / 3600
        let min: Int = (seconds % 3600) / 60
        let sec : Int = (seconds % 3600) % 60
        
        if hours > 0{
            return String(format: "%02d:%02d:%02d", hours,min,sec)
        }else if min > 0{
            return String(format: "%02d:%02d",min, sec)
        }else{
            return String(format: "%02d Second", sec)
        }
    }

    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = (totalSeconds / 60 / 60) % 24
        let days: Int = (totalSeconds / 60 / 60 / 24)
        
       if days > 0 {
            return String(format: "%02d:%02d:%02d", days,hours,minutes,seconds)
        }else
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }else if minutes > 0  {
            return String(format: "%02d:%02d",minutes, seconds)
        }else {
            return String(format: "%02d Second", seconds)
        }
    }

}
