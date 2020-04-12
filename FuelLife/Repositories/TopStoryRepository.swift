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
}

struct result: Decodable {
    let title: String
    let url: String
    let abstract: String
}

struct responseStory: Decodable {
    let results: [result]
}

class TopStoryRepository {
    
    var topStories: [TopStory] = []
    
    var topStory: TopStory! {
        didSet {
            update()
        }
    }
    
    func fetchApi() {
            if let url = URL(string: "https://api.nytimes.com/svc/news/v3/content/all/all.json?api-key=HqWJNEfPxWnk73JGAjZ0rmGOhie5iWV2&limit=4") {
                URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                    if let data = data {
                        let jsonDecoder = JSONDecoder()
                        do {
                            let parsedJSON = try jsonDecoder.decode(responseStory.self, from: data)
                            for apiResult in parsedJSON.results {
                                var topstory = TopStory()
    //                            print(result)
                                topstory.title = apiResult.title
                                topstory.abstract = apiResult.abstract
                                topstory.url = apiResult.url
                                
                                self.topStories.append(topstory)
                                print(apiResult)
    //                            test.append(topstory)
    //                            print(self.topStories)
    //                            print("asda")
    //                            print(parsedJSON)
    //                            print("asdasd")
                            }
    //                        storyCompletionHandler(self.topStories, nil)
                        } catch {
                            print(error)
                        }
    //                    self.setTopStoryData(topStoriesData: test)
                    }
                    print(self.topStories)
    //                return self.topStories
                }).resume()
    //           print(test)
                
            }
        }
    
        func setTitleLabel() -> [String] {
            print(topStories)
            
            return []
        }
        
    func update() {
        
    }
        
    //    func setTopStoryData(topStoriesData: [TopStory]) -> [TopStory] {
    //        topStories = topStoriesData
    //        print(topStoriesData)
    //        return topStoriesData
    //    }
        
        
        
    //    func setLabelAbstract(text: String) {
    //        if count < 4 {
    //            self.abstractLabel?.text = text
    //            print(text)
    //        } else {
    //            return
    //        }
    //    }
    //
    //    func totalCount() {
    //        if count < 4 {
    //            count += 1
    //        } else {
    //            return
    //        }
    //    }
    
}
