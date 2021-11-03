//
//  FirestoreUser.swift
//  convey (iOS)
//
//  Created by Grant Jensen on 11/3/21.
//

struct FirestoreUser : Codable {
    var UserId : String? = nil
    var Records : [FirestoreRecord]? = nil
}
