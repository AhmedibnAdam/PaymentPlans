//
//  PaymentMethods.swift
//  PloymerphismVSConditions
//
//  Created by Adam on 6/18/20.
//  Copyright © 2020 TestApp. All rights reserved.
//

import Foundation
enum PaymenyMethod {
       case cash
       case online
       
       var method : String? {
           switch self {
           case .cash:
               return "cash"
           case .online:
               return "online"
           }
       }
   }
