//
//  DetailImageCell.swift
//  NASAAppClone
//
//  Created by Kirti S on 2/22/23.
//

import UIKit
import Kingfisher

/// Detail Image Cell class to hold a collection view cell with an image, a title, a date and an explanation
class DetailImageCell: UICollectionViewCell {
    
    static let identifier = "DetailImageCell"
    
    private let imageTitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let explanationTextView : UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.textColor = .black
        tv.contentInsetAdjustmentBehavior = .never
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageImageView)
        contentView.addSubview(imageTitleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(explanationTextView)
        
        NSLayoutConstraint.activate([
            
            imageImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            imageImageView.heightAnchor.constraint(equalToConstant: 250),
            
            imageTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageTitleLabel.topAnchor.constraint(equalTo: imageImageView.bottomAnchor, constant: 20),
            imageTitleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dateLabel.topAnchor.constraint(equalTo: imageTitleLabel.bottomAnchor, constant: 5),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            explanationTextView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            explanationTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            explanationTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
        ])
        
    }
    
    /// Sets up a collection view cell with a Image object
    /// - Parameter imageData: An object of type Image, that represents a single image with a title, a date, an explanation and an url
    public func setUpSingleChatCellWith(imageData: Image) {
        
        imageTitleLabel.text = imageData.title
        dateLabel.text = imageData.date
        explanationTextView.text = imageData.explanation
        
        let resource = ImageResource(downloadURL: URL(string: imageData.url)!)
        KingfisherManager.shared.retrieveImage(with: resource) { result in
            switch result {
            case.success(let imageResult):
                DispatchQueue.main.async {
                    self.imageImageView.image = imageResult.image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageImageView.image = nil
    }
}
