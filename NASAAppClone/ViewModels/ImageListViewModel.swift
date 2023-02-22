//
//  ImageListViewModel.swift
//  NASAAppClone
//
//  Created by Kirti S on 2/21/23.
//

import Foundation


class ImageListViewModel {
    
    /// An array of type Image to hold all Image listings
    var imagesArray = [Image]()
    
    /// An Image variable to save the selected image object
    var selectedImage : Image?
    
    /// An selected index variable to save the selected index value
    var selectedIndex = Int()
    
    
    /// Feunction to fetch images array from the API call
    /// - Parameter completion: A callback that returns a result type of Bool, if successful and a Network Error error if unsuccessful
    func fetchImagesArrayWith(completion: @escaping(Result<Bool, NetworkError>) -> Void) {
        
        /// Hardcoding the filename in this use case
        let fileName = "Data"
        
        /// Initilaize an instance of APICaller class to call the fetchData function that takes a string filename as a paramater.
        APICaller().fetchDataFrom(fileName: fileName) { result in
            switch result {
            case .success((let imageArray)):
                self.imagesArray = imageArray
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Returns the number of elements imagesArray array
    func getCollectionViewItemCount() -> Int {
        return imagesArray.count
    }
    
    /// Returns an Image object at the specified index in the imagesArray
    func getSelectedImageDataAt(index: Int) -> Image {
        return imagesArray[index]
    }
    
    /// Sets the selected Image and the index to the updated index
    func setSelectedImageTo(index: Int) {
        selectedImage = imagesArray[index]
        selectedIndex = index
    }
    
    /// Returns the current value of the selectedImage
    func getSelectedImage() -> Image? {
        guard let selectedImage = selectedImage else {
            return nil
        }
        return selectedImage
    }
    
    /// Updates the value of the selected Index to given index
    func updateSelectedIndexTo(index: Int) {
        selectedIndex = index
    }
}
