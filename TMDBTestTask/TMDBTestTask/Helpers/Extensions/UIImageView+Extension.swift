//
//  UIImageView+Extension.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 21.07.2022.
//

import Foundation
import SDWebImage

// Using extension give us advantage of replacing the library with other ones with ease.
protocol ImageLoadable {
    func setImage(from url: URL, completion: ((UIImage) -> Void)?)
}

extension ImageLoadable where Self: UIImageView {
    func setImage(from url: URL, completion: ((UIImage) -> Void)? = nil) {
        self.sd_setImage(with: url, completed: nil)
    }
        
    func setImage(from url: URL, placeholder: UIImage) {
        self.sd_setImage(with: url, placeholderImage: placeholder)
    }
}

extension UIImageView: ImageLoadable {}
