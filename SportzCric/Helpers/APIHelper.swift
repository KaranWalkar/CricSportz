//
//  APIHelper.swift
//  SportzCric
//
//  Created by Smollan Karan on 07/11/23.
//

import Foundation

class APIHelper: NSObject{
    // MARK: Api call
    func getApiData(apiUrl: String, httpMethod: String, completion: @escaping (_ success : Welcome) -> Void, failure: @escaping (_ errorMsg : String) -> Void) {
        let url = URL(string: apiUrl)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error { throw error }
                if let data = data {
                    let result = try JSONDecoder().decode(Welcome.self, from: data)
                    completion(result)
                } else {
                    failure("Please try again")
                }
            } catch {
                failure("Please try again")
            }
        }
        
        task.resume()
    }
}



