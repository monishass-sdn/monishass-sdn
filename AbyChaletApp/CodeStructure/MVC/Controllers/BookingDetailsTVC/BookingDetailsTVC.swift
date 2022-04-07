//
//  BookingDetailsTVC.swift
//  AbyChaletApp
//
//  Created by Visakh Srishti on 18/05/21.
//

import UIKit
import DHSmartScreenshot
import MapKit
import GoogleMaps
import MediaPlayer
import AVKit

class BookingDetailsTVC: UITableViewController {

    @IBOutlet weak var viewBgDeposit: UIView!
    @IBOutlet weak var lblCollectionIndex: UILabel!
    @IBOutlet weak var viewCollectionIndex: UIView!
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var viewBooked: UIView!

    @IBOutlet weak var viewBgCollectionView: UIView!
    @IBOutlet weak var collectionViewNew: UICollectionView!
    @IBOutlet weak var viewChalletName: UIView!
    @IBOutlet weak var lblSlNo: UILabel!
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var viewCheckOutIn: UIView!
    
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var viewBookingDetailsBottom: UIView!
    @IBOutlet weak var ViewBookingDetailsHeading: UIView!
    @IBOutlet weak var viewBookingDetails: UIView!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var viewLocationTop: UIView!
    
    @IBOutlet weak var lblReservationID: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblDeposit: UILabel!
    @IBOutlet weak var lblRewards: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblRemaining: UILabel!
    @IBOutlet weak var btnCopy: UIButton!
    
    @IBOutlet weak var lblDpRentalPrice: UILabel!
    @IBOutlet weak var lblDpDepositr: UILabel!
    @IBOutlet weak var lblDpRewards: UILabel!
    @IBOutlet weak var lblDpOffer: UILabel!
    @IBOutlet weak var lblDpTotalPaid: UILabel!
    @IBOutlet weak var lblDpRemaining: UILabel!
    @IBOutlet weak var lblDpRemainingDate: UILabel!
    @IBOutlet weak var lblBookStatus: UILabel!
    @IBOutlet weak var lblpleasePaytheremainingAmtbfr: UILabel!
    @IBOutlet weak var lblafterThisDateString: UILabel!
    @IBOutlet weak var lblBooking: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblCheckOut: UILabel!
    @IBOutlet weak var lblBookingDetail: UILabel!
//    @IBOutlet weak var lblRentalPrice: UILabel!
    @IBOutlet weak var lblDepositt: UILabel!
    @IBOutlet weak var lblRewardsDiscount: UILabel!
    @IBOutlet weak var lblOfferDiscount: UILabel!
    @IBOutlet weak var lblTotalPaid: UILabel!
    @IBOutlet weak var lblRemainingg: UILabel!
    @IBOutlet weak var lblBookingDetail1: UILabel!
    @IBOutlet weak var lblRentalPrice1: UILabel!
    @IBOutlet weak var lblDeposit1: UILabel!
    @IBOutlet weak var lblRewardsDisscount1: UILabel!
    @IBOutlet weak var lblOfferDiscount1: UILabel!
    @IBOutlet weak var lblRemaining1: UILabel!
    @IBOutlet weak var lblTotalPaid1: UILabel!
    
    @IBOutlet weak var imagePaidStatus: UIImageView!
    @IBOutlet weak var imagePaymentType : UIImageView!
    @IBOutlet weak var chalet_image : UIImageView!
    @IBOutlet weak var lblPaidStatusMsg: UILabel!
    @IBOutlet weak var lblPaymentType : UILabel!
    @IBOutlet weak var viewPaymentType : UIView!
    @IBOutlet weak var lbl_Checkin : UILabel!
    @IBOutlet weak var lbl_Checkout : UILabel!
    @IBOutlet weak var lbl_ChaletNumber : UILabel!
    @IBOutlet weak var lbl_ChaletName : UILabel!
    @IBOutlet weak var lbl_CheckoutTime : UILabel!
    @IBOutlet weak var lbl_CheckinTime : UILabel!
    
