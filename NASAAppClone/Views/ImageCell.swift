//
//  ImageCell.swift
//  NASAAppClone
//
//  Created by Kirti S on 2/21/23.
//

import UIKit
import Kingfisher

/// Image Cell class to hold a collection view cell with an image
class ImageCell: UICollectionViewCell {
    
    static let identifier = "ImageCell"
    
    private let imageImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageImageView)
        
        NSLayoutConstraint.activate([
            imageImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageImageView.widthAnchor.constraint(equalToConstant: contentView.bounds.width - 20),
            imageImageView.heightAnchor.constraint(equalToConstant: contentView.bounds.height - 40),
            imageImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
    }
    
    /// Sets up a collection view cell with a Image object
    /// - Parameter imageData: An object of type Image, that represents a single image with a title, a date, an explanation and an url
    ///  Fetches image url from image Data and uses the KingFisher library to set and cache the given image
    public func setUpSingleChatCellWith(imageData: Image) {
        let url = URL(string: imageData.url)
        imageImageView.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageImageView.image = nil
    }
}
