//
//  FirebaseManager.swift
//  MaakanMoney
//
//  Created by Anand M on 25/05/24.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

class FirebaseDataManager: NSObject, ObservableObject {
    
    let db: Firestore =  Firestore.firestore()
    
    func validateMobile(mobile: String) async -> Result<Any, Error> {
        do {
            let querySnapshot: QuerySnapshot = try await db.collection(MMConstants.FirestoreConstants.userCollection).whereField("mobile", isEqualTo: MMConstants.TitleText.countryCode + mobile).getDocuments()
            return .success(querySnapshot)
        } catch {
            return .failure(error)
        }
    }
    
    func deleteUser(mobile: String) async -> Result<Bool, Error> {
        do {
            let querySnapshot: QuerySnapshot = try await db.collection(MMConstants.FirestoreConstants.userCollection).whereField("mobile", isEqualTo: MMConstants.TitleText.countryCode + mobile).getDocuments()
            try await db.collection(MMConstants.FirestoreConstants.userCollection).document(querySnapshot.documents.first?.documentID ?? MMConstants.emptyString).delete()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func updateSignUpDetails(name: String, email: String) async -> Result<Any, Error> {
        do {
            let querySnapshot: QuerySnapshot = try await db.collection(MMConstants.FirestoreConstants.userCollection).whereField("mobile", isEqualTo: MMConstants.TitleText.countryCode + Utilities.loggedInUserMobile).getDocuments()
            try await querySnapshot.documents.first?.reference.updateData(["name" : name, "isVerified" : true, "email" : email])
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
}
