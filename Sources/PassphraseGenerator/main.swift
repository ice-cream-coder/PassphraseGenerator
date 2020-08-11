//
//  main.swift
//  PasswordGenerator
//
//  Created by Roy Dawson on 5/28/20.

import Foundation

enum PartOfSpeech: String, Codable {
    case noun = "Noun"
    case verb = "Verb"
    case adjective = "Adjective"
    case adverb = "Adverb"
}

struct SimpleWord: Codable {
    let value: String
    let partOfSpeech: PartOfSpeech
    let definition: String
}
let unicodeScalarRange: ClosedRange<Unicode.Scalar> = "A" ... "Z"
let unicodeScalarValueRange: ClosedRange<UInt32> = unicodeScalarRange.lowerBound.value ... unicodeScalarRange.upperBound.value
let unicodeScalarArray: [Unicode.Scalar] = unicodeScalarValueRange.compactMap(Unicode.Scalar.init)
let characterArray: [Character] = unicodeScalarArray.map(Character.init)

let words = characterArray.flatMap { character -> [SimpleWord] in
    let dictionaryUrl = Bundle.module.url(forResource: "dictionary/\(character)", withExtension: "json")!
    let json = try! String(contentsOf: dictionaryUrl)
    let decoder = JSONDecoder()
    return try! decoder.decode([SimpleWord].self, from: json.data(using: .utf8)!)
}

var byPartOfSpeach = [PartOfSpeech: [SimpleWord]]()
for word in words.filter({ $0.value.count <= 8}) {
    byPartOfSpeach[word.partOfSpeech, default: []].append(word)
}

let adjective = byPartOfSpeach[.adjective]!.randomElement()!
let noun1 = byPartOfSpeach[.noun]!.randomElement()!
let verb = byPartOfSpeach[.verb]!.randomElement()!
let noun2 = byPartOfSpeach[.noun]!.randomElement()!
let adverb = byPartOfSpeach[.adverb]!.randomElement()!


let gps = 1e11
let strength = Double(byPartOfSpeach[.adjective]!.count) *
    Double(byPartOfSpeach[.noun]!.count) *
    Double(byPartOfSpeach[.verb]!.count) *
    Double(byPartOfSpeach[.noun]!.count) *
    Double(byPartOfSpeach[.adverb]!.count)

print("Your passphrase is:")
print("\(adjective.value.capitalized(with: .current)) \(noun1.value.lowercased()) \(verb.value.lowercased() + "s") \(noun2.value.lowercased()) \(adverb.value.lowercased())")
print("")
print("Definitions")
for word in [adjective, noun1, verb, noun2, adverb] {
    print("\(word.value): \(word.definition)")
}
print("")
print("Calculating strength at 100 billion guesses per second.")
print("It's strength is:")
print("\(strength / gps / 60 / 60 / 24 / 365) years")
print("")
print("Strength of a random 12 character password: [A-Za-z0-9]{12}")
print("\(pow(62,12) / gps / 60 / 60 / 24 / 365) years")
