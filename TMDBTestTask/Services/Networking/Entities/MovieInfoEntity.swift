//
//  FavoriteEntity.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 21.07.2022.
//

import Foundation

struct MovieInfoEntity: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    
    init(id: Int?,
         title: String?,
         description: String?,
         posterPath: String?,
         backdropPath: String?,
         releaseDate: String?) {
        self.id = id
        self.title = title
        self.description = description
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
    }
}
