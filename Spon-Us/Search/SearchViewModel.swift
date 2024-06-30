//
//  SearchViewModel.swift
//  Spon-Us
//
//  Created by KimYuBin on 6/29/24.
//

import Foundation
import Moya

@Observable
final class SearchViewModel {
    let provider = MoyaProvider<SponusAPI>()
    var recentSearches: [String] = []
    
    func fetchSearch(keyword: String, completion: @escaping (Bool) -> Void) {
        provider.request(.getSearch(keyword: keyword)) { response in
            switch response {
            case .success(let response):
                do {
                    let searchResponse = try JSONDecoder().decode(SearchResponseModel.self, from: response.data)
                    print(searchResponse.content.content)
                    completion(true)
                } catch let error {
                    print("fetch search decode error: \(error.localizedDescription)")
                    completion(false)
                }
            case .failure(let error):
                print("getSearch API error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func fetchKeyword(completion: @escaping (Bool) -> Void) {
        provider.request(.getKeyword) { response in
            switch response {
            case .success(let response):
                do {
                    let keywordResponse = try JSONDecoder().decode(KeywordModel.self, from: response.data)
                    self.recentSearches = keywordResponse.content
                    completion(true)
                } catch let error {
                    print("fetch keyword decode error: \(error.localizedDescription)")
                    completion(false)
                }
            case .failure(let error):
                print("getKeyword API error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func postKeyword(keyword: String, completion: @escaping (Bool) -> Void) {
            provider.request(.postKeyword(keyword: keyword)) { response in
                switch response {
                case .success(let response):
                    do {
                        let postKeywordResponse = try JSONDecoder().decode(DefaultResponse.self, from: response.data)
                        completion(true)
                    } catch let error {
                        print("post keyword decode error: \(error.localizedDescription)")
                        completion(false)
                    }
                case .failure(let error):
                    print("postKeyword API error: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
}
