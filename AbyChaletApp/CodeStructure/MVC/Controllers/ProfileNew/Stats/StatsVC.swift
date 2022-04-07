//
//  StatsVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 06/04/22.
//

import UIKit

class StatsVC: UIViewController {
    @IBOutlet weak var chaletTypeMenuCV : UICollectionView!
    
    var selectedData = ""
    var chaletType = ""
    var topSelection = ""
    var selectedIndex:Int?
    var topSliderStatsMenuArray:[String] = []
    var selectedIndexB:Int?
    var selectedIndexPathB : IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        selectedIndexB = selectedIndex
        topSliderStatsMenuArray = ["Holidays","Week (B)","Week (A)","Weekend","Weekdays","Months","Years"]
        self.chaletTypeMenuCV.scrollToItem(at: IndexPath(row: selectedIndexB ?? 0, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: true)
        print("selected Data is \(selectedData) and Chalet Type is \(chaletType)")
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        let righBarButton = UIBarButtonItem(image: Images.KStatsicon, style: .plain, target: self, action:nil)
        self.navigationItem.rightBarButtonItems = [righBarButton]
        self.navigationItem.title = "Stats"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }

}

extension StatsVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topSliderStatsMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectPricingandStatsMenuCVCell", for: indexPath) as! selectPricingandStatsMenuCVCell
        cell.lblTitle.text = topSliderStatsMenuArray[indexPath.item]
      //  self.chaletTypeMenuCV.scrollToItem(at: IndexPath(row: selectedIndexB ?? 0, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: true)
        if selectedIndexB == indexPath.row {
           // cell.imgViewBg.image = UIImage(named: "statsandcompareselectionBG")
            cell.imgViewBg.image = UIImage(named: "selectedmenuicon")

            cell.lblTitle.font = UIFont(name: "Roboto-Bold", size: 17)
        }else{
          //  cell.imgViewBg.image = UIImage(named: "icn_DeselectedPackage")
            cell.imgViewBg.image = UIImage(named: "notselectedmenuicon")
            cell.lblTitle.font = UIFont(name: "Roboto-Regular", size: 17)
        }
        cell.isSelected = (selectedIndexPathB == indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 138 , height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexB = indexPath.row
        self.topSelection = topSliderStatsMenuArray[indexPath.row]
        DispatchQueue.main.async {
            self.chaletTypeMenuCV.reloadData()
        }
    }
    
    
}
