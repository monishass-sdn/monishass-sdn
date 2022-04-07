//
//  OwnerSubChaletsVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 21/03/22.
//

import UIKit
import SVProgressHUD

class OwnerSubChaletsVC: UIViewController {
    @IBOutlet weak var ownersubchaletTV : UITableView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var lblpopupheader : UILabel!
    @IBOutlet weak var popupheader_image : UIImageView!
    @IBOutlet weak var lbl_mainChaletName : UILabel!
    @IBOutlet weak var heightforStatsandcompareView: NSLayoutConstraint!
    @IBOutlet weak var maskView: UIView!

    
    var arrayownerSubchaletList = [ChaletLists]()
    var mainchaletid = ""
    var mainchaletname = ""
    var toggledIndexes = [Int:Bool]()
    var topSliderMenuArray:[String] = []
    var topSliderStatsMenuArray:[String] = []
    var selectedIndex:Int?
    var topSelection = ""
    var selectedIndexB:Int?
    var selectedIndexPath : IndexPath?
    var selectedIndexPathB : IndexPath?
    var isBottomSheetshown : Bool = false
    var isclicked_Compare : Bool = false
    var isclicked_Stats : Bool = false
    var touched : Bool = false
    var chaletId = 0
    var chaletstatus : Bool = false
    var isfrommainchalet : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setupForCustomNavigationTitle1()
        getmysubChalets()
        topSliderStatsMenuArray = ["Holidays","Week (B)","Week (A)","Weekend","Weekdays","Months","Years"]
        selectedIndexB = 6

        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupForCustomNavigationTitle1(){

        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "My", attributes:[
                                                    NSAttributedString.Key.foregroundColor: UIColor.green,
                                                    NSAttributedString.Key.font: UIFont(name: "Roboto-BoldItalic", size: 25)! ])

        navTitle.append(NSMutableAttributedString(string: " Chalet", attributes:[
                                                    NSAttributedString.Key.font: UIFont(name: "Roboto-BoldItalic", size: 25)! ,
                                                    NSAttributedString.Key.foregroundColor: UIColor.white]))

        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
    }

}


