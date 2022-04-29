//
//  Reservation_Req_Approval_VC.swift
//  AbyChaletApp
//
//  Created by Srishti on 19/04/22.
//

import UIKit

class Reservation_Req_Approval_VC: UIViewController {

    @IBOutlet weak var image_AcceptReject : UIImageView!
    @IBOutlet weak var lbl_acceptRejectStatus : UILabel!
    @IBOutlet weak var lbl_lbl_acceptRejectStatus2: UILabel!
    @IBOutlet weak var lbl_Req_Count : UILabel!
    @IBOutlet weak var view_Bottom : UIView!
    @IBOutlet weak var height_BottomView : NSLayoutConstraint!
    
    var acceprejectStatus = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkReserv_Req_Count()
        setUpNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupUI(){
        if acceprejectStatus == "accepted"{
            lbl_acceptRejectStatus.text = "Reservation has been Accepted"
            lbl_lbl_acceptRejectStatus2.text = "The payment link has been sent to the customer"
            let yourImage: UIImage = UIImage(named: "registrationsuccessiconNew")!
            image_AcceptReject.image = yourImage
        }else{
            lbl_acceptRejectStatus.text = "Reservation has been Rejected"
            lbl_lbl_acceptRejectStatus2.text = "The customer was informed that you Rejected"
            let yourImage: UIImage = UIImage(named: "failed_icon")!
            image_AcceptReject.image = yourImage
        }
    }
    
    func setUpNavigationBar() {
       // self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        if acceprejectStatus == "accepted"{
            self.navigationItem.title = "Accepted".localized()
        }else{
            self.navigationItem.title = "Rejected".localized()
        }

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    
    @IBAction func tapped_MoreReservationBtn(_ sender:UIButton){
        print("clicked on button")
        self.navigationController?.popToRootViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Reservation_Req_Approval_VC{
    func checkReserv_Req_Count() {
        ServiceManager.sharedInstance.postMethodAlamofire("api/requested_chalet", dictionary: ["ownerid":CAUser.currentUser.id!], withHud: false) { [self] (success, response, error) in
            if success {
                if response!["status"] as! Bool == true {
                    let xxx = response!["request_count"] as! String
                    if xxx == "0"{
                      //  self.height_BottomView.constant = 0.0
                        self.view_Bottom.isHidden = true
                        self.tabBarController?.tabBar.isHidden = false
                    }else{
                        self.lbl_Req_Count.text = xxx
                    }

                }else{
                    showDefaultAlert(viewController: self, title: "Message".localized(), msg: ((response! as! NSDictionary)["message"] as! String))
                }
            }else{
                showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Failed...!".localized())
            }
        }
    }
}
