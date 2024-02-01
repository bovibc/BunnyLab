//
//  File.swift
//  
//
//  Created by Clissia Bozzer Bovi on 31/01/24.
//

import Foundation

class Combinations {
    static func getCombinationResult(_ firstAllele: Alleles,_ secondAllele: Alleles) -> String {
        let assets = Assets()
        if(firstAllele == .S || secondAllele == .S) {
            return assets.bunnyWild
        } else if (firstAllele == .C || secondAllele == .C) {
            return assets.bunnyChinchilla
        } else if (firstAllele == .H || secondAllele == .H) {
            return assets.BunnyHimalaian
        } else {
            return assets.bunnyAlbino
        }
    }

    static func getCombinationResult(_ firstAlleles: [Alleles],_ secondAlleles: [Alleles]) -> String {
        return "aa"
    }
}
