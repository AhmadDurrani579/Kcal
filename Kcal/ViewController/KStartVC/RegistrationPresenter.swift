//
//  RegistrationPresenter.swift
//  GARAGE SALE
//
//  Created by Ahmed Durrani on 24/01/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

protocol RegistrationDelegate{
    func showProgress()
    func hideProgress()
    func registrationDidSucceed()
    func registrationDidFailed(message: String)
}
class RegistrationPresenter  {
    var delegate: RegistrationDelegate
    
    init(delegate: RegistrationDelegate) {
        self.delegate = delegate
    }
    
    func signIn(email: String, password: String){
        if email.isEmpty {
            print("omayib")
            self.delegate.registrationDidFailed(message: kValidationEmailEmpty)
        } else if !(UtilityHelper.isValidEmailAddress(email)) {
            self.delegate.registrationDidFailed(message: kValidationEmailInvalidInput)

        } else if password.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationPasswordEmpty)
        } else if password.count < kPasswordRequiredLength {
            self.delegate.registrationDidFailed(message: KValidationPassword)
        } else {
            self.delegate.registrationDidSucceed()
        }
        
        
    }
    
    func registerValidation(fullName : String , email: String, phone : String ,  password: String , confrimPasswrod : String){
        
        if fullName.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationNameInput)
        }
        
        else if !isValidName(name: fullName) {
            self.delegate.registrationDidFailed(message: kValidationNameInputCharacter)
        }
        else if email.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationEmailEmpty)

        }
        else if !(UtilityHelper.isValidEmailAddress(email)) {
            self.delegate.registrationDidFailed(message: kValidationEmailInvalidInput)
            
        } else if phone.isEmpty  {
            self.delegate.registrationDidFailed(message: kValidationPhoneNumEmpty)

        }
        
        else if password.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationPasswordEmpty)
        } else if password.count < kPasswordRequiredLength {
            self.delegate.registrationDidFailed(message: KValidationPassword)
        } else if confrimPasswrod.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationConfirmPasswordEmpty)
        } else if confrimPasswrod.count < kPasswordRequiredLength {
            self.delegate.registrationDidFailed(message: KValidationPassword)
        } else if password != confrimPasswrod {
            self.delegate.registrationDidFailed(message: KPasswordMismatch)
        }
        else {
            self.delegate.registrationDidSucceed()
        }
        
        
    }

    func registerCardInfo(cardNum : String , cardHolderName: String, expiryDate : String ,  cvvNum: String){
        
        if cardNum.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationCardNumInput)
        }
        else if cardHolderName.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationCardHolderNameInput)

        }
        else if !isValidName(name: cardHolderName) {
            self.delegate.registrationDidFailed(message: kValidationCardHolderNameInputCharacter)
        }
        else if expiryDate.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationCardExpiryDate)
            
        }
        else if cvvNum.isEmpty  {
            self.delegate.registrationDidFailed(message: kValidationCardCcvNum)
            
        }
        else {
            self.delegate.registrationDidSucceed()
        }
        
        
    }

    
    func isValidName(name: String) -> Bool {
        let decimalCharacters = NSCharacterSet.decimalDigits
        let decimalRange = name.rangeOfCharacter(from: decimalCharacters, options: String.CompareOptions.numeric, range: nil)
        
        if decimalRange != nil {
            return false
        }
        return true
    }
    func forgotPasswordValidation(email: String ){
        if email.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationEmailEmpty)
        } else if !(UtilityHelper.isValidEmailAddress(email)) {
            self.delegate.registrationDidFailed(message: kValidationEmailInvalidInput)
        } else {
            self.delegate.registrationDidSucceed()
            
        }
    }
    
    func validationOnChangePassword(password: String , confirmPass : String){
        if password.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationPasswordEmpty)
        }
        else if confirmPass.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationConfirmPasswordEmpty)
        } else if password != confirmPass  {
            self.delegate.registrationDidFailed(message: KPasswordMismatch)

        } else {
            self.delegate.registrationDidSucceed()

        }
    }
    
    func validationForUploadingIdentification(idNum: String , isImageSelect : Bool){
        if idNum.isEmpty {
            self.delegate.registrationDidFailed(message: KIDNumberValidat)
        }
        else if isImageSelect == false {
            self.delegate.registrationDidFailed(message: KIMAGeSELECT)
        }
      
        else {
            self.delegate.registrationDidSucceed()
        }
    }
    
}

//extension String {
//    var isPhoneNumber: Bool {
//        do {
//            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
//            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.characters.count))
//            if let res = matches.first {
//                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.characters.count
//            } else {
//                return false
//            }
//        } catch {
//            return false
//        }
//    }
//}
