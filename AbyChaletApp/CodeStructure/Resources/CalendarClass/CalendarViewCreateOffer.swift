//
//  CalendarViewCreateOffer.swift
//  AbyChaletApp
//
//  Created by Srishti on 17/03/22.
//

import Foundation
import UIKit




class CalendarViewCreateOffer: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MonthViewDelegateNew {
    var delegate: CalenderDelegate2?
    var topSelection = ""
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMonthIndex: Int = 0
    var currentYear: Int = 0
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayOfMonth = 0   //(Sunday-Saturday 1-7)
    var selectedDate = 0
    var isSelectionEnabled = true
    var isFromEditRepost = false
    var bookedSlotDate = [12,27,4,20]
    var UnBookedSlotDate = [5]
    var homeWorkDate = [5]
    var testDate = [5]
    //var eventDate = [5]
    var  arrayListToCalender  = [JobsPerDate]()
    var adminEventDate = [5]
    var teacherEventDate = [5]
    var selectedArray = [String]()
    var selectedDateFormatArray = [String]()
    var classIdentifier:String?
    var isThirty = Bool()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    convenience init(theme: MyThemeNew, isSelectionEnabled: Bool) {
        self.init()
        
        if theme == .dark {
            Style.themeDark()
        } else {
            Style.themeLight()
        }
        self.isSelectionEnabled = isSelectionEnabled
        initializeView()
    }
    
    func changeTheme() {
        myCollectionView.reloadData()
        
        monthView.lblName.textColor = Style.monthViewLblColor
        monthView.btnRight.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
        monthView.btnLeft.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)
        
        for i in 0..<7 {
            (weekdaysView.myStackView.subviews[i] as! UILabel).textColor = Style.weekdaysLblColor
        }
    }
    
    func initializeView() {
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth=getFirstWeekDay()
        
        //for leap years, make february month of 29 days
        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numOfDaysInMonth[currentMonthIndex-1] = 29
        }
        //end
        
        presentMonthIndex=currentMonthIndex
        presentYear=currentYear
        
        setupViews()
        
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(dateCVCell.self, forCellWithReuseIdentifier: "Cell")
        
