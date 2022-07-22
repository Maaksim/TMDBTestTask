//
//  MoveTableViewCell.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 20.07.2022.
//

import UIKit

class MoveTableViewCell: UITableViewCell {
    //MARK: - @IBOutlets
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var releaseTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        resetContent()
    }
    
    private func resetContent() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        releaseTitleLabel.text = nil
        movieImage.image = nil
    }
    
    func display(model: MovieInfoEntity?) {
        titleLabel.text = model?.title
        descriptionLabel.text = model?.description
        releaseTitleLabel.text = model?.releaseDate
        
        if let url = URL(string: model?.posterPath ?? "") {
            movieImage.setImage(from: url)
        }
    }
}
