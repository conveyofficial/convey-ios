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
    var fillerSet : [String]? = nil
    var topFreqFillers : [String : Int]? = nil
    var topFreqWords : [String : Int]? = nil
    var wordFreq : [String : Int]? = nil
    
}
