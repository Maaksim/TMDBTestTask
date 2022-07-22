//
//  UserDefaultssHelper.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 21.07.2022.
//

import Foundation

struct UserDefaultsHelperKeys {
    static let kBaseImageUrl = "kBaseImageUrl"
    static let kPosterSizes = "kPosterSizes"
    static let kBackdropSizes = "kBackdropSizes"
    static let kFavorites = "kFavorites"
}

class UserDefaultsHelper {
    
    static func saveBaseImageUrl(_ url: String?) {
        UserDefaults.standard.set(url, forKey: UserDefaultsHelperKeys.kBaseImageUrl)
    }
    
    static func getBaseImageUrl() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsHelperKeys.kBaseImageUrl)
    }
    
    static func getPosterSizes() -> [PosterSizes]? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsHelperKeys.kPosterSizes) else { return nil }
        return try? JSONDecoder().decode([PosterSizes].self, from: data)
    }
    
    static func savePosterSizes(_ sizes: [PosterSizes]) {
        let data = try? JSONEncoder().encode(sizes)
        UserDefaults.standard.set(data, forKey: UserDefaultsHelperKeys.kPosterSizes)
    }
    
    static func getBackdropSizes() -> [BackdropSizes]? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsHelperKeys.kBackdropSizes) else { return nil }
        return try? JSONDecoder().decode([BackdropSizes].self, from: data)
    }
    
    static func saveBackdropSizes(_ sizes: [BackdropSizes]) {
        let data = try? JSONEncoder().encode(sizes)
        UserDefaults.standard.set(data, forKey: UserDefaultsHelperKeys.kBackdropSizes)
    }
    
    static func getFavorites() -> [MovieInfoEntity]? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsHelperKeys.kFavorites) else { return nil }
        return try? JSONDecoder().decode([MovieInfoEntity].self, from: data)
    }
    
    static func saveFavorites(_ sizes: [MovieInfoEntity]) {
        let data = try? JSONEncoder().encode(sizes)
        UserDefaults.standard.set(data, forKey: UserDefaultsHelperKeys.kFavorites)
    }
}
