//
//  File.swift
//  
//
//  Created by Clissia Bozzer Bovi on 02/02/24.
//

import Foundation

enum StoryFlow {
    case City
    case Woods1
    case Woods2
    case Woods3
    case FirstExperiment
    case SecondExperiment
    case ThirdExperiment
    case End
}

class TextFlow {
    // MARK: Variables
    var textIndex: Int = 0
    var text: [String] = []
    var flow: StoryFlow = .City
    
    let texts: Texts = Texts()

    // MARK: Public Methods
    func startText(flow: StoryFlow) -> String? {
        self.flow = flow
        switch flow {
        case .City:
            return startCityFlowText()
        case .FirstExperiment:
            return startFirstExperimentFlowText()
        case .SecondExperiment:
            return startSecondExperimentFlowText()
        case .ThirdExperiment:
            return startThirdExperimentFlowText()
        case .End:
            return startEndFlowText()
        case .Woods1:
            return startWoodsFlowText(flow: 1)
        case .Woods2:
            return startWoodsFlowText(flow: 2)
        case .Woods3:
            return startWoodsFlowText(flow: 3)
        }
    }

    func nextText() -> String? {
        textIndex += 1
        if textIndex == text.count {
            textIndex = 0
            return nil
        } else {
            return text[textIndex]
        }
    }

    func previousText() -> String? {
        textIndex -= 1
        if textIndex == -1 {
            textIndex = 0
            return nil
        } else {
            return text[textIndex]
        }
    }
    
    func isZeroIndex() -> Bool {
        return textIndex == 0
    }
    
    func isFirstIndex() -> Bool {
        return textIndex == 1
    }

    // MARK: Private Methods
    private func startCityFlowText() -> String {
        text = texts.cityTexts
        return text[textIndex]
    }
    
    private func startWoodsFlowText(flow: Int) -> String {
        if(flow == 1) {
            text = texts.woodsTexts1
        } else if(flow == 2) {
            text = texts.woodsTexts2
        } else {
            text = texts.woodsTexts3
        }
        return text[textIndex]
    }
    
    private func startFirstExperimentFlowText() -> String {
        text = texts.firstExperimentTexts
        return text[textIndex]
    }
    
    private func startSecondExperimentFlowText() -> String {
        text = texts.secondExperimentTexts
        return text[textIndex]
    }
    
    private func startThirdExperimentFlowText() -> String {
        text = texts.thirdExperimentTexts
        return text[textIndex]
    }
    
    private func startEndFlowText() -> String {
        text = texts.endTexts
        return text[textIndex]
    }
}
