//
//  File.swift
//  
//
//  Created by Clissia Bozzer Bovi on 31/01/24.
//

import Foundation

class Combinations {
    static func getCombinationResult(_ firstAllele: Alleles,_ secondAllele: Alleles) -> String {
        if(firstAllele == .S || secondAllele == .S) {
            return Assets.Images.bunnyWild.rawValue
        } else if (firstAllele == .C || secondAllele == .C) {
            return Assets.Images.bunnyChinchilla.rawValue
        } else if (firstAllele == .H || secondAllele == .H) {
            return Assets.Images.BunnyHimalaian.rawValue
        } else {
            return Assets.Images.bunnyAlbino.rawValue
        }
    }

    static func getCombinationResult(_ firstAlleles: [Alleles],_ secondAlleles: [Alleles]) -> String {
        return "aa"
    }
}