extension OwnerSubChaletsVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayownerSubchaletList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerSubChaletsTVCell", for: indexPath) as! OwnerSubChaletsTVCell
        cell.setValuesToFields(dict: arrayownerSubchaletList[indexPath.row])
        cell.BtnViewDetails.addTarget(self, action: #selector(viewDetails), for: .touchUpInside)
        cell.toggleBtn.addTarget(self, action: #selector(toggleAction), for: .touchUpInside)
        cell.BtnStat.addTarget(self, action: #selector(statsTapped), for: .touchUpInside)
        cell.BtnCompare.addTarget(self, action: #selector(compareTapped), for: .touchUpInside)
        cell.bttonView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
        cell.BtnViewDetails.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if toggledIndexes[indexPath.row] == true{
            return 660.0
        }else{
            return 220.0
        }
    }
    
    @objc func viewDetails(_ sender: UIButton!){
        let indexpath = IndexPath(row: sender.tag, section: 0)
        sender.isSelected = !sender.isSelected
        let cell = ownersubchaletTV.cellForRow(at: indexpath) as! OwnerSubChaletsTVCell
       // let item = arryAvailableOfferChaletList[sender.tag]
        if sender.isSelected == true{
            cell.downUpArrow.setImage(#imageLiteral(resourceName: "arrow-Up"), for: .normal)
           // cell.bttonView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
            cell.topView.roundCorners(corners: [.topLeft,.topRight], radius: 10)
            cell.topView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 0)
            toggledIndexes[sender.tag] = true

        }else{
            toggledIndexes[sender.tag] = false
            cell.downUpArrow.setImage(#imageLiteral(resourceName: "arrow-Down"), for: .normal)
            cell.topView.roundCorners(corners: [.topLeft,.topRight], radius: 10)
            cell.topView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
          //  cell.bttonView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 0)


        }
        self.ownersubchaletTV.reloadData()

    }
    
    @objc func toggleAction(_ sender: UIButton!){
        let indexpath = IndexPath(row: sender.tag, section: 0)
        let cell = ownersubchaletTV.cellForRow(at: indexpath) as! OwnerSubChaletsTVCell
        cell.istoggleON = !cell.istoggleON
        
        chaletId = self.arrayownerSubchaletList[indexpath.row].chalet_id!
        isfrommainchalet = false
        chaletstatus = self.arrayownerSubchaletList[indexpath.row].reservation_available!
        print("chalet id = \(chaletId)")
        print("isfrommainchalet = \(isfrommainchalet)")
        print("chaletstatus = \(chaletstatus)")
        
        updateReservationStatus()
        if cell.istoggleON {
            sender.setImage(UIImage(named: "toggleONReservation"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "toggleOFFReservation"), for: .normal)
        }
        
        
    }
  
   @objc func statsTapped(_ sender: UIButton!){
        self.lblpopupheader.text = "Stats"
        let imagefile: UIImage = UIImage(named: "statsWhite")!
        popupheader_image.image = imagefile
        if (isBottomSheetshown){
            UIView.animate(withDuration: 0.3, animations: {
                self.heightforStatsandcompareView.constant = 0
                self.view.layoutIfNeeded()
            }){(status) in
                self.isBottomSheetshown = false
                self.maskView.isHidden = true
               // self.maskView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            }
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.heightforStatsandcompareView.constant = 400
                self.view.layoutIfNeeded()
            }){(status) in
                self.isBottomSheetshown = true
                self.isclicked_Stats = true
                self.maskView.isHidden = false
                self.maskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.heightforStatsandcompareView.constant = 400
                    self.view.layoutIfNeeded()
                }){(status) in
                   // self.isBottomSheetshown = true
                    
                }
            }
        }

    }
    
    @objc func compareTapped(_ sender: UIButton!){

        self.lblpopupheader.text = "Compare"
        let imagefile: UIImage = UIImage(named: "compareicon")!
        popupheader_image.image = imagefile
        if (isBottomSheetshown){
            UIView.animate(withDuration: 0.3, animations: {
                self.heightforStatsandcompareView.constant = 0
                self.view.layoutIfNeeded()
            }){(status) in
                self.isBottomSheetshown = false
                self.maskView.isHidden = true
               // self.maskView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            }
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.heightforStatsandcompareView.constant = 400
                self.view.layoutIfNeeded()
            }){(status) in
                self.isBottomSheetshown = true
                self.isclicked_Compare = true
                self.maskView.isHidden = false
                self.maskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.heightforStatsandcompareView.constant = 400
                    self.view.layoutIfNeeded()
                }){(status) in
                   // self.isBottomSheetshown = true
                    
                }
            }
        }

    }
  


    @IBAction func closeBtn_Tapped(_ sender:UIButton!){
        UIView.animate(withDuration: 0.3, animations: {
            self.heightforStatsandcompareView.constant = 0
            self.view.layoutIfNeeded()
        }){(status) in
            self.isBottomSheetshown = false
            self.isclicked_Compare = false
            self.isclicked_Stats = false
            self.maskView.isHidden = true
        }
    }
  

}

