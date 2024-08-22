//
//  BookmarkViewModel.swift
//  Spon-Us
//
//  Created by KimYuBin on 5/12/24.
//

import Foundation
import Moya

@Observable
final class BookmarkListCellViewModel: Identifiable {
    let target: Int
    var companyName: String
    var imageURL: String?
    var isBookmarked: Bool = false
    var organizationType: String

    init(bookmarkModel: BookmarkModel) {
        self.target = bookmarkModel.target
        self.companyName = bookmarkModel.name
        self.imageURL = bookmarkModel.imageUrl
        self.organizationType = bookmarkModel.targetType.rawValue
    }
}

@Observable
final class BookmarkListViewModel {
    var bookmarkList: [BookmarkListCellViewModel] = []
    let provider = MoyaProvider<SponusAPI>()
    
    // [GET] 북마크 목록 조회
    func fetchBookmarks(sort: BookmarkTargetType, completion: @escaping (Bool) -> Void) {
        provider.request(.getBookmark(sort: sort)) { response in
            switch response {
            case .success(let response):
                do {
                    let bookmarkResponse = try JSONDecoder().decode(BookmarkResponseModel.self, from: response.data)
                    self.bookmarkList = bookmarkResponse.content.map { BookmarkListCellViewModel(bookmarkModel: $0) }
                    completion(true)
                } catch let error {
                    print("fetch bookmark decode error: \(error.localizedDescription)")
                    completion(false)
                }
            case .failure(let error):
                print("getBookmark API error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    // [POST] 북마크 토글
    func toggleBookmark(target: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.postBookmark(target: target)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let body = try JSONDecoder().decode(BookmarkPostResponseModel.self, from: response.data)
                    if let index = self?.bookmarkList.firstIndex(where: { $0.target == target }) {
                        self?.bookmarkList[index].isBookmarked = body.content.bookmarked
                        completion(true)
                    } else {
                        completion(false)
                    }
                } catch {
                    print("postBookmark parse error", error.localizedDescription)
                    completion(false)
                }
            case .failure(let error):
                print("postBookmark API error", error.localizedDescription)
                completion(false)
            }
        }
    }
}
