//
//  PaymentPlans.swift
//  PloymerphismVSConditions
//
//  Created by Adam on 6/18/20.
//  Copyright © 2020 TestApp. All rights reserved.
//

import Foundation

extension Plans {
    func getPlan() -> [String : Any] {
        let params: [String : Any] = ["canBook": true , "method": "cash and wallet",  "status": true]
        return params
    }
}
class AllowAllPaymentPlan: Plans {
    var canBook: Bool = true
    var method: String = "cash and wallet"
    var status: Bool = true
    
    func getPlan() -> [String : Any] {
        let params: [String : Any] = ["canBook": canBook , "method": method,  "status": status]
        return params
    }
    
}

class BookingCashOnly: Plans {
    var canBook: Bool = true
    var method: String = "cash"
    var status: Bool = true
    
 func getPlan() -> [String : Any] {
        let params: [String : Any] = ["canBook": canBook , "method": method,  "status": status]
        return params
    }
}

class BookingOnlineOnly: Plans {
    var canBook: Bool = true
    var method: String = "online"
    var status: Bool = true
    
    func getPlan() -> [String : Any] {
        let params: [String : Any] = ["canBook": canBook , "method": method,  "status": status]
        return params
    }
}

class NotAllowedForBooking: Plans {
    var canBook: Bool = false
    var method: String = ""
    var status: Bool = false
    
   func getPlan() -> [String : Any] {
        let params: [String : Any] = ["canBook": canBook , "method": method,  "status": status]
        return params
    }
}


