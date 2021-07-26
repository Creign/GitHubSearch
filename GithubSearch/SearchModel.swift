//
//  SearchModel.swift
//  GithubSearch
//
//  Created by Excell on 15/07/2021.
//

import Foundation

struct SearchDataType: Decodable {
    var total_count: Int?
    var incomplete_results: Bool?
    var items: [SearchItemDataType]
}

struct SearchItemDataType: Decodable {
    var name: String?
    var path: String?
    var url: String?
    var git_url: String?
    var html_url: String?
    var repository: SearchItemRepositoryDataType?
}

struct SearchItemRepositoryDataType: Decodable {
    var id: Int
}


