//
//  FirestoreRecord.swift
//  convey (iOS)
//
//  Created by Grant Jensen on 11/3/21.
//

struct FirestoreRecord : Codable {
    var RecordId : String? = nil
    var RecordName : String? = nil
    var ParsedText : String? = nil
    var Time : Double? = nil
    var WordCount : Int? = nil
    var Wpm : Int? = nil
    var HighestFreqWords: [String : Int]? = nil  //(key: filler words, val: count)
    var SpecialWordsUniversal: [String]? = nil
    var SpecialWordsPersonal: [String]? = nil
    var FillerWordCount: Int? = nil
    var HighestFillerWords: [String : Int]? = nil //(key: filler words, val: count)
    var FillerWordsPace: Float? = nil
    var WordsPerFillerWords: Float? = nil
}