//        if isSelectionEnabled {
//            myCollectionView.allowsSelection = true
//        }else {
//            myCollectionView.allowsSelection = false
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfDaysInMonth[currentMonthIndex-1] + firstWeekDayOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! dateCVCell
        cell.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        cell.borderWidth = 1.5
        cell.borderColor = UIColor.white
        cell.layer.cornerRadius = 0.0
        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden=true
        } else {
            let calcDate = indexPath.row-firstWeekDayOfMonth+2
            cell.isHidden=false
            cell.dateLbl.text="\(calcDate)"
            cell.dotV.isHidden = false
            
            //cell.backgroundColor=UIColor.white
            if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex  {
                cell.isUserInteractionEnabled=false
                cell.dateLbl.backgroundColor = UIColor.clear
                cell.dateLbl.textColor = UIColor("#A8A8A8")
                cell.dateLbl.backgroundColor = UIColor.clear
                cell.dateLbl.layer.borderColor = UIColor.clear.cgColor
                cell.dateLbl.layer.borderWidth = 0.0
                
            }
            else if calcDate == todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                // cell.isUserInteractionEnabled=false
                cell.isUserInteractionEnabled=true
                cell.dateLbl.layer.borderColor = UIColor.green.cgColor
                cell.dateLbl.layer.borderWidth = 1.0
                //cell.dateLbl.backgroundColor = UIColor(red: 0/255, green: 147/255, blue: 220/255, alpha: 1.0)//UIColor.orange
                cell.dateLbl.textColor = #colorLiteral(red: 0.168627451, green: 0.3294117647, blue: 0.4078431373, alpha: 1)
                if(bookedSlotDate.contains(calcDate)){
                    cell.dotV.isHidden = false
                }
            }
                /*else if bookedSlotDate.contains(calcDate) {
                 cell.isUserInteractionEnabled=true
                 cell.dateLbl.textColor = UIColor.red
                 } else if selectedDate == calcDate {
                 cell.isUserInteractionEnabled=true
                 cell.backgroundColor = Colors.darkRed
                 cell.dateLbl.textColor = UIColor.white
                 
             }*/ else {
                cell.isUserInteractionEnabled=true
                cell.dateLbl.textColor = #colorLiteral(red: 0.168627451, green: 0.3294117647, blue: 0.4078431373, alpha: 1)
                cell.dateLbl.backgroundColor = UIColor.clear
                cell.dateLbl.layer.borderColor = UIColor.clear.cgColor
                cell.dateLbl.layer.borderWidth = 0.0
                
            }
            if arrayListToCalender.contains(where: {$0.jobDate == calcDate && $0.jobYear == currentYear && $0.jobMonth ==  currentMonthIndex}) {
                
                cell.dateLbl.layer.cornerRadius = 0.0
                cell.dateLbl.roundCorners(corners: [.bottomRight,.topRight,.topLeft,.bottomLeft], radius: 0)
                cell.dateLbl.backgroundColor = #colorLiteral(red: 0.7447500833, green: 0.02745098062, blue: 0.1068515121, alpha: 1)
            }else{
                let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let jDate = dateFormatter.date(from: clickedDate)!
                if selectedArray.contains(dateFormatter.string(from: jDate)){
                    if topSelection == "weekend" {
                        if self.selectedArray.count == 3 {
                            if self.selectedArray.first == dateFormatter.string(from: jDate) {
                                cell.dateLbl.roundCorners(corners: [.topLeft,.bottomLeft], radius: 10)
                                cell.dateLbl.backgroundColor = #colorLiteral(red: 0, green: 0.7844216353, blue: 0, alpha: 1)
                                cell.dateLbl.textColor = UIColor.white
                            }else if self.selectedArray.last == dateFormatter.string(from: jDate){
                                cell.dateLbl.roundCorners(corners: [.bottomRight,.topRight], radius: 10)
                                cell.dateLbl.backgroundColor = #colorLiteral(red: 0, green: 0.7844216353, blue: 0, alpha: 1)
                                cell.dateLbl.textColor = UIColor.white
                            }else {
                                cell.dateLbl.backgroundColor = #colorLiteral(red: 0.7843137255, green: 1, blue: 0.7019607843, alpha: 0.5271136225)
                                cell.dateLbl.layer.cornerRadius = 0.0
                                cell.dateLbl.textColor = #colorLiteral(red: 0.2156862745, green: 0.6235294118, blue: 0, alpha: 1)
                            }
                        }else{
                            cell.dateLbl.layer.cornerRadius = 0.0
                            cell.dateLbl.roundCorners(corners: [.bottomRight,.topRight,.topLeft,.bottomLeft], radius: 0)
                            cell.dateLbl.backgroundColor = UIColor("#EBEBEB").withAlphaComponent(0.5)
                        }
                    }else if topSelection == "weekdays" {
                        if self.selectedArray.count == 4 {
                            if self.selectedArray.first == dateFormatter.string(from: jDate) {
                                cell.dateLbl.roundCorners(corners: [.topLeft,.bottomLeft], radius: 10)
                                cell.dateLbl.backgroundColor = #colorLiteral(red: 0, green: 0.7844216353, blue: 0, alpha: 1)
                                cell.dateLbl.textColor = UIColor.white
                            }else if self.selectedArray.last == dateFormatter.string(from: jDate){
                                cell.dateLbl.roundCorners(corners: [.bottomRight,.topRight], radius: 10)
                                cell.dateLbl.backgroundColor = #colorLiteral(red: 0, green: 0.7844216353, blue: 0, alpha: 1)
                                cell.dateLbl.textColor = UIColor.white
                            }else {
                                cell.dateLbl.backgroundColor = #colorLiteral(red: 0.7843137255, green: 1, blue: 0.7019607843, alpha: 0.5271136225)
                                cell.dateLbl.layer.cornerRadius = 0.0
                                cell.dateLbl.textColor = #colorLiteral(red: 0.2156862745, green: 0.6235294118, blue: 0, alpha: 1)
                            }
                        }else{
                            cell.dateLbl.layer.cornerRadius = 0.0
                            cell.dateLbl.roundCorners(corners: [.bottomRight,.topRight,.topLeft,.bottomLeft], radius: 0)
                            cell.dateLbl.backgroundColor = UIColor("#EBEBEB").withAlphaComponent(0.5)
                        }
                    }else if topSelection == "weekA" || topSelection == "weekB" {
                        if self.selectedArray.count == 7 {
                            if self.selectedArray.first == dateFormatter.string(from: jDate) {
                                cell.dateLbl.roundCorners(corners: [.topLeft,.bottomLeft], radius: 10)
                                cell.dateLbl.backgroundColor = #colorLiteral(red: 0, green: 0.7844216353, blue: 0, alpha: 1)
                                cell.dateLbl.textColor = UIColor.white
                            }else if self.selectedArray.last == dateFormatter.string(from: jDate){
                                cell.dateLbl.roundCorners(corners: [.bottomRight,.topRight], radius: 10)
                                cell.dateLbl.backgroundColor = #colorLiteral(red: 0, green: 0.7844216353, blue: 0, alpha: 1)
                                cell.dateLbl.textColor = UIColor.white
                            }else {
                                cell.dateLbl.backgroundColor = #colorLiteral(red: 0.7843137255, green: 1, blue: 0.7019607843, alpha: 0.5271136225)
                                cell.dateLbl.layer.cornerRadius = 0.0
                                cell.dateLbl.textColor = #colorLiteral(red: 0.2156862745, green: 0.6235294118, blue: 0, alpha: 1)
                            }
                        }else{
                            cell.dateLbl.layer.cornerRadius = 0.0
                            cell.dateLbl.roundCorners(corners: [.bottomRight,.topRight,.topLeft,.bottomLeft], radius: 0)
                            cell.dateLbl.backgroundColor = UIColor("#EBEBEB").withAlphaComponent(0.5)
                        }
                    }else{
                        if self.selectedArray.first == dateFormatter.string(from: jDate) {
                            cell.dateLbl.roundCorners(corners: [.topLeft,.bottomLeft], radius: 10)
                            cell.dateLbl.backgroundColor = #colorLiteral(red: 0, green: 0.7844216353, blue: 0, alpha: 1)
                            cell.dateLbl.textColor = UIColor.white
                        }else if self.selectedArray.last == dateFormatter.string(from: jDate){
                            cell.dateLbl.roundCorners(corners: [.bottomRight,.topRight], radius: 10)
                            cell.dateLbl.backgroundColor = #colorLiteral(red: 0, green: 0.7844216353, blue: 0, alpha: 1)
                            cell.dateLbl.textColor = UIColor.white
                        }else {
                            cell.dateLbl.backgroundColor = #colorLiteral(red: 0.7843137255, green: 1, blue: 0.7019607843, alpha: 0.5271136225)
                            cell.dateLbl.layer.cornerRadius = 0.0
                            cell.dateLbl.textColor = #colorLiteral(red: 0.2156862745, green: 0.6235294118, blue: 0, alpha: 1)
                        }
                    }
                }else{
                    cell.dateLbl.layer.cornerRadius = 0.0
                    cell.dateLbl.roundCorners(corners: [.bottomRight,.topRight,.topLeft,.bottomLeft], radius: 0)
                    cell.dateLbl.backgroundColor = UIColor("#EBEBEB").withAlphaComponent(0.5)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        let calcDate = indexPath.row-firstWeekDayOfMonth+2
        if arrayListToCalender.contains(where: {$0.jobDate == calcDate && $0.jobYear == currentYear && $0.jobMonth ==  currentMonthIndex}) {
            
        print("red")
        delegate?.delegateChaletReserved()
        }else{
        let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
        print(clickedDate)
        calendarSelectedDate.sharedData.selectedCalendarDate = clickedDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let jDate = dateFormatter.date(from: clickedDate)!
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let jobDate: String = dateFormatter.string(from: jDate)
        let selectedDay = self.getDayName(selectedDate: jobDate)
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd/MM/yyyy"
        let currentDateStr = dateFormatter1.string(from: Date())
        //let currentDateStr = "\(todaysDate)/\(currentMonthIndex)/\(currentYear)"
        
        if topSelection == "Weekdays"{
            print(selectedDay)
            if selectedDay == "Sunday" || selectedDay == "Monday" || selectedDay == "Tuesday" || selectedDay == "Wednesday" {
                self.selectedDateFormatArray.removeAll()
                self.selectedDateFormatArray.insert(jobDate, at: 0)
                //delegate?.didTapDate(day: calcDate, date: "Date:\(calcDate)/\(currentMonthIndex)/\(currentYear)", available: true, selectedDates: selectedDateFormatArray)
                
                //if selectedArray.contains("\(calcDate)/\(currentMonthIndex)/\(currentYear)") == false {
                if selectedDay == "Monday" {
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let sunDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    if sunDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: sunDate!))
                    }
                    //selectedArray.append("\(calcDate)/\(currentMonthIndex)/\(currentYear)")
                    selectedArray.append(dateFormatter.string(from: jDate))
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    self.reload()
                }else if selectedDay == "Tuesday" {
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let sunDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    if sunDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: sunDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    selectedArray.append(dateFormatter.string(from: jDate))
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    self.reload()
                }else if selectedDay == "Wednesday" {
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let sunDate = Calendar.current.date( byAdding: .day,value: -3,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    
                    
                    //let currentDate = dateFormatter.date(from: currentDateStr)
                    
                    if sunDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: sunDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    selectedArray.append(dateFormatter.string(from: jDate))
                    
                    self.reload()
                }else if selectedDay == "Sunday" {
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let sunDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 3,to: jDate)
                    selectedArray.append(dateFormatter.string(from: jDate))
                    
                    if sunDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: sunDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    self.reload()
                }
                
                delegate?.didTapDate(day: calcDate, date: "Date:\(calcDate)/\(currentMonthIndex)/\(currentYear)", available: true, selectedDates: selectedArray)
                
                /*}else{
                 let indx = selectedArray.firstIndex(of: "\(calcDate)/\(currentMonthIndex)/\(currentYear)")
                 if indx != nil {
                 selectedArray.remove(at: indx!)
                 }
                 }*/
                
            }else{
                delegate?.noChaletAvailable()
            }
        }else if topSelection == "Weekend"{
            
            if selectedDay == "Thursday" || selectedDay == "Friday" || selectedDay == "Saturday" {
                if selectedDay == "Thursday" {
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let sunDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    selectedArray.append(dateFormatter.string(from: jDate))
                    if sunDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: sunDate!))
                    }
                    //selectedArray.append("\(calcDate)/\(currentMonthIndex)/\(currentYear)")
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    self.reload()
                }else if selectedDay == "Friday" {
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let tuesDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    selectedArray.append(dateFormatter.string(from: jDate))
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    self.reload()
                }else if selectedDay == "Saturday" {
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let tuesDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    selectedArray.append(dateFormatter.string(from: jDate))
                    self.reload()
                }
                delegate?.didTapDate(day: calcDate, date: "Date:\(calcDate)/\(currentMonthIndex)/\(currentYear)", available: true, selectedDates: selectedArray)
            }else{
                delegate?.noChaletAvailable()
            }
            
        }else if topSelection == "Week (A)"{
            if selectedDay == "Saturday" || selectedDay == "Monday" || selectedDay == "Tuesday" || selectedDay == "Wednesday" || selectedDay == "Thursday" || selectedDay == "Friday" || selectedDay == "Friday" || selectedDay == "Sunday" {
                if selectedDay == "Sunday" {
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let monDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 3,to: jDate)
                    let thursDate = Calendar.current.date( byAdding: .day,value: 4,to: jDate)
                    let fridayDate = Calendar.current.date( byAdding: .day,value: 5,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: 6,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    selectedArray.append(curreDate)
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    if thursDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: thursDate!))
                    }
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    self.reload()
                }else if selectedDay == "Monday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let monDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    let thursDate = Calendar.current.date( byAdding: .day,value: 3,to: jDate)
                    let fridayDate = Calendar.current.date( byAdding: .day,value: 4,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: 5,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    selectedArray.append(curreDate)
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    if thursDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: thursDate!))
                    }
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    self.reload()
                }else if selectedDay == "Tuesday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let monDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let thursDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    let fridayDate = Calendar.current.date( byAdding: .day,value: 3,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: 4,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    selectedArray.append(curreDate)
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    if thursDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: thursDate!))
                    }
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    self.reload()
                }else if selectedDay == "Wednesday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let monDate = Calendar.current.date( byAdding: .day,value: -3,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let thursDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let fridayDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: 3,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    selectedArray.append(curreDate)
                    if thursDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: thursDate!))
                    }
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    self.reload()
                }else if selectedDay == "Thursday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let monDate = Calendar.current.date( byAdding: .day,value: -4,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: -3,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let thursDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let fridayDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    if thursDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: thursDate!))
                    }
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    selectedArray.append(curreDate)
                    
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    self.reload()
                }else if selectedDay == "Friday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let monDate = Calendar.current.date( byAdding: .day,value: -5,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: -4,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: -3,to: jDate)
                    let thursDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let fridayDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    if thursDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: thursDate!))
                    }
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    selectedArray.append(curreDate)
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    self.reload()
                }else if selectedDay == "Saturday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let monDate = Calendar.current.date( byAdding: .day,value: -6,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: -5,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: -4,to: jDate)
                    let thursDate = Calendar.current.date( byAdding: .day,value: -3,to: jDate)
                    let fridayDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    if thursDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: thursDate!))
                    }
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                        selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    selectedArray.append(curreDate)
                    self.reload()
                }
                delegate?.didTapDate(day: calcDate, date: "Date:\(calcDate)/\(currentMonthIndex)/\(currentYear)", available: true, selectedDates: selectedArray)
            }else{
                delegate?.noChaletAvailable()
            }
            
        }else if topSelection == "Week (B)" {
            if selectedDay == "Saturday" || selectedDay == "Monday" || selectedDay == "Tuesday" || selectedDay == "Wednesday" || selectedDay == "Thursday" || selectedDay == "Friday" || selectedDay == "Sunday" {
                if selectedDay == "Thursday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "dd-MM-yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let fridayDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    let sundayDate = Calendar.current.date( byAdding: .day,value: 3,to: jDate)
                    let monDate = Calendar.current.date( byAdding: .day,value: 4,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: 5,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 6,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    selectedArray.append(curreDate)
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    if sundayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: sundayDate!))
                    }
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    DispatchQueue.main.async {
                        self.reload()
                    }
                    
                }else if selectedDay == "Friday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let fridayDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let sundayDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    let monDate = Calendar.current.date( byAdding: .day,value: 3,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: 4,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 5,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    selectedArray.append(curreDate)
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    if sundayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: sundayDate!))
                    }
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    self.reload()
                }else if selectedDay == "Saturday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let fridayDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let sundayDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let monDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: 3,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 4,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    selectedArray.append(curreDate)
                    if sundayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: sundayDate!))
                    }
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    self.reload()
                }else if selectedDay == "Sunday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let fridayDate = Calendar.current.date( byAdding: .day,value: -3,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let sundayDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let monDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 3,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    if sundayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: sundayDate!))
                    }
                    selectedArray.append(curreDate)
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    self.reload()
                }else if selectedDay == "Monday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let fridayDate = Calendar.current.date( byAdding: .day,value: -4,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: -3,to: jDate)
                    let sundayDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let monDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 2,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    if sundayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: sundayDate!))
                    }
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    selectedArray.append(curreDate)
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    self.reload()
                }else if selectedDay == "Tuesday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let fridayDate = Calendar.current.date( byAdding: .day,value: -5,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: -4,to: jDate)
                    let sundayDate = Calendar.current.date( byAdding: .day,value: -3,to: jDate)
                    let monDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: 1,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    if sundayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: sundayDate!))
                    }
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    selectedArray.append(curreDate)
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    self.reload()
                }else if selectedDay == "Wednesday"{
                    selectedArray.removeAll()
                    let clickedDate = "\(calcDate)/\(currentMonthIndex)/\(currentYear)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let jDate = dateFormatter.date(from: clickedDate)!
                    let fridayDate = Calendar.current.date( byAdding: .day,value: -6,to: jDate)
                    let saturdayDate = Calendar.current.date( byAdding: .day,value: -5,to: jDate)
                    let sundayDate = Calendar.current.date( byAdding: .day,value: -4,to: jDate)
                    let monDate = Calendar.current.date( byAdding: .day,value: -3,to: jDate)
                    let tuesDate = Calendar.current.date( byAdding: .day,value: -2,to: jDate)
                    let wedDate = Calendar.current.date( byAdding: .day,value: -1,to: jDate)
                    let curreDate = dateFormatter.string(from: jDate)
                    if fridayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: fridayDate!))
                    }
                    if saturdayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: saturdayDate!))
                    }
                    if sundayDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: sundayDate!))
                    }
                    if monDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: monDate!))
                    }
                    if tuesDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: tuesDate!))
                    }
                    if wedDate! < dateFormatter.date(from: currentDateStr)!  {
                    }else{
                    selectedArray.append(dateFormatter.string(from: wedDate!))
                    }
                    selectedArray.append(curreDate)
                    self.reload()
                }
                delegate?.didTapDate(day: calcDate, date: "Date:\(calcDate)/\(currentMonthIndex)/\(currentYear)", available: true, selectedDates: selectedArray)
            }else{
                delegate?.noChaletAvailable()
            }
        }else{
            delegate?.noChaletAvailable()
        }
        
        }
        
        print(selectedArray)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath)
       
        
        let calcDate = indexPath.row-firstWeekDayOfMonth+2
        if calcDate == todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex{
            let lbl = cell?.subviews[1] as! UILabel
            lbl.textColor = UIColor.white
            lbl.backgroundColor = UIColor(red: 0/255, green: 147/255, blue: 220/255, alpha: 1.0)//UIColor.orange
        }else{
            let lbl = cell?.subviews[1] as! UILabel
            if(calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex){
                lbl.textColor = UIColor.lightGray
            }else{
                lbl.textColor = Style.activeCellLblColor
            }
            lbl.backgroundColor = UIColor.clear
        }
        print(selectedArray)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/7
        let height: CGFloat = collectionView.frame.width/7

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func getFirstWeekDay() -> Int {
        
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
       // return day == 7 ? 1 : day
         return day == 7 ? 7 : day
    }
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex=monthIndex+1
        currentYear = year
        
        //for leap year, make february month of 29 days
        if monthIndex == 1 {
            if currentYear % 4 == 0 {
                numOfDaysInMonth[monthIndex] = 29
            } else {
                numOfDaysInMonth[monthIndex] = 28
            }
        }
        //end
        self.delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
        firstWeekDayOfMonth=getFirstWeekDay()
        myCollectionView.reloadData()
        monthView.btnLeft.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
    }
    
    func reload()  {
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
        }
        
    }
    
    func getDayName(selectedDate:String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date = dateFormatter.date(from: selectedDate)
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date!)
        return dayInWeek
    }
    
    func setupViews() {
        addSubview(monthView)
        monthView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        monthView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        monthView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        monthView.heightAnchor.constraint(equalToConstant: 45).isActive=true
        monthView.delegate=self
        
        addSubview(weekdaysView)
        weekdaysView.topAnchor.constraint(equalTo: monthView.bottomAnchor).isActive=true
        weekdaysView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        weekdaysView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        weekdaysView.heightAnchor.constraint(equalToConstant: 35).isActive=true
        
        addSubview(myCollectionView)
        myCollectionView.topAnchor.constraint(equalTo: weekdaysView.bottomAnchor, constant: 0).isActive=true
        myCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive=true
        myCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive=true
        myCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
    
    let monthView: MonthViewNew = {
        let v=MonthViewNew()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let weekdaysView: WeekdaysViewNew = {
        let v=WeekdaysViewNew()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let myCollectionView=UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints=false
        myCollectionView.backgroundColor=UIColor.clear
        myCollectionView.allowsMultipleSelection=false
        return myCollectionView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

}

protocol CalenderDelegate2 {
    func didTapDate(day: Int, date:String, available:Bool,selectedDates:[String])
    func didChangeMonth(monthIndex:Int,year:Int)
    func showPopupMaxLimit()
    func noChaletAvailable()
    func delegateChaletReserved()
}
