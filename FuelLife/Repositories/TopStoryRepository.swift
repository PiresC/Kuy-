//
//  TopStoryRepository.swift
//  FuelLife
//
//  Created by Amos Ebenhaezer on 12/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import Foundation

struct TopStory {
    var title: String = ""
    var url: String = ""
    var abstract: String = ""
    var thumbnail_standard: String = ""
}

struct result: Decodable {
    let title: String
    let url: String
    let abstract: String
    let thumbnail_standard: String
}

struct responseStory: Decodable {
    let results: [result]
}

protocol TopStoryRepositoryDelegate {
    func updateData(data: [TopStory])
}

struct TopStoryRepository {
    
    var topStories: [TopStory] = []
    var delegate: TopStoryRepositoryDelegate?
    
    func fetchApi() {
            if let url = URL(string: "https://api.nytimes.com/svc/news/v3/content/nyt/arts.json?api-key=HqWJNEfPxWnk73JGAjZ0rmGOhie5iWV2&limit=4") {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        let jsonDecoder = JSONDecoder()
                        do {
                            let parsedJSON = try jsonDecoder.decode(responseStory.self, from: data)
                            var stories: [TopStory] = []
                            for apiResult in parsedJSON.results {
                                var topstory = TopStory()
                                topstory.title = apiResult.title
                                topstory.abstract = apiResult.abstract
                                topstory.url = apiResult.url
                                topstory.thumbnail_standard = apiResult.thumbnail_standard
                                stories.append(topstory)
                            }
                            self.delegate?.updateData(data: stories)
                        } catch {
                            print(error)
                        }
                    }
                    print(self.topStories)
                }.resume()
            }
        }
}
