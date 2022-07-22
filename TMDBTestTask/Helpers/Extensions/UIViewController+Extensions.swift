//
//  UIViewController+Extensions.swift
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import UIKit

extension UIViewController {
    static var fromStoryboard: Self {
        let selfName = NSStringFromClass(self).components(separatedBy: ".").last!
        let storyboard = UIStoryboard(name: selfName, bundle: nil)
        let customViewController = storyboard.instantiateViewController(withIdentifier: selfName) as! Self
        
        return customViewController
    }
}