extension OwnerSubChaletsVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return self.topSliderStatsMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     /*   if collectionView == menuCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectPricingandStatsMenuCVCell", for: indexPath) as! selectPricingandStatsMenuCVCell
            cell.lblTitle.text = topSliderMenuArray[indexPath.item]
            self.menuCollectionView.scrollToItem(at: IndexPath(row: selectedIndex ?? 0, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: true)
            if selectedIndex == indexPath.row {
                cell.imgViewBg.image = UIImage(named: "icn_SelectedPackage")
                cell.lblTitle.font = UIFont(name: "Roboto-Bold", size: 17)
            }else{
                cell.imgViewBg.image = UIImage(named: "icn_DeselectedPackage")
                cell.lblTitle.font = UIFont(name: "Roboto-Regular", size: 17)
            }
            cell.isSelected = (selectedIndexPath == indexPath)
            
            return cell
        }else{*/
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectPricingandStatsMenuCVCell", for: indexPath) as! selectPricingandStatsMenuCVCell
            cell.lblTitle.text = topSliderStatsMenuArray[indexPath.item]
            self.menuCollectionView.scrollToItem(at: IndexPath(row: selectedIndexB ?? 0, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: true)
            if selectedIndexB == indexPath.row {
                cell.imgViewBg.image = UIImage(named: "statsandcompareselectionBG")
                cell.lblTitle.font = UIFont(name: "Roboto-Bold", size: 17)
            }else{
                cell.imgViewBg.image = UIImage(named: "icn_DeselectedPackage")
                cell.lblTitle.font = UIFont(name: "Roboto-Regular", size: 17)
            }
            cell.isSelected = (selectedIndexPathB == indexPath)
            
            return cell
       // }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     //   if collectionView == menuCollectionView{
      //      return CGSize(width: 138 , height: 40)
      //  }else{
            return CGSize(width: 138 , height: 40)
      //  }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     /*   if collectionView == menuCollectionView{
            self.selectedIndex = indexPath.row
            self.topSelection = topSliderMenuArray[indexPath.row]
            DispatchQueue.main.async {
                self.menuCollectionView.reloadData()
            }
            if topSelection == "Holidays prices"{
               print("Selected holidays prices")
                let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "AddHolidayPriceMainVC") as! AddHolidayPriceMainVC
                navigationController?.pushViewController(nextVC, animated: true)
            }else if topSelection == "Season prices"{
                print("Selected Season prices")
                let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "AddSeasonPriceMainVC") as! AddSeasonPriceMainVC
                navigationController?.pushViewController(nextVC, animated: true)
            }else{
                print("Selected Stats")
            }
        }else{*/
            //call the picker
            self.selectedIndex = indexPath.row
            self.topSelection = topSliderStatsMenuArray[indexPath.row]
            DispatchQueue.main.async {
                self.menuCollectionView.reloadData()
            }
       // }

    }
    
    
}

extension OwnerSubChaletsVC{
        func getmysubChalets() {
            SVProgressHUD.show()
            self.view.isUserInteractionEnabled = false
            ServiceManager.sharedInstance.postMethodAlamofire("api/owner-sub-chalets", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : "","mainChaletId":mainchaletid], withHud: true) { (success, response, error) in
               
                if success {
                    if ((response as! NSDictionary) ["status"] as! Bool) == true {
                        let responseBase = myChaletList_Base(dictionary: response as! NSDictionary)
                        self.arrayownerSubchaletList = (responseBase?.chaletLists)!
                        self.lbl_mainChaletName.text = self.mainchaletname
                     //   print("Count = \(self.arrayMyChalets.count)")
                        DispatchQueue.main.async {
                            self.ownersubchaletTV.reloadData()
                            SVProgressHUD.dismiss()
                            self.view.isUserInteractionEnabled = true
                        }
                    }else{
                        showDefaultAlert(viewController: self, title: "", msg: response!["message"]! as! String)
                        self.view.isUserInteractionEnabled = true
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
                    self.view.isUserInteractionEnabled = true
                }
            }
        }
    
    func updateReservationStatus() {

        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/update-reservation-status", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : "","id":chaletId,"is_from_main_chalet":isfrommainchalet,"status": chaletstatus], withHud: true) { (success, response, error) in
            print(response)
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = myChaletList_Base(dictionary: response as! NSDictionary)
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.getmysubChalets()
                        self.ownersubchaletTV.reloadData()
                        self.view.isUserInteractionEnabled = true
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "", msg: response!["message"]! as! String)
                    self.view.isUserInteractionEnabled = true
                }
            }else{
                showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    }
