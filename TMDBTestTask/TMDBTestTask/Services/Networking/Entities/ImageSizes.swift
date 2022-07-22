//
//  ImageSizes.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 21.07.2022.
//

import Foundation

enum PosterSizes: String, Codable {
    case w92 = "w92"
    case w154 = "w154"
    case w185 = "w185"
    case w342 = "w342"
    case w500 = "w500"
    case w780 = "w780"
    case original = "original"
}

enum BackdropSizes: String, Codable {
    case w300 = "w300"
    case w780 = "w780"
    case w1280 = "w1280"
    case original = "original"
}
