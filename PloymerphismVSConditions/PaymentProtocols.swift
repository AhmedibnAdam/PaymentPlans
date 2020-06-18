//
//  PaymentProtocols.swift
//  PloymerphismVSConditions
//
//  Created by Adam on 6/18/20.
//  Copyright © 2020 TestApp. All rights reserved.
//

import Foundation
import UIKit

@objc protocol PaymentActionViews {
    @objc optional func turnPaymentOFF()
    @objc optional  func turnPaymentON()
    @objc optional  func hideView(view: UIView)
    @objc optional  func showView(view: UIView)
    @objc optional  func setSelectButton(button: UIButton)
    @objc optional  func deSelectButton(button: UIButton)
    @objc optional  func hideForCash()
    @objc optional  func showForOmline()
    @objc optional  func showOnlineOnly()
    @objc optional  func showCashOnly()
}

 protocol Plans {
    var canBook: Bool {get}
    var method: String {get}
    var status:Bool{get}
    func getPlan() -> [String:Any] 
}
