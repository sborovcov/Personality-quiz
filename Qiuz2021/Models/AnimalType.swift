//
//  AnimalType.swift
//  Qiuz2021
//
//  Created by Stas Borovtsov on 12.01.2021.
//

enum AnimalType: Character{
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"

    var definition: String{
        switch self {
        case .dog:
            return "Вы пёсель"
        case .cat:
            return "Вы котейка"
        case .rabbit:
            return "А вы активненький"
        case .turtle:
            return "Вы не торопитесь"
        }
    }
}
