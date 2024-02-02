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
            return Assets.General.bunnyWild.rawValue
        } else if (firstAllele == .C || secondAllele == .C) {
            return Assets.General.bunnyChinchilla.rawValue
        } else if (firstAllele == .H || secondAllele == .H) {
            return Assets.General.bunnyHimalayan.rawValue
        } else {
            return Assets.General.bunnyAlbino.rawValue
        }
    }

    static func getCombinationResultName(_ firstAllele: Alleles,_ secondAllele: Alleles) -> String {
        if(firstAllele == .S || secondAllele == .S) {
            return "Wild"
        } else if (firstAllele == .C || secondAllele == .C) {
            return "Chinchilla"
        } else if (firstAllele == .H || secondAllele == .H) {
            return "Himalayan"
        } else {
            return "Albino"
        }
    }

    static func getCrossesResult(_ firstAlleles: [Alleles],_ secondAlleles: [Alleles]) -> [String] {
        let result1 = getCombinationResult(firstAlleles[0], secondAlleles[0])
        let result2 = getCombinationResult(firstAlleles[0], secondAlleles[1])
        let result3 = getCombinationResult(firstAlleles[1], secondAlleles[0])
        let result4 = getCombinationResult(firstAlleles[1], secondAlleles[1])
        
        return [result1, result2, result3, result4]
    }

    static func getCrossesResultString(_ firstAlleles: [Alleles],_ secondAlleles: [Alleles]) -> [String] {
        let result1 = getCrossesResultStringWithPriority(firstAlleles[0], secondAlleles[0])
        let result2 = getCrossesResultStringWithPriority(firstAlleles[0], secondAlleles[1])
        let result3 = getCrossesResultStringWithPriority(firstAlleles[1], secondAlleles[0])
        let result4 = getCrossesResultStringWithPriority(firstAlleles[1], secondAlleles[1])
        
        return [result1, result2, result3, result4]
    }

    static func getCrossesResultStringWithPriority(_ firstAllele: Alleles,_ secondAllele: Alleles) -> String {
        var result = "\(firstAllele.rawValue)"
        switch secondAllele {
        case .S:
            result = secondAllele.rawValue + result
        case .C:
            if(firstAllele == .S) {
                result = result + secondAllele.rawValue
            } else {
                result = secondAllele.rawValue + result
            }
        case .H:
            if(firstAllele == .S || firstAllele == .C) {
                result = result + secondAllele.rawValue
            } else {
                result = secondAllele.rawValue + result
            }
        case .A:
            if(firstAllele == .S || firstAllele == .C || firstAllele == .H) {
                result = result + secondAllele.rawValue
            } else {
                result = secondAllele.rawValue + result
            }
        }
        return result.uppercased()
    }
}
