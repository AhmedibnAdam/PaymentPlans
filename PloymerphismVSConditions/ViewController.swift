//
//  ViewController.swift
//  PloymerphismVSConditions
//
//  Created by Adam on 6/17/20.
//  Copyright © 2020 TestApp. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
  
    @IBOutlet weak var paymentTypeStack: UIStackView!
    @IBOutlet weak var creditCardButton: UIButton!
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var masterCardView: UIView!
    @IBOutlet weak var prcessButton: UIButton!
    @IBOutlet weak var ThanksLbl: UILabel!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var canPayToggle: UISwitch!
    
//    Payment plans
    var all = AllowAllPaymentPlan()
    var notAlloed = NotAllowedForBooking()
    var cashOnly = BookingCashOnly()
    var onlineOnly = BookingOnlineOnly()
    
    // Payment Methods
    var method1 = PaymenyMethod.cash
    var method2 = PaymenyMethod.online
    
    var planToSend: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        turnPaymentOFF()
        paymentBusinessLogic()
        
    }
    
    @IBAction func canPay(_ sender: UISwitch) {
        sender.isOn  ? turnPaymentON() : turnPaymentOFF()
        planToSend = all.getPlan()
       
    }
    
    @IBAction func onlinePayment(_ sender: UIButton) {
        setSelectButton(button: sender)
        deSelectButton(button: cashButton)
        showForOmline()
        planToSend = onlineOnly.getPlan()
    }
    
    @IBAction func cashPayment(_ sender: UIButton) {
        setSelectButton(button: sender)
        deSelectButton(button: onlineButton)
        hideForCash()
        planToSend = cashOnly.getPlan()
    }
    
    func paymentBusinessLogic(){
        
        // get from Back End the plan
  
    }
    
    @IBAction func processSndPaymentAction(_ sender: UIButton) {
        guard let plan = planToSend else {
            return
        }
         print(plan)
    }
    
}

extension ViewController: PaymentActionViews {

    func turnPaymentOFF(){
        canPayToggle.isOn = false
        hideView(view: paymentTypeStack)
        hideView(view: creditCardButton)
        hideView(view: applePayButton)
        hideView(view: masterCardView)
        hideView(view: prcessButton)
        showView(view: ThanksLbl)
    }
    
    func turnPaymentON(){
        canPayToggle.isOn = true
        showView(view: paymentTypeStack)
        showView(view: creditCardButton)
        showView(view: applePayButton)
        showView(view: masterCardView)
        showView(view: prcessButton)
        hideView(view: ThanksLbl)
    }
    
    func hideView(view: UIView){
        view.isHidden = true
    }
    func showView(view: UIView){
        view.isHidden = false
    }
    
    func setSelectButton(button: UIButton){
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
    }
    func deSelectButton(button: UIButton){
        button.backgroundColor = .white
        button.setTitleColor(.gray, for: .normal)
    }
    
    func hideForCash(){
        hideView(view: creditCardButton)
        hideView(view: applePayButton)
        hideView(view: masterCardView)
        hideView(view: ThanksLbl)
    }
    
    func showForOmline(){
        turnPaymentON()
    }
    func showOnlineOnly(){
        showForOmline()
        hideView(view: cashButton)
    }
    func showCashOnly(){
        hideForCash()
        hideView(view: onlineButton)
    }
}
