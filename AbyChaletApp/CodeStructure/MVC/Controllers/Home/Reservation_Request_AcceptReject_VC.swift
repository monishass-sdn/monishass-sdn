//
//  Reservation_Request_AcceptReject_VC.swift
//  AbyChaletApp
//
//  Created by Srishti on 18/04/22.
//

import UIKit
import AVFoundation

class Reservation_Request_AcceptReject_VC: UIViewController {
    
    @IBOutlet weak var reserv_reqTV: UITableView!
    @IBOutlet weak var lbl_RemainingRequestCount : UILabel!
    @IBOutlet weak var lbl_PaymentType : UILabel!
    
    
    
    var arrayReservationReq_List = [Reservation_Request_list]()
    var timer = Timer()
    let systemSoundID: SystemSoundID = 1000
    var reservationID : Int?


    override func viewDidLoad() {
        super.viewDidLoad()
        getOwnerReservationRequests()
        self.navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(refreshVC), name: NSNotification.Name(rawValue: NotificationNames.KUpdateTImer_End), object: nil)

        // Do any additional setup after loading the view.
    }
    
    @objc func refreshVC(){
        getOwnerReservationRequests()
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

extension Reservation_Request_AcceptReject_VC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if self.arrayReservationReq_List.count == 0{
                return 0
            }else{
                return 1
            }
        }else if section == 1{
            if self.arrayReservationReq_List.count == 0{
                return 0
            }else{
                return 1
            }
        }else{
            if self.arrayReservationReq_List.count == 0{
                return 0
            }else{
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "resreqTimerCell", for: indexPath) as! resreqTimerCell
            cell.setValuesToFields(dict:(self.arrayReservationReq_List.first!))
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationRequestTableViewCell", for: indexPath) as! ReservationRequestTableViewCell
            cell.setValuesToFields(dict:self.arrayReservationReq_List[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "resreqButtonsCell", for: indexPath) as! resreqButtonsCell
            cell.Btn_Accept.tag = indexPath.row
            cell.Btn_Reject.tag = indexPath.row
            cell.Btn_Accept.addTarget(self, action: #selector(acceptReservation), for: .touchUpInside)
            cell.Btn_Reject.addTarget(self, action: #selector(rejectReservation), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 120.0
        }else if indexPath.section == 1{
            return 550.0
        }else{
            return 125
        }
    }
    
    @objc func acceptReservation(_ sender: UIButton!){
        print("accept clicked")
        let dict = self.arrayReservationReq_List[sender.tag]
        print("reservation id = \(dict.reservation_id!)")
        self.acceptReservationReq(message: "Are you sure to Accept the reservation?".localized(), ownerstatus: 1, reservation_id:dict.reservation_id!)
        timer.invalidate()
    }
    @objc func rejectReservation(_ sender: UIButton!){
        print("reject clicked")
        let dict = self.arrayReservationReq_List[sender.tag]
        print("reservation id = \(dict.reservation_id!)")
        self.rejectReservationReq(message: "Are you sure to Reject the reservation?".localized(), ownerstatus: 2, reservation_id: dict.reservation_id!)
        timer.invalidate()
    }
    
    func acceptReservationReq(message:String,ownerstatus:Int,reservation_id:Int) {
        let alert = UIAlertController(title: "Confirmation".localized(), message: message.localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.acceptRejectReservationReq(ownerstatus: ownerstatus, reservationid: reservation_id)
            
        }))
        alert.addAction(UIAlertAction(title: "No".localized(), style: .default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func rejectReservationReq(message:String,ownerstatus:Int,reservation_id:Int) {
        let alert = UIAlertController(title: "Confirmation".localized(), message: message.localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.acceptRejectReservationReq(ownerstatus: ownerstatus, reservationid: reservation_id)
            
        }))
        alert.addAction(UIAlertAction(title: "No".localized(), style: .default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension Reservation_Request_AcceptReject_VC{
    func getOwnerReservationRequests() {
        ServiceManager.sharedInstance.postMethodAlamofire("api/requested_chalet", dictionary: ["ownerid":CAUser.currentUser.id!], withHud: false) { [self] (success, response, error) in
            if success {
                if response!["status"] as! Bool == true {
                    let jsonBase = Owner_Reservation_RequestBase(dictionary: response as! NSDictionary)
                    self.arrayReservationReq_List = (jsonBase?.reservation_list)!
                    if self.arrayReservationReq_List.count > 0{
                        print("play sound")
                      //  AudioServicesPlaySystemSound(systemSoundID)
                        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                            AudioServicesPlaySystemSound(systemSoundID)
                            //self.updateCounting()
                        })
                        self.lbl_RemainingRequestCount.text = jsonBase?.request_count!
                        self.reservationID = (jsonBase?.reservation_list?.first?.reservation_id)
                        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 17)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
                        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 17)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2156862745, green: 0.6235294118, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
                        let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 17)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9882352941, green: 0.7333333333, blue: 0.1411764706, alpha: 1)] as [NSAttributedString.Key : Any]
                        
                        let attributedString1 = NSMutableAttributedString(string:"New Reservation  ( ", attributes:attrs1)
                        if jsonBase?.reservation_list?.first?.payment_type == "Deposit"{
                            let attributedString2 = NSMutableAttributedString(string: "\(jsonBase?.reservation_list?.first?.payment_type ?? "nil")", attributes:attrs3)
                            let attributedString3 = NSMutableAttributedString(string:" )", attributes:attrs1)
                            attributedString1.append(attributedString2)
                            attributedString1.append(attributedString3)
                            self.lbl_PaymentType.attributedText = attributedString1
                        }else{
                            let attributedString2 = NSMutableAttributedString(string: "\(jsonBase?.reservation_list?.first?.payment_type ?? "nil")", attributes:attrs2)
                            let attributedString3 = NSMutableAttributedString(string:" )", attributes:attrs1)
                            attributedString1.append(attributedString2)
                            attributedString1.append(attributedString3)
                            self.lbl_PaymentType.attributedText = attributedString1
                        }
                        reserv_reqTV.reloadData()
                    }else{
                        print("stop sound")
                        timer.invalidate()
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "Message".localized(), msg: ((response! as! NSDictionary)["message"] as! String))
                }
            }else{
                showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Failed...!".localized())
            }
        }
    }
    
    func acceptRejectReservationReq(ownerstatus:Int,reservationid:Int)  {
        print("Owner status = \(ownerstatus)")
        print("Reservation id = \(reservationid)")
        ServiceManager.sharedInstance.postMethodAlamofire("api/owner-update-reservation-request", dictionary: ["owner_status":ownerstatus,"reserv_id":reservationid], withHud: true) { [self] (success, response, error) in
            print("response = \(response)")
            if success {
                if response!["status"] as! Bool == true {
                    let xxx = response!["booking_status"] as! String
                    print("xxx = \(xxx)")
                    let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "Reservation_Req_Approval_VC") as! Reservation_Req_Approval_VC
                    nextVC.acceprejectStatus = xxx
                    navigationController?.pushViewController(nextVC, animated: true)
                 
                    
                    
                    
                    
                  /*  DispatchQueue.main.async {
                        if CAUser.currentUser.userstatus == "owner" {
                            self.getOwnerReservationRequests()
                        }
                        self.reserv_reqTV.reloadData()
                    }*/
                }else{
                    showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Failed...!".localized())
                }
            }else{
                showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Failed...!".localized())
            }
        }
        
    }
}
