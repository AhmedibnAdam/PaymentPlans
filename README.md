# Refactor if/else  , switch twith Protocols Methhods


## Problem
You have a conditional that performs various actions depending on object type or properties.

* You do not have to read the following code ( it's a piece of shit ) *
```swift
{   
       if canBook == false{
            hideWhileCash()
            bookedStatus.text = "Locked"
            paymentTypeStack.isHidden = true
            process.isHidden = true
        }
        else {
            process.isHidden = false
            bookedStatus.text = "Unlocked"
        }   
        if status == true{
            turnPaymentOFF()
            if method == "cash"  {
                self.process.isHidden = false
                bookedStatus.text = "Unlocked"
                bookedStatus.textColor = .green
                self.chooseCash.isHidden = true
                self.chooseWallet.isHidden = false
                showWhileOnline()
                payment = "online"
                chooseCash.backgroundColor = .orange
                chooseCash.setTitleColor(.white, for: .normal)
            }
            else {
                self.process.isHidden = true
                bookedStatus.text = "Locked"
                hideWhileCash()
                self.chooseCash.isHidden = true
                self.chooseWallet.isHidden = false
                payment = method
                chooseWallet.backgroundColor = .orange
                chooseWallet.setTitleColor(.white, for: .normal)
            }
            
            
        }
        else {
            bookedStatus.text = "Unlocked"
            bookedStatus.textColor = .green
            self.process.isHidden = false
            
            if  method == "online"{
                self.chooseCash.isHidden = true
                self.chooseWallet.isHidden = false
                payment = "online"
                showWhileOnline()
                chooseWallet.backgroundColor = .orange
                chooseWallet.setTitleColor(.white, for: .normal)
            }
            else if method == "cash"  {
                self.chooseCash.isHidden = false
                self.chooseWallet.isHidden = true
                payment = "cash"
                hideWhileCash()
                chooseCash.backgroundColor = .orange
                chooseCash.setTitleColor(.white, for: .normal)
            }
            else {
                self.process.isHidden = false
                self.chooseCash.isHidden = false
                self.chooseWallet.isHidden = false
                payment = "online"
                showWhileOnline()
                chooseCash.backgroundColor = .orange
                chooseCash.setTitleColor(.white, for: .normal)
            }
            
        }
```

## Solution
Create subclasses or protocol matching the branches of the conditional. <br/>
In them, create a shared method and move code from the corresponding branch of the conditional to it. <br/>
Then replace the conditional with the relevant method call.  <br/>
The result is that the proper implementation will be attained via polymorphism depending on the object class. <br/>

* first what is protocol <br/>

A protocol (also called interface in other languages) defines a blueprint of properties, functions and other functionality a class needs to follow.

It is used to define a certain type of classes.

Sometimes classes evolve and only after a while their common functionality becomes apparent.

```swift

//MARK: - base classe or protocoles

 protocol PaymentActionViews {
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


//MARK: -   creat plans 

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



//MARK: - In view Controller 
 var planToSend: [String: Any]?
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




```

## Why Refactor ( Cost, Clarity and Maintainability )

This refactoring technique can help if your code contains operators performing various tasks that vary based on:

* Class of the object or interface that it implements or protocols that extends

* Value of an object’s field

* Result of calling one of an object’s methods

If a new object property or type appears, you will need to search for and add code in all similar conditionals. Thus the benefit of this technique is multiplied if there are multiple conditionals scattered throughout all of an object’s methods.


## Benefits

*  New behaviors can now be added in a incremental manner, without having to change a
set of methods of a single class containing all the behavior. A specific behavior can now
be understood independently from the other variations.
*  A new behavior represents its data independently from the other ones thus minimizing
the possible interference and increasing the understandability of the separated behaviors.
*  All behaviors now shares a common interface so helping in their understanding.
* This technique adheres to the Tell-Don’t-Ask principle: <br/>
instead of asking an object about its state and then performing actions based on this,<br/>
it’s much easier to simply tell the object what it needs to do and let it decide for itself how to do that.<br/>


* Removes duplicate code. You get rid of many almost identical conditionals.

* If you need to add a new execution variant, all you need to do is add a new subclass without touching the existing code (Open/Closed Principle).

## Open/Closed Principle

“Software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification.”



   
