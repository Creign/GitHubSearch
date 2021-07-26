//
//  SearchViewModel.swift
//  GithubSearch
//
//  Created by Excell on 15/07/2021.
//

import Foundation
import Moya
import Alamofire

class SearchViewModel {
    
    let service = SearchService()
    
    // MARK: - Binding Variables
    var searchSuccess: ((SearchDataType)->())?
    var searchFailed: ((String)->())?
    
    func doSearch(txt: String) {
        service.search(txt: txt) { [weak self] (resp, error) in
            guard let self = self else { return }
            if let error = error {
                self.searchFailed?(error.localizedDescription)
                return
            }
            guard let model = resp else { return }
            self.searchSuccess?(model)
        }
    }
}

class SearchService {
    var provider: MoyaProvider<Service>
    
    init() {
        self.provider = MoyaProvider<Service>()
    }

    func search(txt: String ,completion: @escaping ((SearchDataType?, Error?) -> Void)) {
        let header: HTTPHeaders = ["Content-Type": "application/json",
                      "Accept": "application/vnd.github.v3+json"]
        let url = URL(string: "https://api.github.com/search/code?q=\(txt)+user:Creign")!
        let request = AF.request(url, headers: header)
        
        request.responseDecodable(of: SearchDataType.self) { response in
            if let model = response.value, !model.items.isEmpty {
                completion(model, nil)
            } else {
                completion(nil, response.error)
            }
            
        }
        
//        provider.request(.code(txt: txt)) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let decoder = JSONDecoder()
//                    let resp = try decoder.decode(SearchDataType.self, from: response.data)
//                    print(resp)
//                    completion(resp, nil)
//                } catch (let err) {
//                    print(err)
//                    completion(nil, nil)
//                }
//            case .failure(let error):
//                completion(nil, error)
//            }
//        }
    }
    
    /// Todo: - Search
//    func search(txt: String ,completion: @escaping ((SearchDataType?, Error?) -> Void)) {
//        let dispatch = DispatchGroup()
//
//    }
}
