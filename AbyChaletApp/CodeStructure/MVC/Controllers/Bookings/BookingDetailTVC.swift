//
//  BookingDetailTVC.swift
//  AbyChaletApp
//
//  Created by Visakh Srishti on 04/06/21.
//

import UIKit
import DHSmartScreenshot
import MediaPlayer
import AVKit

class BookingDetailTVC: UITableViewController {

    @IBOutlet weak var lblCollectionIndex: UILabel!
    @IBOutlet weak var viewCollectionIndex: UIView!
    @IBOutlet weak var lblOfferDiscount : UILabel!
    @IBOutlet weak var lblDeposit : UILabel!
    @IBOutlet weak var lblTotalPaid: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var collectionViewAgrrement: UICollectionView!
    @IBOutlet weak var collectionViewChalletDetails: UICollectionView!
    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblCheckOut: UILabel!
    @IBOutlet weak var lblBookingDetails: UILabel!
    @IBOutlet weak var lblRentalPrice: UILabel!
    @IBOutlet weak var lblTotalRewardsDiscount: UILabel!
    @IBOutlet weak var lblTotalInvoice: UILabel!
    @IBOutlet weak var lblChaletDetails: UILabel!
    @IBOutlet weak var lblAgreement: UILabel!
    @IBOutlet weak var lblYouMustAgreeAllConditions: UILabel!
    
