//
//  Utilities .swift
//  GameNews
//
//  Created by Admin on 08.05.2021.
//

import Foundation
import UIKit

class ButtonsDesign {

        static func styleFilledButton(_ button: UIButton) {
            button.backgroundColor = UIColor.systemIndigo
            button.layer.cornerRadius = 25.0
            button.tintColor = UIColor.white
        }

        static func styleHollowButton(_ button: UIButton) {
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.systemIndigo.cgColor
            button.layer.cornerRadius = 25.0
            button.tintColor = UIColor.black
        }
}
