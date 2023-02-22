//
//  DetailVC.swift
//  NASAAppClone
//
//  Created by Kirti S on 2/21/23.
//

import UIKit

/// View controller that subviews a detailed view of the selected image from the ImageListVC
class DetailVC: UIViewController {
    
    ///collection view for showing the detail image in a card-swipeable layout
    private let myCollectionView : UICollectionView = {
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout())
        cv.contentInsetAdjustmentBehavior = .always
        cv.isScrollEnabled = false
        cv.register(DetailImageCell.self, forCellWithReuseIdentifier: DetailImageCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    /// reference to the ImageListViewModel class
    var viewModel = ImageListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
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
    
    override func viewWillAppear(_ animated: Bool) {
    
        myCollectionView.setNeedsLayout()
        myCollectionView.layoutIfNeeded()
        
        /// Fetch the selected index from the viewModel and set the current Index path to the same
        /// Set the collection view to start at the current index path
        var currentIndexPath = IndexPath(row: viewModel.selectedIndex, section: 0)
        DispatchQueue.main.async {
            self.myCollectionView.scrollToItem(at: currentIndexPath, at: [], animated: true)
        }
    }
    
    private func setUpCollectionView() {
        
        /// set up collection view delegate and data source
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        ///set up collection view flow layout to ImageCardsCollectionFlowLayout to display a card like cell
        myCollectionView.collectionViewLayout = ImageCardsCollectionFlowLayout()
        
        /// Gesture to scroll to the next image when applied on the collection view
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        /// Gesture to scroll to the previous image when applied on the collection view
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        myCollectionView.addGestureRecognizer(swipeRight)
        myCollectionView.addGestureRecognizer(swipeLeft)
    }
    
    private func setUpUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        /// Get the selected index and the max index count from the view mode;
        let currentIndex = viewModel.selectedIndex
        let maxIndexCount = viewModel.getCollectionViewItemCount()
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .right:
                /// The collection view will scroll to the next image and update the selected index in the view model
                if currentIndex > 0 {
                    myCollectionView.scrollToItem(at: IndexPath(row: currentIndex - 1, section: 0), at: .left, animated: true)
                    viewModel.updateSelectedIndexTo(index: currentIndex - 1)
                }
            case .left:
                /// The collection view will scroll to the previous image and update the selected index in the view model
                if currentIndex < maxIndexCount {
                    if currentIndex + 1 !=  maxIndexCount {
                        myCollectionView.scrollToItem(at: IndexPath(row: currentIndex + 1, section: 0), at: .left, animated: true)
                        viewModel.updateSelectedIndexTo(index: currentIndex + 1)
                    }
                }
            default:
                break
            }
        }
    }
}

extension DetailVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCollectionViewItemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// set up a collection view cell of class DetailImageCell with the Image data obtained from the element at the given row in imagesArray
        let cvCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailImageCell.identifier, for: indexPath) as! DetailImageCell
        cvCell.setUpSingleChatCellWith(imageData: viewModel.getSelectedImageDataAt(index: indexPath.row))
        return cvCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 50, height: collectionView.frame.height - 50)
    }
}
