//
//  PaymentVerification.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/19/22.
//

import Foundation
import UIKit

class PaymentVerification{
    /**
            Validates the month of credit card information
                -Parameters
                    -monthExpire: the month to check
                -Return
                    -Returns whether or not the month is valid or not
     */
    func validateMonth(monthExpire: String) -> Bool{
        if(monthExpire.count != 2 || Int(monthExpire)! > 12 || Int(monthExpire)! < 1 || checkContainsOnlyDigits(stringToCheck: monthExpire) == false){
            return false
        }
        return true
    }
    
    /**
            Validates the year of credit card information
                -Parameters
                    -yearExpire: the month to check
                -Return
                    -Returns whether or not the year is valid or not
     */
    func validateYear(yearExpire: String) -> Bool{
        if(yearExpire.count != 2 || Int(yearExpire)! < 22 || Int(yearExpire)! < 1 || checkContainsOnlyDigits(stringToCheck: yearExpire) == false){
            return false
        }
        return true
    }
    
    /**
            Validates the CVC of credit card information
                -Parameters
                    -cvc: the cvc to check
                -Return
                    -Returns whether or not the cvc is valid or not
     */
    func validateCVC(cvc: String) -> Bool{
        if(cvc.count != 3 || checkContainsOnlyDigits(stringToCheck: cvc) == false){
            return false
        }
        return true
    }
    
    /**
            Validates the credit card number information
                -Parameters
                    -creditCardNumber: the cc number to check
                -Return
                    -Returns whether or not the cc number is valid or not
     */
    func validateCCNumber(creditCardNumber: String)-> Bool{
        if(creditCardNumber.count != 16 || checkContainsOnlyDigits(stringToCheck: creditCardNumber) == false){
            return false
        }
        return true
    }
    
    
    func checkExpiry(inputDate: String){
        
    }
    
    /**
            Checks
                -Parameters
                    -cvc: the cvc to check
                -Return
                    -Returns whether or not the cvc is valid or not
     */
    func checkContainsOnlyDigits(stringToCheck: String) -> Bool{
        let numbersSet = CharacterSet(charactersIn: "0123456789")

        let textCharacterSet = CharacterSet(charactersIn: stringToCheck)

        if textCharacterSet.isSubset(of: numbersSet) {
            print("text only contains numbers 0-9")
            return true
        } else {
            print(stringToCheck, " contains invalid credit information")
            return false
        }
    }
    
    func validateCreditCard(creditCard : String, cvc :String, expMonth : String, expYear: String, error:UILabel) -> Bool{
        if(validateCCNumber(creditCardNumber: creditCard) == false || validateCVC(cvc: cvc) == false) || validateMonth(monthExpire: expMonth) == false || validateYear(yearExpire: expYear) == false
        {
            if(validateCCNumber(creditCardNumber: creditCard) == false){
                print("cc number")
                error.text = "Invalid credit card number"
            }
            else if(validateMonth(monthExpire: expMonth) == false){
                print("month bad")
                error.text = "Invalid month"
            }
            else if(validateYear(yearExpire: expYear) == false){
                print("year bad")
                error.text = "Invalid year"
            }
            else if(validateCVC(cvc: cvc) == false){
                print("cvc bad")
                error.text = "Invalid cvc"
            }
            return false
        }
        return true
    }
    
}
