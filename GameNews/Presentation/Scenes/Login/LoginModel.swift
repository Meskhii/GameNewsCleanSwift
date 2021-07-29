//
//  LoginModel.swift
//  GameNews
//
//  Created by Admin on 17.05.2021.
//

import Foundation

enum Login {
    struct Request {
        var email: String?
        var password: String?
    }

    struct Response {
      var success: Bool
    }

    struct ViewModel {
      var success: Bool
    }
}