    @IBOutlet weak var dpimagePaymentType : UIImageView!
    @IBOutlet weak var dpchalet_image : UIImageView!
    @IBOutlet weak var dplblPaymentType : UILabel!
    @IBOutlet weak var dpviewPaymentType : UIView!
    @IBOutlet weak var dplbl_Checkin : UILabel!
    @IBOutlet weak var dplbl_Checkout : UILabel!
    @IBOutlet weak var dplbl_ChaletNumber : UILabel!
    @IBOutlet weak var dplbl_ChaletName : UILabel!
    @IBOutlet weak var dplbl_CheckoutTime : UILabel!
    @IBOutlet weak var dplbl_CheckinTime : UILabel!
    @IBOutlet weak var dplbl_rent : UILabel!
    @IBOutlet weak var lblReservation_id : UILabel!
    @IBOutlet weak var dplblReservation_id : UILabel!
    @IBOutlet weak var lblCity : UILabel!
    @IBOutlet weak var lblCountry : UILabel!
    @IBOutlet weak var lblchaletNumber : UILabel!
    @IBOutlet weak var lblStreetNo : UILabel!
    @IBOutlet weak var image_PaymentFailed : UIImageView!
    @IBOutlet weak var image_DpPaymentFailed : UIImageView!
    @IBOutlet weak var BtnGoTryit : UIButton!
    @IBOutlet weak var lbl_BtnMsg : UILabel!
    @IBOutlet weak var view_GoTryItBtn : UIView!

    var is_paymentFailed : Bool = false
    
