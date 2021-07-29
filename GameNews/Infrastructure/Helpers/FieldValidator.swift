//
//  FormValidation.swift
//  GameNews
//
//  Created by Admin on 08.05.2021.
//

import Foundation

class FieldValidator {

    static func isPasswordValid(_ password: String) -> Bool {
    let passTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passTest.evaluate(with: password)
    }
}
