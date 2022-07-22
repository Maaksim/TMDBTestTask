//
//  UIView+Extensions.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import UIKit

extension UIView {
    class var identifier: String {
        return String(describing: self)
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self),
                                        owner: nil,
                                        options: nil)![0] as! T
    }
}