    var selectedIndex : Int!
    var collectionIndex = 0
    var arrayUserDetails = [User_details]()
    var dictBookingDetails : Booking_details!
    let annotation = MKPointAnnotation()
    var lblIndexValue = 1
    var isDeposit : Bool = false
    var remainingAmtDate = ""
    var isFrom = ""
 //   var isDepSelected = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Is deposit Clicked Value From Success = \(isDeposit)")
        self.setUpNavigationBar()
        self.setupUI()
        if dictBookingDetails != nil {
            self.setValuesToFields()
            mapView.delegate = self
            //annotation.coordinate = CLLocationCoordinate2D(latitude: 46.41434149999999903002390055917203426361083984375, longitude: 29.311784599999999301189745892770588397979736328125)
            // mapView.setCenter(CLLocationCoordinate2D(latitude: 46.41434149999999903002390055917203426361083984375, longitude: 29.311784599999999301189745892770588397979736328125), animated: true)
            annotation.coordinate = CLLocationCoordinate2D(latitude: dictBookingDetails.longitude!, longitude: dictBookingDetails.latitude!)
            mapView.setCenter(CLLocationCoordinate2D(latitude: dictBookingDetails.longitude!, longitude: dictBookingDetails.latitude!), animated: true)
            mapView.addAnnotation(annotation)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /*DispatchQueue.main.async {
            
            let camera = GMSCameraPosition.camera(withLatitude: 8.446780, longitude: 77.056380, zoom: 6.0)
            let mapView = GMSMapView.map(withFrame: self.viewMap.frame, camera: camera)

           let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 8.446780, longitude: 77.056380))
           
           marker.map = mapView
           self.viewMap.addSubview(mapView)
        }*/
         //   super.viewWillAppear(animated)
          //  self.tabBarController?.tabBar.isHidden = true
    
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUser), name: NSNotification.Name(rawValue: NotificationNames.kBlockedUser), object: nil)
            appDelegate.checkBlockStatus()
        
        self.checkNotificationCount()
    }
    @objc func logoutUser() {
        appDelegate.logOut()
    }

    override func viewDidLayoutSubviews() {
        self.viewBookingDetails.roundCorners(corners: [.topLeft,.topRight], radius: 10.0)
        self.viewBookingDetails.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10.0)
        self.viewLocationTop.roundCorners(corners: [.topLeft,.topRight], radius: 10.0)
        self.ViewBookingDetailsHeading.roundCorners(corners: [.topLeft,.topRight], radius: 10.0)
        
    }
   
    //MARK:- SetUp NavigationBar
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let notificationButton = UIBarButtonItem(image: Images.kIconNotification, style: .plain, target: self, action: #selector(notificationButtonTouched))
        self.navigationItem.rightBarButtonItems = [notificationButton]
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "Thank You", attributes:[
                                                    NSAttributedString.Key.foregroundColor: UIColor.white,
                                                    NSAttributedString.Key.font: UIFont(name: "Arial Bold", size: 25)! ])
        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
    }
    //MARK:- SetupUI
    func setupUI()  {
        self.viewBooked.addCornerForView(cornerRadius: 10.0)
        self.viewLocation.addCornerForView(cornerRadius: 10.0)
        self.viewBookingDetails.addCornerForView(cornerRadius: 10.0)
        self.viewBgDeposit.addCornerForView(cornerRadius: 10.0)

        let width = kScreenWidth - 30
        let columnLayout10 = ColumnFlowLayout.init(cellsPerRow: 1, minimumInteritemSpacing: 0.0, minimumLineSpacing: 0.0, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), cellHeight: 315, cellWidth: width,scrollDirec: .horizontal)
        collectionViewNew?.collectionViewLayout = columnLayout10
    }
    
    
    @IBAction func myBooking_Tapped(_ sender:UIButton){
        if isFrom == "Booked Successfully"{
            let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "BookingsVC") as! BookingsVC
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else{
            // Action for Try Again
            let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "PackageListViewController") as! PackageListViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }


    }
    
    @IBAction func btnCallusWhatsApp(_ sender: UIButton) {
        if let phone = dictBookingDetails.default_callus {
            if phone != "" {
                let urlWhats = "whatsapp://app"
                if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) {
                    if let whatsappURL = URL(string: urlString) {
                        if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                            UIApplication.shared.open(NSURL(string: "whatsapp://send?phone=\(phone)")! as URL)
                        }else{
                            showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Please install whatsApp")
                        }
                    }
                }
            }
        }
    }
    
    //MARK:- SetValuesToFields
    func setValuesToFields() {
        if isFrom == "Booked Successfully" {
            //Payment Success Case
            if dictBookingDetails.total_paid == dictBookingDetails.rent{
                let paymentTypeImage : UIImage = UIImage(named: "full_paid_icon")!
                imagePaymentType.image = paymentTypeImage
                if self.is_paymentFailed == true{
                    let yourImage: UIImage = UIImage(named: "failed_icon")!
                    imagePaidStatus.image = yourImage
                    self.lblPaidStatusMsg.text = "Payment failed"
                }else{
                    let yourImage: UIImage = UIImage(named: "success_icon")!
                    imagePaidStatus.image = yourImage
                    self.lblPaidStatusMsg.text = "Your payment has been successfully"
                }
                self.lblPaymentType.text = "Paid"
                self.viewPaymentType.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.8549019608, blue: 0.2666666667, alpha: 1)
            }else{
                let paymentTypeImage : UIImage = UIImage(named: "deposit_paid_icon")!
                dpimagePaymentType.image = paymentTypeImage
                if self.is_paymentFailed == true{
                    let yourImage: UIImage = UIImage(named: "failed_icon")!
                    imagePaidStatus.image = yourImage
                    self.lblPaidStatusMsg.text = "Payment failed"
                }else{
                    let yourImage: UIImage = UIImage(named: "depositpaidIcon")!
                    imagePaidStatus.image = yourImage
                    self.lblPaidStatusMsg.text = "Your Deposit has been successfully"
                    lblDpRemainingDate.text = remainingAmtDate

                }
                self.dplblPaymentType.text = "Deposit"
                self.dpviewPaymentType.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.7333333333, blue: 0.1411764706, alpha: 1)


            }
            
            
        }else{
            //Payment Failure Case

            let navLabel = UILabel()
            let navTitle = NSMutableAttributedString(string: "We're Sorry !", attributes:[
                                                        NSAttributedString.Key.foregroundColor: UIColor.white,
                                                        NSAttributedString.Key.font: UIFont(name: "Arial Bold", size: 25)! ])
            navLabel.attributedText = navTitle
            self.navigationItem.titleView = navLabel
            self.lbl_BtnMsg.text = "Try Again"
            self.view_GoTryItBtn.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.1411764706, blue: 0.2784313725, alpha: 1)
            print(remainingAmtDate)
            if self.isDeposit == false{
                let paymentTypeImage : UIImage = UIImage(named: "cross_icon")!
                imagePaymentType.image = paymentTypeImage
                let yourImage: UIImage = UIImage(named: "failed_icon")!
                imagePaidStatus.image = yourImage
                self.lblPaidStatusMsg.text = "Payment failed"
                self.lblPaymentType.text = "Failed"
                self.viewPaymentType.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.1411764706, blue: 0.2784313725, alpha: 1)
            }else{
                let paymentTypeImage : UIImage = UIImage(named: "cross_icon")!
                dpimagePaymentType.image = paymentTypeImage
                    let yourImage: UIImage = UIImage(named: "failed_icon")!
                    imagePaidStatus.image = yourImage
                    self.lblPaidStatusMsg.text = "Payment failed"
                    lblDpRemainingDate.text = remainingAmtDate
               
                self.dplblPaymentType.text = "Failed"
                self.dpviewPaymentType.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.1411764706, blue: 0.2784313725, alpha: 1)


            }
        }

        let rent = dictBookingDetails.rent!
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Arial Bold", size: 28)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2156862745, green: 0.6235294118, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Arial", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedStringRent = NSMutableAttributedString(string:rent, attributes:attrs1)
        let attributedDiscountKD = NSMutableAttributedString(string:" KD", attributes:attrs2)
        attributedStringRent.append(attributedDiscountKD)
        self.lblRent.attributedText = attributedStringRent
        self.dplbl_rent.attributedText = attributedStringRent
        
        
        
        
        let attrsWhatKindOfJob1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 20)!, NSAttributedString.Key.foregroundColor : UIColor("#326277")] as [NSAttributedString.Key : Any]
         
         let attrsWhatKindOfJob2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 20)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attrsWhatKindOfJob3 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2156862745, green: 0.6235294118, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attrsWhatKindOfJob4 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.568627451, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attrsWhatKindOfJob5 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.8352941176, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
         
         let attributedStringKD1 = NSMutableAttributedString(string:"KD ", attributes:attrsWhatKindOfJob1)
         let attributedStringDeposit = NSMutableAttributedString(string:"\(dictBookingDetails.deposit!)", attributes:attrsWhatKindOfJob2)
        attributedStringKD1.append(attributedStringDeposit)
         self.lblDpDepositr.attributedText = attributedStringKD1
         self.lblDeposit.attributedText = attributedStringKD1
        
        let attributedStringKD2 = NSMutableAttributedString(string:"KD ", attributes:attrsWhatKindOfJob1)
        let atttributedStringRewards = NSMutableAttributedString(string: "\(dictBookingDetails.reward_discount!)",attributes: attrsWhatKindOfJob2)
        attributedStringKD2.append(atttributedStringRewards)
        self.lblRewards.attributedText = attributedStringKD2
        self.lblDpRewards.attributedText = attributedStringKD2
        
        let attributedStringKD3 = NSMutableAttributedString(string:"KD ", attributes:attrsWhatKindOfJob1)
        let atttributedStringOffer = NSMutableAttributedString(string: "\(dictBookingDetails.offer_discount!)",attributes: attrsWhatKindOfJob2)
        attributedStringKD3.append(atttributedStringOffer)
        self.lblOffer.attributedText = attributedStringKD3
        self.lblDpOffer.attributedText = attributedStringKD2
        
        let atttributedStringTotalPaid = NSMutableAttributedString(string: "KD \(dictBookingDetails.total_paid!)",attributes: attrsWhatKindOfJob3)
        self.lblTotal.attributedText = atttributedStringTotalPaid
        self.lblDpTotalPaid.attributedText = atttributedStringTotalPaid
        
        let atttributedStringRemaining = NSMutableAttributedString(string: "KD \(dictBookingDetails.remaining!)",attributes: attrsWhatKindOfJob4)
        let atttributedStringDpRemaining = NSMutableAttributedString(string: "KD \(dictBookingDetails.remaining!)",attributes: attrsWhatKindOfJob5)
        self.lblRemaining.attributedText = atttributedStringRemaining
        self.lblDpRemaining.attributedText = atttributedStringDpRemaining

        
        DispatchQueue.main.async {
            self.chalet_image.sd_setImage(with: URL(string: (self.dictBookingDetails.chalet_upload?.first?.file_name)!), placeholderImage: kPlaceHolderImage, options: .highPriority) { image, error, cache, url in
                if image != nil {
                    self.chalet_image.image = image
                }else{
                    self.chalet_image.image = kPlaceHolderImage
                }
            }
        }
        
        DispatchQueue.main.async {
            self.dpchalet_image.sd_setImage(with: URL(string: (self.dictBookingDetails.chalet_upload?.first?.file_name)!), placeholderImage: kPlaceHolderImage, options: .highPriority) { image, error, cache, url in
                if image != nil {
                    self.dpchalet_image.image = image
                }else{
                    self.dpchalet_image.image = kPlaceHolderImage
                }
            }
        }
        
        self.lbl_ChaletNumber.text = "\("No.".localized())\(dictBookingDetails.id ?? 0)"
        self.lbl_Checkin.text = dictBookingDetails.check_in!.appFormattedDate
        self.lbl_Checkout.text = dictBookingDetails.check_out?.appFormattedDate
        self.lbl_CheckinTime.text = dictBookingDetails.checkin_time!
        self.lbl_CheckoutTime.text = dictBookingDetails.checkout_time!
        self.lbl_ChaletName.text = dictBookingDetails.chalet_name!
        self.lblReservation_id.text = dictBookingDetails.reservation_id!
        self.lbl_ChaletNumber.text = "\("No.".localized())\(dictBookingDetails.id ?? 0)"
        self.dplbl_Checkin.text = dictBookingDetails.check_in!.appFormattedDate
        self.dplbl_Checkout.text = dictBookingDetails.check_out?.appFormattedDate
        self.dplbl_CheckinTime.text = dictBookingDetails.checkin_time!
        self.dplbl_CheckoutTime.text = dictBookingDetails.checkout_time!
        self.dplbl_ChaletName.text = dictBookingDetails.chalet_name!
        self.lblCity.text = dictBookingDetails.city
        self.lblStreetNo.text = dictBookingDetails.street_address
        self.lblchaletNumber.text = "Chalet No. \(dictBookingDetails.id!)"
        self.lblCountry.text = dictBookingDetails.country
      
      //  self.lblDeposit.text = "KD \(dictBookingDetails.deposit!)"
     //   self.lblRewards.text = "KD \(dictBookingDetails.reward_discount!)"
      //  self.lblOffer.text = "KD \(dictBookingDetails.offer_discount!)"
    //    self.lblTotal.text = "KD \(dictBookingDetails.total_paid!)"
     //   self.lblRemaining.text = "KD \(dictBookingDetails.remaining!)"
      //  self.lblDpDepositr.text = "KD \(dictBookingDetails.deposit!)"
      //  self.lblDpRewards.text = "KD \(dictBookingDetails.reward_discount!)"
      //  self.lblDpOffer.text = "KD \(dictBookingDetails.offer_discount!)"
     //   self.lblDpTotalPaid.text = "KD \(dictBookingDetails.total_paid!)"
     //   self.lblDpRemaining.text = "KD \(dictBookingDetails.remaining!)"
        self.dplblReservation_id.text = dictBookingDetails.reservation_id!

        
        

        
        lblpleasePaytheremainingAmtbfr.text = "Please pay the remaining amount before".localized()
        lblafterThisDateString.text = "After this date \n The Reservation is considered canceled And with \n the deposit confiscated And can be reserved by \n another customer You can pay at any time by \n going to:".localized()
        lblBooking.text = "Booking".localized()
        lblLocation.text = "Location".localized()
        lblBookingDetail1.text = "Booking Details".localized()
        lblDeposit1.text = "Deposit".localized()
        lblRewardsDisscount1.text = "Rewards (Discount)".localized()
        lblOfferDiscount1.text = "Offers (Discount)".localized()
        lblRemaining1.text = "Remaining".localized()
        lblTotalPaid1.text = "Total Invoice".localized()
        lblBookingDetail.text = "Booking Details".localized()
        lblDepositt.text = "Deposit".localized()
        lblRewardsDiscount.text = "Rewards (Discount)".localized()
        lblOfferDiscount.text = "Offers (Discount)".localized()
        lblTotalPaid.text = "Total Invoice".localized()
        lblRemainingg.text = "Remaining".localized()


        btnCopy.setTitle("Copy".localized(), for: .normal)
        
        if kCurrentLanguageCode == "ar"{
            lblpleasePaytheremainingAmtbfr.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblafterThisDateString.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblBooking.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblLocation.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblDeposit1.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblBookingDetail1.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblRewardsDisscount1.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblOfferDiscount1.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblRemaining1.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblBookingDetail.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblRewardsDiscount.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblOfferDiscount.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblRemainingg.font = UIFont(name: kFontAlmaraiRegular, size: 15)


        }else{
            lblpleasePaytheremainingAmtbfr.font = UIFont(name: "Roboto-Regular", size: 15)
            lblafterThisDateString.font = UIFont(name: "Roboto-Regular", size: 15)
            lblBooking.font = UIFont(name: "Roboto-Regular", size: 15)
          //  lblLocation.font = UIFont(name: "Roboto-Regular", size: 15)
            lblDeposit1.font = UIFont(name: "Roboto-Regular", size: 15)
            lblBookingDetail1.font = UIFont(name: "Roboto-Regular", size: 17)
            lblRewardsDisscount1.font = UIFont(name: "Roboto-Regular", size: 15)
            lblOfferDiscount1.font = UIFont(name: "Roboto-Regular", size: 15)
            lblRemaining1.font = UIFont(name: "Roboto-Regular", size: 15)
            lblTotalPaid1.font = UIFont(name: "Roboto-Regular", size: 15)
            
            lblBookingDetail.font = UIFont(name: "Roboto-Regular", size: 17)
          //  lblDeposit.font = UIFont(name: "Roboto-Regular", size: 15)
            lblRewardsDiscount.font = UIFont(name: "Roboto-Regular", size: 15)
            lblOfferDiscount.font = UIFont(name: "Roboto-Regular", size: 15)
            lblTotalPaid.font = UIFont(name: "Roboto-Regular", size: 15)
        }
      /*
       let attrsWhatKindOfJob1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 16)!, NSAttributedString.Key.foregroundColor : UIColor("#1E4355")] as [NSAttributedString.Key : Any]
        
        let attrsWhatKindOfJob2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedStringEarn1 = NSMutableAttributedString(string:"\(dictBookingDetails.rent!)", attributes:attrsWhatKindOfJob2)
        let attributedStringEarn2 = NSMutableAttributedString(string:"KD ", attributes:attrsWhatKindOfJob1)
        attributedStringEarn1.append(attributedStringEarn1)
        attributedStringEarn1.append(attributedStringEarn2)
        self.lblDpRentalPrice.attributedText = attributedStringEarn1
*/
        
        /*let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd hh:mm a"
        let checkinDate = dateFormater.date(from: "\(String(describing: dictBookingDetails.check_in!)) \(String(describing: dictBookingDetails.checkin_time!))")
        //let difference = Calendar.current.dateComponents([.hour], from: Date(), to: checkinDate!)
        let remaingTimeToPay = Int(arrayBookingDetails!.remaining_amt_pay!)
        
        let wedDate = Calendar.current.date( byAdding: .hour,value: -remaingTimeToPay!,to: checkinDate!)
        dateFormater.dateFormat = "dd/MM/yyyy ( hh:mm a )"*/
        
     //   self.lblDpRemainingDate.text = remainingAmtDate
     //   if isFrom == "Booked Successfully" {
      /*      self.lblBookStatus.text = "Booked Successfully".localized()
        }else{
            self.lblBookStatus.text = "Payment failed"
        }*/
        
    }

    //MARK:- ButtonActions
    //MARK:- Done button action keyboard
    @objc func doneButtonClicked() {
        self.view.endEditing(true)
    }
    @objc func notificationButtonTouched()  {
        
        
    }
    /*
    @IBAction func btnShareToWhatsapAction(_ sender: Any) {
        
        //var documentInteractionController = UIDocumentInteractionController()
        let shareImage = self.tableView.screenshot()
        //let urlWhats = "whatsapp://app"
        /*if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    if let image = shareImage {
                        if let imageData = image.jpegData(compressionQuality: 1.0) {
                            let tempFile = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.wai")
                            do {
                                try imageData.write(to: tempFile, options: .atomic)
                                documentInteractionController = UIDocumentInteractionController(url: tempFile)
                                documentInteractionController.uti = "net.whatsapp.image"
                                documentInteractionController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
                            } catch {
                                print(error)
                            }
                        }
                    }
                } else {
                    print("Cannot open whatsapp")
                }
            }
        }*/
        if shareImage != nil {
            let activityController = UIActivityViewController(activityItems: [shareImage!], applicationActivities: nil)
            //UIActivityViewController(activityItems: (shareImage), applicationActivities: nil)
            
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
        }
    }
 */
  /*
    @IBAction func btnPrevActionCollectioView(_ sender: Any) {
        
        if collectionIndex != 0 {
            collectionIndex = collectionIndex - 1
            lblIndexValue = lblIndexValue - 1
            self.lblCollectionIndex.text = "\(lblIndexValue)/\(String(describing: (dictBookingDetails.chalet_upload!.count)))"
            collectionViewNew.scrollToItem(at: IndexPath(item: collectionIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
    @IBAction func btnForwardvActionCollectioView(_ sender: Any) {
        
        if collectionIndex != (dictBookingDetails.chalet_upload!.count - 1) {
            collectionIndex = collectionIndex + 1
            lblIndexValue = lblIndexValue + 1
            self.lblCollectionIndex.text = "\(lblIndexValue)/\(String(describing: (dictBookingDetails.chalet_upload!.count)))"
            collectionViewNew.scrollToItem(at: IndexPath(item: collectionIndex, section: 0), at: .centeredHorizontally, animated: true)
            
        }
        
    }*/
    @IBAction func btnCopyAction(_ sender: UIButton) {
        
        sender.setTitle("Copied".localized(), for: .normal)
        UIPasteboard.general.string = dictBookingDetails.location!
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(didTimerComplete), userInfo: nil, repeats: false)
        
    }
    
    @objc private func didTimerComplete() {
        btnCopy.setTitle("Copy".localized(), for: .normal)
    }
    
    @IBAction func btnClickMapAction(_ sender: UIButton) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(dictBookingDetails.longitude!),\(dictBookingDetails.latitude!)&zoom=14&views=traffic&q=\(dictBookingDetails.longitude!),\(dictBookingDetails.latitude!)")!, options: [:], completionHandler: nil)
        } else {
            print("Can't use comgooglemaps://")
        }
    }
    
    @IBAction func btnPlayVideoAction(_ sender: UIButton) {
        
        let urlStr =  dictBookingDetails.chalet_upload![sender.tag].file_name!
           // self.showPlayerPopup(videourl: urlStr)
        let videoUrl = URL(string: urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!
            let player = AVPlayer(url: videoUrl)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isFrom == "Booked Successfully"{
            if indexPath.row == 4{
                return 0
            }
            if dictBookingDetails.total_paid != dictBookingDetails.rent{
            if indexPath.row == 1{
                return 0
            }else if indexPath.row == 2{
                return 671
            }
        }else{
            if indexPath.row == 1{
                return 411
            }else if indexPath.row == 2{
                return 0

            }
        }
        }else{
           // if isFrom != "Booked Successfully"{
               // if dictBookingDetails.total_paid != dictBookingDetails.rent{
                if self.isDeposit == true{
                if indexPath.row == 1{
                    return 0
                }else if indexPath.row == 2{
                    return 671
                }
            }else{
                if indexPath.row == 1{
                    return 411
                }else if indexPath.row == 2{
                    return 0

                }
            }
                
            if indexPath.row == 4{
                    return 60
                }
            }
      //  }
      //  if isDeposit == true{
    /*        if dictBookingDetails.total_paid != dictBookingDetails.rent{
            if indexPath.row == 1{
                return 0
            }else if indexPath.row == 2{
                return 671
            }
        }else{
            if indexPath.row == 1{
                return 411
            }else if indexPath.row == 2{
                return 0

            }
        }
      */
      //  if self.is_paymentFailed == true{
    /*    if isFrom != "Booked Successfully"{
           // if dictBookingDetails.total_paid != dictBookingDetails.rent{
            if self.isDeposit == true{
            if indexPath.row == 1{
                return 0
            }else if indexPath.row == 2{
                return 671
            }
        }else{
            if indexPath.row == 1{
                return 411
            }else if indexPath.row == 2{
                return 0

            }
        }
            
        if indexPath.row == 4{
                return 60
            }
        }
        */
      //  else{
       //     if indexPath.row == 4{
         //       return 0
         //   }
       // }

        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
}
/*
extension BookingDetailsTVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dictBookingDetails.chalet_upload?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let arr = dictBookingDetails.chalet_upload!
        if arr[indexPath.item].file_name!.contains(".jpg"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewIMageVideoCVCell", for: indexPath) as! CollectionViewIMageVideoCVCell
            DispatchQueue.main.async {
                cell.imgChaletImage.sd_setImage(with: URL(string: arr[indexPath.item].file_name!), placeholderImage: kPlaceHolderImage, options: .highPriority) { image, error, cache, url in
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
            /*cell.imgChaletImage.sd_setImage(with: URL(string: arr[indexPath.item].file_name!), placeholderImage: kPlaceHolderImage, options: .highPriority) { image, error, cache, url in
             if image != nil {
             cell.imgChaletImage.image = image
             }else{
             cell.imgChaletImage.image = kPlaceHolderImage
             }
             }*/
            
            cell.playVideo(videourl: arr[indexPath.item].file_name!, previewImage: "", thumb: arr[indexPath.item].thumbnail!)
            cell.btnPlay.tag = indexPath.item
            return cell
        }
    }
}*/
extension BookingDetailsTVC : MKMapViewDelegate {
    
    private func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil;
        }else{
            let pinIdent = "Pin";
            var pinView: MKPinAnnotationView;
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdent) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation;
                pinView = dequeuedView;
            }else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
                
            }
            return pinView;
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(String(describing: view.annotation!.coordinate.latitude)),\(String(describing: view.annotation!.coordinate.longitude))&zoom=14&views=traffic&q=\(String(describing: view.annotation!.coordinate.latitude)),\(String(describing: view.annotation!.coordinate.longitude))")!, options: [:], completionHandler: nil)
        } else {
            print("Can't use comgooglemaps://")
        }
    }
    
    func checkNotificationCount() {
        if CAUser.currentUser.id != nil {
            ServiceManager.sharedInstance.postMethodAlamofire("api/notification_count", dictionary: ["userid": CAUser.currentUser.id!], withHud: true) { (success, response, error) in
                if success {
                    guard let messageCount = ((response as! NSDictionary)["message_count"] as? Int) else {return}
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
