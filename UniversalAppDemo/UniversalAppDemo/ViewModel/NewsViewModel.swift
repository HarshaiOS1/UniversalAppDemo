//
//  NewsViewModel.swift
//  UniversalAppDemo
//
//  Created by Harsha on 21/04/2023.
//

import Foundation

class SearchViewModel: NSObject {
    var operationQueue = OperationQueue()
    var searchResult: FootballNewsModel?
    
    //MARK: Get  News result
    func getNewsList(completion: @escaping (Bool, String?) -> Void) {
        if let listURL = URL(string: Constants.newsList) {
            var request = URLRequest.init(url: listURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 120)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                if error == nil {
                    if Constants.positiveStatusCodes.contains((response as? HTTPURLResponse)?.statusCode ?? 404) {
                        guard let _data = data else {
                            completion(false, "No News yet..!")
                            return
                        }
                        do {
                            let string1 = String(data: _data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                            print(string1)
                            let activityLog = try JSONDecoder().decode(FootballNewsModel.self, from: _data)
                            self.searchResult = activityLog
                            completion(true, "Result Available")
                        } catch {
                            print(error.localizedDescription)
                            completion(false, error.localizedDescription)
                        }
                    } else {
                        completion(false,"")
                    }
                } else {
                    print(error?.localizedDescription ?? "error")
                    completion(false,"")
                }
            }.resume()
            
        } else {
            print("No url")
        }
    }
}
