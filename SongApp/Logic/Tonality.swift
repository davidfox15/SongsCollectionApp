//
//  Tonality.swift
//  SongApp
//
//  Created by Давид Лисицын on 16.06.2022.
//

import Foundation

extension String {
    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex
        
        while searchStartIndex < self.endIndex,
              let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
              !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }
        
        return indices
    }
}

final class Tonality {
    static let tones: [String] = ["A","A#","H","C","C#","D","D#","E","F","F#","G","G#"]
    static let tonesA: [String] = ["A","H","C","D","E","F","G"]
    static let tonesD: [String] = ["A#","C#","D#","F#","G#"]
    
    private static func changeUp(ton: String) -> String {
        for index in 0..<tones.count {
            if (tones[index] == ton) {
                //print("old \(tones[index]) new: \(tones[(index + 1) % tones.count])")
                return tones[(index + 1) % tones.count]
            }
        }
        print("Error tone")
        return ton
    }
    
    private static func changeDown(ton: String) -> String {
        for index in 0..<tones.count {
            if (tones[index] == ton) {
                //print("old \(tones[index]) new: \(tones[(index + 1) % tones.count])")
                return tones[(index + (tones.count - 1)) % tones.count]
            }
        }
        print("Error tone")
        return ton
    }
    
    
    static func up(text: String) -> String {
        var indices: [Int] = []
        var dict: [Int: String] = [:]
        var songText: String = text
        
        for a in 0..<tonesA.count {
            indices = songText.indicesOf(string: tonesA[a])
            for i in indices {
                dict[i] = tonesA[a]
            }
        }
        for t in 0..<tonesD.count {
            indices = songText.indicesOf(string: tonesD[t])
            for i in indices {
                dict[i] = tonesD[t]
            }
        }
        let sortedYourArray = dict.sorted( by: { $0.0 > $1.0 })
        
        for (num, tonality) in sortedYourArray {
            if(tonality.contains("#")) {
                songText.remove(at: songText.index(songText.startIndex, offsetBy: num+1))
            }
            let index = songText.index(songText.startIndex, offsetBy: num)
            songText = songText.replacingCharacters(in: index...index, with: changeUp(ton: tonality))
        }
        
        return songText
    }
    
    static func down(text: String) -> String {
        var indices: [Int] = []
        var dict: [Int: String] = [:]
        var songText: String = text
        
        for a in 0..<tonesA.count {
            indices = songText.indicesOf(string: tonesA[a])
            for i in indices {
                dict[i] = tonesA[a]
            }
        }
        for t in 0..<tonesD.count {
            indices = songText.indicesOf(string: tonesD[t])
            for i in indices {
                dict[i] = tonesD[t]
            }
        }
        let sortedYourArray = dict.sorted( by: { $0.0 > $1.0 })
        // повышаем тональность
        
        for (num, tonality) in sortedYourArray {
            if(tonality.contains("#")) {
                songText.remove(at: songText.index(songText.startIndex, offsetBy: num+1))
            }
            let index = songText.index(songText.startIndex, offsetBy: num)
            songText = songText.replacingCharacters(in: index...index, with: changeDown(ton: tonality))
        }
        
        return songText
    }
    
}

