//
//  NetBankVerification.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/19/22.
//

import Foundation
import UIKit

class NetBankVerification{
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
            Validates the credit card number information
                -Parameters
                    -creditCardNumber: the cc number to check
                -Return
                    -Returns whether or not the cc number is valid or not
     */
    func validateAccountNumber(accountNum: String)-> Bool{
        if(accountNum.count != 16 || checkContainsOnlyDigits(stringToCheck: accountNum) == false){
            return false
        }
        return true
    }
    
    /**
            Validates the PIN number information
                -Parameters
                    -creditCardNumber: the cc number to check
                -Return
                    -Returns whether or not the cc number is valid or not
     */
    func validatePINNumber(pinNum: String)-> Bool{
        if(pinNum.count != 4 || checkContainsOnlyDigits(stringToCheck: pinNum) == false){
            return false
        }
        return true
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
    
    func validateNetBank(accountNumber : String, expMonth : String, expYear: String, pin: String, error:UILabel) -> Bool{
        if(validateAccountNumber(accountNum: accountNumber) == false || validateMonth(monthExpire: expMonth) == false || validateYear(yearExpire: expYear) == false || validatePINNumber(pinNum: pin) == false) {
            if(validateAccountNumber(accountNum: accountNumber) == false){
                error.text = "Invalid credit card number"
            }
            else if(validateMonth(monthExpire: expMonth) == false){
                error.text = "Invalid month"
            }
            else if(validateYear(yearExpire: expYear) == false){
                error.text = "Invalid year"
            } else if(validatePINNumber(pinNum: pin) == false){
                error.text = "Invalid PIN"
            }
            return false
        }
        return true
    }
    
}
