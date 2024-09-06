//
//  PreviousProposeViewModel.swift
//  Spon-Us
//
//  Created by KimYuBin on 9/6/24.
//

import Foundation
import Moya

@Observable
final class PreviousProposeViewModel: Identifiable, ObservableObject {
    let id: Int
    let organizationId: Int
    let target: Int
    var targetName: String
    var targetImageUrl: String?
    var status: String
    var createdAt: String

    init(previousProposeModel: PreviousProposeModel) {
        self.id = previousProposeModel.id
        self.organizationId = previousProposeModel.organizationId
        self.target = previousProposeModel.target
        self.targetName = previousProposeModel.targetName
        self.targetImageUrl = previousProposeModel.targetImageUrl
        self.status = previousProposeModel.status
        self.createdAt = previousProposeModel.createdAt
    }
}

@Observable
final class PreviousProposeListViewModel: ObservableObject {
    var proposeList: [PreviousProposeViewModel] = []
    let provider = MoyaProvider<SponusAPI>()
    
    // [GET] 이전 협업 : 보낸 제안 목록 조회
    func fetchProposesSend(completion: @escaping (Bool) -> Void) {
        provider.request(.getProposeSend(page: 0, size: 0)) { response in
            switch response {
            case .success(let response):
                do {
                    let proposeSendResponse = try JSONDecoder().decode(PreviousPropose.self, from: response.data)
                    self.proposeList = proposeSendResponse.content.content.map { PreviousProposeViewModel(previousProposeModel: $0) }
                    completion(true)
                } catch let error {
                    print("fetch proposes decode error: \(error.localizedDescription)")
                    completion(false)
                }
            case .failure(let error):
                print("getPreviousProposes API error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    // [GET] 이전 협업 : 받은 제안 목록 조회
    func fetchProposesReceive(completion: @escaping (Bool) -> Void) {
        provider.request(.getProposeReceive(page: 0, size: 0)) { response in
            switch response {
            case .success(let response):
                do {
                    let proposeReceiveResponse = try JSONDecoder().decode(PreviousPropose.self, from: response.data)
                    self.proposeList = proposeReceiveResponse.content.content.map { PreviousProposeViewModel(previousProposeModel: $0) }
                    completion(true)
                } catch let error {
                    print("fetch proposes decode error: \(error.localizedDescription)")
                    completion(false)
                }
            case .failure(let error):
                print("getPreviousProposes API error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
