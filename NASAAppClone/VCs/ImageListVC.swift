//
//  ViewController.swift
//  NASAAppClone
//
//  Created by Kirti S on 2/21/23.
//

import UIKit

/// View controller that subviews a collection view to show a grid of 3x3 images obtained from the parsed json data
class ImageListVC : UIViewController {
    
    /// collection view for showing the list of the images obtained from the json data
    private let myCollectionView : UICollectionView = {
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout())
        cv.alwaysBounceVertical = true
        cv.contentInsetAdjustmentBehavior = .always
        cv.backgroundColor = .clear
        cv.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    /// reference to the ImageListViewModel class
    private let viewModel = ImageListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// set up collection view delegate and data source
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        /// Call to fetch image data that returns a success or a failure with an error value
        self.viewModel.fetchImagesArrayWith{ [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.myCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        
        view.addSubview(myCollectionView)
        
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            myCollectionView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            myCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
        ])
    }
    
    private func setUpUI() {
        
        self.title = "NASA Images"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
}


extension ImageListVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCollectionViewItemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// set up a collection view cell of class ImageCell with the Image data obtained from the element at the given row in imagesArray
        let cvCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cvCell.setUpSingleChatCellWith(imageData: viewModel.getSelectedImageDataAt(index: indexPath.row))
        return cvCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    /// sets a grid of 3x3
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/3) - 3, height: (view.frame.size.width/2) - 3)
    }
    
    /// Function to invoke when a image cell is selected
    /// The selectedIndex value in the viewModel is updated to the current row selected by the user
    /// An instance of DetailVC, a controller that shows the selected image in detail, is created using the storyboard ID
    /// The viewModel property of DetailVC is set before pushing the controller on the top of the navigation controller view controller stack
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.setSelectedImageTo(index: indexPath.row)
        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detailViewController.viewModel = viewModel
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
}