    @IBOutlet weak var lblChaletId: UILabel!
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var collectionViewChalletImage: UICollectionView!
    @IBOutlet weak var viewChaletHeadingDetails: UIView!
    @IBOutlet weak var viewBgCollectionView: UIView!
    var dictMyBooking : MyBooking_details!
    var arrayAgreements = [Agreement]()
    var collectionIndex = 0
    var lblIndexValue = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpNavigationBar()
        self.getAgreementsDetails()
        self.setupUI()
        self.setValuesToFields()
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUser), name: NSNotification.Name(rawValue: NotificationNames.kBlockedUser), object: nil)
        
        lblCheckIn.text = "Check-in".localized()
        lblCheckOut.text = "Check-Out".localized()
        lblBookingDetails.text = "Booking Details".localized()
        lblRentalPrice.text = "Rental Price".localized()
        lblTotalRewardsDiscount.text = "Total Rewards (Discount)".localized()
        lblTotalInvoice.text = "Total Invoice".localized()
        lblChaletDetails.text = "Chalet details".localized()
        lblAgreement.text = "Agreement".localized()
     //   lblYouMustAgreeAllConditions.text = "You must Agree to all condtions to be able book".localized()
        
        if kCurrentLanguageCode == "ar"{
            lblBookingDetails.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblCheckIn.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblCheckOut.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblRentalPrice.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblTotalRewardsDiscount.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblTotalInvoice.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblChaletDetails.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblAgreement.font = UIFont(name: kFontAlmaraiRegular, size: 17)
          //  lblYouMustAgreeAllConditions.font = UIFont(name: kFontAlmaraiRegular, size: 14)


        }else {
            lblBookingDetails.font = UIFont(name: "Roboto-Medium", size: 17)
            lblCheckIn.font = UIFont(name: "Roboto-Regular", size: 17)
            lblCheckOut.font = UIFont(name: "Roboto-Regular", size: 17)
            lblRentalPrice.font = UIFont(name: "Roboto-Regular", size: 15)
            lblTotalRewardsDiscount.font = UIFont(name: "Roboto-Regular", size: 15)
            lblTotalInvoice.font = UIFont(name: "Roboto-Regular", size: 15)
            lblChaletDetails.font = UIFont(name: "Roboto-Medium", size: 17)
            lblAgreement.font = UIFont(name: "Roboto-Medium", size: 17)
         //   lblYouMustAgreeAllConditions.font = UIFont(name: "Roboto-Regular", size: 14)

        }
    }
    
    @objc func logoutUser() {
        appDelegate.logOut()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.checkBlockStatus()
    }
    
    override func viewDidLayoutSubviews() {
        self.viewChaletHeadingDetails.roundCorners(corners: [.topLeft,.topRight], radius: 10.0)
        self.viewBgCollectionView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10.0)
        self.viewCollectionIndex.roundCorners(corners: [.bottomRight], radius: 10.0)

    }

    //MARK:- SetUp NavigationBar
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        let notificationButton = UIBarButtonItem(image: Images.kIconNotification, style: .plain, target: self, action: #selector(backButtonTouched))
        //self.navigationItem.rightBarButtonItems = [notificationButton]
        self.navigationItem.title = "My Reservation"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    //MARK:- SetupUI
    func setupUI()  {
        //let width = kScreenWidth - 200
        
        let width = kScreenWidth - 30
        let columnLayout10 = ColumnFlowLayout.init(cellsPerRow: 1, minimumInteritemSpacing: 0.0, minimumLineSpacing: 0.0, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), cellHeight: 315, cellWidth: width,scrollDirec: .horizontal)
        collectionViewChalletImage?.collectionViewLayout = columnLayout10
        
        
        /*let columnLayout = ColumnFlowLayout.init(cellsPerRow: 1, minimumInteritemSpacing: 0.0, minimumLineSpacing: 0.0, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), cellHeight: 315, cellWidth: width,scrollDirec: .horizontal)
        collectionViewImageVideo?.collectionViewLayout = columnLayout*/
        
        let columnLayout1 = ColumnFlowLayout.init(cellsPerRow: 1, minimumInteritemSpacing: 0.0, minimumLineSpacing: 0.0, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), cellHeight: 23, cellWidth: width,scrollDirec: .vertical)
        collectionViewChalletDetails?.collectionViewLayout = columnLayout1
        
        let columnLayout2 = ColumnFlowLayout.init(cellsPerRow: 2, minimumInteritemSpacing: 0.0, minimumLineSpacing: 0.0, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), cellHeight: 35, cellWidth: width,scrollDirec: .vertical)
        collectionViewAgrrement?.collectionViewLayout = columnLayout2
        
    }
    
    //MARK:- setValuesToFields
    func setValuesToFields() {
        
        let dict = dictMyBooking.myBookingChalet_details?.first
        self.lblChaletId.text = "\(String(describing: dict!.chalet_id!))"
        self.lblChaletName.text = dict?.chalet_name!
        self.lblCheckOutDate.text = dictMyBooking.check_out!.appFormattedDate
        self.lblCheckOutTime.text = dictMyBooking.admincheck_out!
        self.lblCheckInDate.text = dictMyBooking.check_in!.appFormattedDate
        self.lblCheckInTime.text = dictMyBooking.admincheck_in!
        self.lblRent.text = "KD \(dictMyBooking.rent!)"
        self.lblDiscount.text = "KD \(dictMyBooking.reward_discount!)"
        self.lblTotalPaid.text = "KD \(dictMyBooking.total_paid!)"
        self.lblDeposit.text = "KD \(dictMyBooking.deposit!)"
        self.lblOfferDiscount.text = "KD \(dictMyBooking.offer_discount!)"
        
        self.lblCollectionIndex.text = "\(lblIndexValue)/\(String(describing: (dictMyBooking.myBookingChalet_details?.first?.chalet_details!.count)!))"
        
        let attrsWhatKindOfJob1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 14)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 14)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob3 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 14)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.8352941176, blue: 0, alpha: 1),NSAttributedString.Key.underlineStyle : NSUnderlineStyle.thick.rawValue] as [NSAttributedString.Key : Any]
         //   let attrsWhatKindOfJob4 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Italic", size: 20)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1),NSAttributedString.Key.underlineStyle : NSUnderlineStyle.thick.rawValue] as [NSAttributedString.Key : Any]
        //    let attrsWhatKindOfJob5 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 21)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1),NSAttributedString.Key.underlineStyle : NSUnderlineStyle.thick.rawValue] as [NSAttributedString.Key : Any]
            
        let attributedStringWhatKindOfJob1 = NSMutableAttributedString(string:"I have read and ".localized(), attributes:attrsWhatKindOfJob1)
        let attributedStringWhatKindOfJob2 = NSMutableAttributedString(string:"Agree ".localized(), attributes:attrsWhatKindOfJob2)
        let attributedStringWhatKindOfJob3 = NSMutableAttributedString(string:"to the ".localized(), attributes:attrsWhatKindOfJob1)
        let attributedStringWhatKindOfJob4 = NSMutableAttributedString(string:"terms".localized(), attributes:attrsWhatKindOfJob3)
        let attributedStringWhatKindOfJob5 = NSMutableAttributedString(string:" of service ".localized(), attributes:attrsWhatKindOfJob1)
        attributedStringWhatKindOfJob1.append(attributedStringWhatKindOfJob2)
        attributedStringWhatKindOfJob1.append(attributedStringWhatKindOfJob3)
        attributedStringWhatKindOfJob1.append(attributedStringWhatKindOfJob4)
        attributedStringWhatKindOfJob1.append(attributedStringWhatKindOfJob5)
        self.lblYouMustAgreeAllConditions.attributedText = attributedStringWhatKindOfJob1
    }
    
    //MARK:- ButtonActions
    //MARK:- Done button action keyboard
    @objc func doneButtonClicked() {
        self.view.endEditing(true)
    }
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPrevActionCollectioView(_ sender: Any) {
        
        if collectionIndex != 0 {
            collectionIndex = collectionIndex - 1
            lblIndexValue = lblIndexValue - 1
            self.lblCollectionIndex.text = "\(lblIndexValue)/\(String(describing: (dictMyBooking.myBookingChalet_details?.first?.chalet_upload!.count)!))"
            collectionViewChalletImage.scrollToItem(at: IndexPath(item: collectionIndex, section: 0), at: .centeredHorizontally, animated: true)
            
        }
        
    }
    @IBAction func btnForwardvActionCollectioView(_ sender: Any) {
        
        if collectionIndex != ((dictMyBooking.myBookingChalet_details?.first?.chalet_upload!.count)! - 1) {
            collectionIndex = collectionIndex + 1
            lblIndexValue = lblIndexValue + 1
            self.lblCollectionIndex.text = "\(lblIndexValue)/\(String(describing: (dictMyBooking.myBookingChalet_details?.first?.chalet_upload!.count)!))"
            collectionViewChalletImage.scrollToItem(at: IndexPath(item: collectionIndex, section: 0), at: .centeredHorizontally, animated: true)
            
        }
        
    }
    @IBAction func btnWhatsapAction(_ sender: UIButton) {
        /*let shareImage = self.tableView.screenshot()
       
        if shareImage != nil {
            
            let activityController = UIActivityViewController(activityItems: [shareImage!], applicationActivities: nil)
            activityController.excludedActivityTypes = [
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.openInIBooks,
                UIActivity.ActivityType(rawValue: "com.apple.reminders.RemindersEditorExtension"),
                UIActivity.ActivityType(rawValue: "com.apple.mobilenotes.SharingExtension"),
            ]
            
            present(activityController, animated: true, completion: nil)
        }*/
        let dict = dictMyBooking.myBookingChalet_details?.first
        var message = ""
        message = "http://sicsapp.com/Aby_chalet/details/\(dict?.chalet_id! ?? 0)"
        var queryCharSet = NSCharacterSet.urlQueryAllowed
        queryCharSet.remove(charactersIn: "+&")
        if let escapedString = message.addingPercentEncoding(withAllowedCharacters: queryCharSet) {
            if let whatsappURL = URL(string: "whatsapp://send?text=\(escapedString)") {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL, options: [: ], completionHandler: nil)
                } else {
                    debugPrint("please install WhatsApp")
                }
            }
        }
    }
    
    @IBAction func btnPlayVideoAction(_ sender: UIButton) {
        
        let urlStr =  dictMyBooking.myBookingChalet_details?.first?.chalet_upload![sender.tag].file_name!
           // self.showPlayerPopup(videourl: urlStr)
        let videoUrl = URL(string: urlStr!.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!
            let player = AVPlayer(url: videoUrl)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            let arrayHeight = arrayAgreements.count * 35
            return CGFloat(98 + arrayHeight)
            
        }else if indexPath.row == 3 {
            let arrayHeight = (dictMyBooking.myBookingChalet_details?.first?.chalet_details!.count)! * 23
            return CGFloat(57 + arrayHeight)
            
        }else{
            
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
}
extension BookingDetailTVC : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return (dictMyBooking.myBookingChalet_details?.first?.chalet_upload!.count)!
        }else if collectionView.tag ==  2 {
            return (dictMyBooking.myBookingChalet_details?.first?.chalet_details!.count)!
        }else if collectionView.tag ==  3 {
            return self.arrayAgreements.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag ==  1 {
            
            let arr = dictMyBooking.myBookingChalet_details?.first?.chalet_upload!
            if arr![indexPath.item].file_name!.contains(".jpg"){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewIMageVideoCVCell", for: indexPath) as! CollectionViewIMageVideoCVCell
                DispatchQueue.main.async {
                    cell.imgChaletImage.sd_setImage(with: URL(string: arr![indexPath.item].file_name!), placeholderImage: kPlaceHolderImage, options: .highPriority) { image, error, cache, url in
                        if image != nil {
                            cell.imgChaletImage.image = image
                        }else{
                            cell.imgChaletImage.image = kPlaceHolderImage
                        }
                    }
                }
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewVideoCVCell", for: indexPath) as! CollectionViewVideoCVCell
                cell.playVideo(videourl: arr![indexPath.item].file_name!, previewImage: "", thumb: arr![indexPath.item].thumbnail!)
                cell.btnPlay.tag = indexPath.item
                return cell
            }
            
        }else if collectionView.tag ==  2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewChaletDetailsCVCell", for: indexPath) as! CollectionViewChaletDetailsCVCell
            let arr = dictMyBooking.myBookingChalet_details?.first?.chalet_details!
            cell.setValuesToFields(dict: arr![indexPath.item])
            return cell
            
        }else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewAgreementCVCell", for: indexPath) as! CollectionViewAgreementCVCell
            let htmlStr = self.arrayAgreements[indexPath.item].agreement_content!
            if let htmlData = htmlStr.data(using: String.Encoding.unicode) {
                do {
                    cell.lblAgreement.attributedText = try NSAttributedString(data: htmlData,options: [.documentType:NSAttributedString.DocumentType.html],documentAttributes: nil)
                } catch let e as NSError {
                    print("Couldn't translate \(htmlStr): \(e.localizedDescription) ")
                    cell.lblAgreement.text = self.arrayAgreements[indexPath.item].agreement_content!
                }
            }
            return cell
            
        }
    }
}
extension BookingDetailTVC {
    func getAgreementsDetails() {
        ServiceManager.sharedInstance.postMethodAlamofire("api/agreements", dictionary: nil, withHud: true) { [self] (success, response, error) in
            self.checkNotificationCount()
            if success {
                if ((response as! NSDictionary)["status"] as! Bool) == true {
                    
                    let jsonBase = AgreementListBase(dictionary: response as! NSDictionary)
                    self.arrayAgreements = (jsonBase?.agreement)!
                    DispatchQueue.main.async {
                        self.collectionViewAgrrement.reloadData()
                        self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .none)
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Failed...!")
                }
            }else{
                showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Failed...!")
            }
        }
    }
    
    func checkNotificationCount() {
        if CAUser.currentUser.id != nil {
            ServiceManager.sharedInstance.postMethodAlamofire("api/notification_count", dictionary: ["userid": CAUser.currentUser.id!], withHud: true) { (success, response, error) in
                if success {
                    let messageCount = ((response as! NSDictionary)["message_count"] as! Int)
                    kNotificationCount = messageCount
                    let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
                    self.navigationItem.rightBarButtonItems = [notificationButton]
                }
            }
        }
    }
    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
}
