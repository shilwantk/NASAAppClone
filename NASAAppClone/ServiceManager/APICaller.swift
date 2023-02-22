//
//  APICaller.swift
//  NASAAppClone
//
//  Created by Kirti S on 2/21/23.
//

import Foundation

enum NetworkError : Error {
    case InvalidFileName
    case InvalidFilePath
    case UnsuccessfulDecoding(error:String)
    case NilDataFound
}

class APICaller {
    
    /// Function to fetch and parse data from the specified json file
    /// - Parameters:
    /// - filename: Specifies the filename to fetch the data from
    /// - completion: A callback that returns a result type of an array of Image objects, if successful and a Network Error error if unsuccessful
    func fetchDataFrom(fileName: String, completion: @escaping (Result<([Image]), NetworkError>) -> Void) {
        
        /// Check for a valid filename in resources
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            completion(.failure(.InvalidFileName))
            return
        }
        
        /// Check for a valid filepath in resources
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            completion(.failure(.InvalidFilePath))
            return
        }
        
        do {
            let imagesArray = try JSONDecoder().decode([Image].self, from: data)
            completion(.success((imagesArray)))
        } catch (let error) {
            completion(.failure(.UnsuccessfulDecoding(error: error.localizedDescription)))
        }
    }
}
