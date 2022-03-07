//
//  AddSeasonPriceMainVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 07/03/22.
//

import UIKit

class AddSeasonPriceMainVC: UIViewController {
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    var topSliderMenuArray:[String] = []
    var selectedIndex:Int?
    var selectedIndexPath : IndexPath?
    var topSelection = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        topSliderMenuArray = ["holidays prices","Season prices","Stats"]
        selectedIndex = 1
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Add season price to chalet".localized()
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    @objc func backButtonTouched()  {
       // self.navigationController?.popViewController(animated: true)
        let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "myChaletVC") as! myChaletVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
    

}

extension AddSeasonPriceMainVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topSliderMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 138 , height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.topSelection = topSliderMenuArray[indexPath.row]
        DispatchQueue.main.async {
            self.menuCollectionView.reloadData()
        }
        if topSelection == "holidays prices"{
           print("Selected holidays prices")
            let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "AddHolidayPriceMainVC") as! AddHolidayPriceMainVC
            navigationController?.pushViewController(nextVC, animated: true)
        }else if topSelection == "Season prices"{
            print("Selected Season prices")
        }else{
            print("Selected Stats")
            let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "myChaletVC") as! myChaletVC
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
}


