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
}
