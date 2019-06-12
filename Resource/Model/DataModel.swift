//
//  DataModel.swift
//  ADIM
//
//  Created by Ahmed Durrani on 06/10/2017.
//  Copyright © 2017 Expert_ni.halal_Pro. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper


class UserResponse: Mappable {
    
    var status                           :       Bool?
    var message                          :       String?
    var code                             :       Int?
    var currentPage                      :       Int?
    var perPage                          :       Int?
    var total                            :       Int?

    var data                             :       UserInformation?
    var item                             :       [GetUserItemList]?
    var categoriesList                   :       [GetItemCategorie]?
    var profile                          :       UserProfileInfo?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        

        status      <- map["status"]
        message     <- map["message"]
        code        <- map["code"]
        data        <- map["data"]
        item        <- map["data"]
        currentPage      <- map["currentPage"]
        perPage      <- map["perPage"]
        total      <- map["total"]
        categoriesList <- map["data"]
        profile        <- map["data"]

        
    }
}

class UserInformation : Mappable {
    var token   : String?
    var user    : UserObjectInfo?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        user  <- map["user"]
        
        
    }
}



class UserObjectInfo : Mappable {
    
    var id                                   :       Int?
    var name                                 :       String?
    var email                                :       String?
    var gender                                :       String?

    var profilePicture                       :       String?
    var accountActivationStatus              :       String?
    var activationCode                       :       String?
    var activationCodeUpdatedAt              :       String?
    var accountStatus                        :       String?
    var phoneNumber                          :       String?
    var deviceType                           :       String?
    var deviceToken                          :       String?
    var latitute                             :       String?
    var longitude                            :       String?
    var token                                :       String?
    var profilePictureLink                   :       String?
    var address                              :       String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        gender <- map["gender"]
        profilePicture <- map["profilePicture"]
        accountActivationStatus <- map["accountActivationStatus"]
        activationCode <- map["activationCode"]
        accountStatus <- map["accountStatus"]
        phoneNumber <- map["phoneNumber"]
        deviceType <- map["deviceType"]
        deviceToken <- map["deviceToken"]
        latitute <- map["latitute"]
        longitude <- map["longitude"]
        token <- map["token"]
        profilePictureLink <- map["profilePictureLink"]
        address             <- map["address"]
    }
}

class UserProfileInfo : Mappable {
    
    var id                                   :       Int?
    var name                                 :       String?
    var email                                :       String?
    var gender                                :       String?
    
    var profilePicture                       :       String?
    var phoneNumber              :       String?
    var age                       :       String?
    var height              :       String?
    var weight                        :       String?
    var profession                          :       String?
    var lifeStyle                           :       String?
    var travel                          :       String?
    var latitute                             :       String?
    var longitude                            :       String?
    var accountActivationStatus                                :       String?
    var profilePictureLink                   :       String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        gender <- map["gender"]
        profilePicture <- map["profilePicture"]
        phoneNumber <- map["phoneNumber"]
        age <- map["age"]
        height <- map["height"]
        weight <- map["weight"]
        profession <- map["deviceType"]
        lifeStyle <- map["lifeStyle"]
        latitute <- map["latitute"]
        longitude <- map["longitude"]
        travel <- map["travel"]
        profilePictureLink <- map["profilePictureLink"]
        accountActivationStatus             <- map["accountActivationStatus"]
        
    }
}



class GetUserItemList : Mappable {
    
    var id                                       :       Int?
    var name                                     :       String?
    var image                                    :       String?
    var price                                    :       String?
    var location                                 :       String?
    var status                                   :       String?
    var created_at                               :       String?
    var updated_at                               :       String?
    var publishedAt                              :       String?
    var ImageLink                                :       String?
    var latitude                                 :       String?
    var longitude                                :       String?
    var category_id                              :       String?
    var calaries                                 :       String?
    var distance                                 :       Int?
    var restaurentInfo                           :       [RestaurentInfo]?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        price <- map["price"]
        location <- map["location"]
        status <- map["status"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        publishedAt    <- map["publishedAt"]
        ImageLink          <- map["ImageLink"]
        latitude          <- map["latitude"]
        longitude          <- map["longitude"]
        category_id          <- map["category_id"]
        restaurentInfo          <- map["restaurants"]
        calaries                <- map["calaries"]
        distance                <- map["distance"]
    }
}



class PostImagesList: Mappable {
    
    var imageName                          :       String?
    var imageWidth                          :       String?
    var imageHeight                           :       String?
    var product_id                           :       String?
    var imageLink                           :       String?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        imageName <- map["imageName"]
        imageWidth <- map["imageWidth"]
        imageHeight <- map["imageHeight"]
        product_id <- map["product_id"]
        imageLink <- map["imageLink"]

    }
}

class GetItemCategorie: Mappable {
    
    var id                          :       Int?
    var name                          :       String?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        
    }
}



class RestaurentInfo : Mappable {
    
    var id                              :       Int?
    var name                           :       String?
    var address                         :       String?
    var category_id                      :       String?
    var latitude                          :       String?
    var longitude                          :       String?
    var status                          :       String?
    var category                          :       String?
    var imageLink                         : String?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        address <- map["address"]
        category_id <- map["category_id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        status <- map["status"]
        category <- map["category"]
        imageLink <- map["imageLink"]

    }
}



