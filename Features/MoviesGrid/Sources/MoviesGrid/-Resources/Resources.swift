//
//  Resources.swift
//  MoviesGrid
//
//  Created by Jezreel Barbosa on 22/10/21.
//

import Foundation
import UIComponents
import UIKit

enum Assets: String, AssetImage {

    case filmIcon
}

struct Colors {

    static let backgroundColor = UIColor.dynamic(any: Palette.White.white, dark: Palette.Black.eerieBlack)
    static let labelTitleColor = UIColor.dynamic(any: Palette.Black.black, dark: Palette.White.platinum)
    static let labelDateColor = UIColor.dynamic(any: Palette.Gray.onyx, dark: Palette.Gray.spanishGray)
    static let borderColor = UIColor.dynamic(any: Palette.White.platinum, dark: Palette.Gray.onyx)
}

struct Texts {

    struct MoviesGrid {

        static let moviesTitle = LocalizedString()
            .enUS("Movies")
            .ptBR("Filmes")
            .localizedText

        static let searchPlaceholder = LocalizedString()
            .enUS("Search movie")
            .ptBR("Pesquisar filme")
            .localizedText
    }
}

struct Configs {

    static let locale = LocalizedString()
        .enUS("en-US")
        .ptBR("pt-BR")
        .localizedText

    static let dateFormat = LocalizedString()
        .enUS("MMM dd, yyyy")
        .ptBR("dd/MM/yyyy")
        .localizedText
}
