//
//  ZGConstants.swift
//  ZoGoo
//
//  Created by Salman Nasir on 20/02/2017.
//  Copyright © 2017 Salman Nasir. All rights reserved.
//

import UIKit



  struct setBoarder {
    let view : UIView?
    let width : CGFloat?
    let color : UIColor?
    
    @discardableResult  init(view: UIView, width: CGFloat , color : UIColor ) {
        self.view = view
        self.width  = width
        self.color  = color
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 1
        
        

    }
}

enum WAUserType : Int
{
    case WAUser = 0 ,
    WAVendor
    
}

enum TQActionType: Int {
    case TQLogin = 0,
    TQSignup,
    TQForgetPassword ,
    TQSkip
}

var DEVICE_TOKEN: String = ""
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEGHT = UIScreen.main.bounds.height
var DEVICE_LAT =  0.0
var DEVICE_LONG = 0.0
var DEVICE_ADDRESS = ""
var SELECTUSER = ""


var updateDEVICE_LAT =  0.0
var updateDEVICE_LONG = 0.0


let IS_IPHONE_5 = (UIScreen.main.bounds.width == 320)
let IS_IPHONE_6 = (UIScreen.main.bounds.width == 375)
let IS_IPHONE_6P = (UIScreen.main.bounds.width == 414)

//LIVE URL


let BASE_URL  =  "http://api.divergense.com/kcall/api/"





//let BASE_URL  =  "http://adadigbomma.com/"

//LOCAL URL
//let BASE_URL = "http://192.168.1.192/whereapp/api/"


//let API_KEY = "jIbF3yQG0s/AliunDtw3yYfH5w1mzOk5MaTeXIU5ORI="

//service URLS
//let SIGNUP = BASE_URL + "user/register"

let SIGNUP = BASE_URL + "register"
let LOGIN = BASE_URL + "login"
let SOCIAL_LOGIN = BASE_URL + "socialLogin"


let FORGOTPASSWORD = BASE_URL + "register/forgot"
let SOCIALSIGNUP = BASE_URL + "socialSingup"
let VERIFY_CODE = BASE_URL + "verifyCode"
let RESEND_CODE = BASE_URL + "sendCode"
let TRAVEL_INFO = BASE_URL + "addTravelInfo"
let GET_ALLPOST = BASE_URL + "publish-products"
let ADDMOREINFO = BASE_URL + "addMoreInfo"
let GETALLITEM = BASE_URL + "getItems"
let GETITEMCATEGORIES = BASE_URL + "getItemsCategories"
let GETALLFILTERITEM = BASE_URL + "getItems/search"



let PRODUCT_FAVOURITE = BASE_URL + "favourite-product"
let GET_FAVOURITEITEM = BASE_URL + "favourite-products"
let RESET_PASSWORD = BASE_URL + "resetPassword"
let RESET_PASSWORD_VERIFY = BASE_URL + "resetPasswordVerify"
let CHANGE_PASSWORd = BASE_URL + "changePassword"
let ADDIDCardInfo = BASE_URL + "add-id-info"
let ADDCARDDETAIL = BASE_URL + "add-card-detail"
let SEND_OFFER = BASE_URL + "send-offer"
let USERPROFILE = BASE_URL + "userProfile"
let UPDATEOFFERSTATUS = BASE_URL + "update-offer-status"
let USEROFFERDETAIL = BASE_URL + "user-offer-detail"
let PLACE_ORDER = BASE_URL + "place-order"
let UPDATEPROFILE_PIC = BASE_URL + "updateProfilePicture"
let UPDATEPROFILE = BASE_URL + "updateProfile"
let ORDER_LIST = BASE_URL + "user-orders"




















//var localUserData: UserData!
//var notificationType = "none"

weak var localUserData: UserInformation!


let kUserNameRequiredLength: Int = 3
let kValidationMessageMissingInput: String = "Please fill all the fields"
let kEmptyString: String = ""
let kPasswordRequiredLength: Int = 5
let kUserNameRequiredLengthForPhone: Int = 9
let kValidationMessageMissingInputPhone : String = "Please give the proper phone Number"

let KValidationPassword : String = "Password must be greater 6 digits"
let kValidationEmailInvalidInput: String = "Please enter valid Email Address"
let kValidationEmailEmpty : String = "email can't be blank"
let kValidationPasswordEmpty : String = "Password can't be blank"
let kValidationPhoneNumEmpty : String = "Phone Number can't be blank"

let kUpdateTokenMessage: String = "user does not exists"
let KMessageTitle: String = "K Call"
let KChoseCategory: String = "Choose Category"

let CURRENT_DEVICE = UIDevice.current
let KIDNumberValidat : String = "Id Number can't be blank"
let KIMAGeSELECT : String = "Please Select the image"

let kValidationNameInput: String = "Please Enter the name"
let kValidationNameInputCharacter : String = "Full Name must be alphabet characters.\n"
let kValidationConfirmPasswordEmpty : String = "Confirm Password can't be blank"
let KPasswordMismatch : String = "Password mismatch"



let kValidationCardNumInput: String = "Card Number can't be blank"
let kValidationCardHolderNameInput: String = "Card Holder Name can't be blank"
let kValidationCardHolderNameInputCharacter : String = "Card Holder Name must be alphabet characters.\n"
let kValidationCardExpiryDate : String = "Expiry date can't be blank"
let kValidationCardCcvNum : String = "Ccv Number  can't be blank"



let MAIN                           = UIStoryboard(name: "Main", bundle: nil)
let HOME                        = UIStoryboard(name: "Home", bundle: nil)


struct VCIdentifier {
//   User ViewControllers
    static let kMainInitialVC = "KInitialVC"
    static let kSETALLOW = "KSetAllowAccessVC"
    static let kMainTutorialVC2 = "GSTutorialVC2"
    static let kMainTutorialVC3 = "GSTutorialVC3"
    static let kSELECTVC = "GSSelectVC"
    static let kForgotPasswordController = "GSForgotPasswordVC"
    static let KLoginViewController = "KLoginVC"
    static let KSignUpSelectionViewController = "KSignUpVC"
    static let KSELECTSIGNUPPROCESS = "KSelectSignProcessVC"

    
    static let KSignUpViewController = "GHSignUpVC"
    static let KVerifyAccountVC = "GHVerifyAccountVC"
    static let KSETTRAVELINFO = "KSetTravelInfoVC"
    static let KAddCardInfo = "GSAddCardInfoVC"
    static let KAllowLocationViewController = "GSAllowLocationVC"
    static let KMYPOSTVC = "GSMyPostVC"
    static let KEDITPOST = "GSEditProfileVC"
    static let KSETTINGVC = "GSSettingVC"
    static let kCHNAGEPASSWORD = "GHChangePasswordVC"

    //Main  View Controller
    static let kMainTabbarController = "GSTabbarController"
    static let KRecentPostCell  = "RecentPostCell"
    static let kUserPostDetail = "GSPostDetailVC"
    static let KMorePhoteCell = "MorePhotoCell"
    static let KPRofileSET = "KProfileSetVC"
    static let kGSReferenceNumberVC = "GSReferenceNumberVC"
    static let kTermAndCondition = "GSAboutVC"
    
    static let kOrderDetailVC = "OrderDetailVC"
    static let kEmployeeChatVC = "EmployeeChatViewController"
    static let kEmployeeEditProfile = "EmployeeEditProfile"
    static let kEmployeeNotification = "EmployeeNotification"
}



// API Contant

let kUserId                 : String = "user_id"
let kFirstName              : String = "firstname"
let kLastName               : String = "lastname"
let KFullName               : String = "name"
let KPhoneNum               : String = "phoneNumber"

let kEmail                  : String = "email"
let kPassword               : String = "password"
let kConfirmPassword        : String = "confirmPassword"
let KNewPassword               : String = "newPassword"
let KIdNumver               : String = "idNumber"
let KTRAVEL_INFO                  : String = "travel"
let KMOREINFO                  : String = "add-more-info"

let KSIGNUPTYPE                  : String = "sinupType"







let KCODE                    : String = "code"
let KRESENTCODE              : String = "code"

let kSocialId               : String = "social_id"
let kProfileImage           : String = "profile_image"
let kSignupType             : String = "signup_type"
let kLatitude               : String = "latitude"
let kLongitude              : String = "longitude"
let kDeviceType             : String = "deviceType"
let kDeviceTOken              : String = "deviceToken"
let KImageFileName                : String = "profilePicture.png"
let KImageParam                : String = "profilePicture"

let KADDRESS              : String = "address"

let KImageIDCARDName               : String = "idNumberPicture.png"
let KImageIDCardParam                : String = "idNumberPicture"

let KDeviceType                  : String = "deviceType"
let KProductName                 : String  = "productName"
let KProductCategory                 : String  = "productCategory"
let KProductAddress                : String  = "productLocalisation"
let KProductDescription                 : String  = "productDescription"
let KProductPrice                 : String  = "productPrice"
let KProductImage                 : String  = "productImages"
let KProductID                 : String  = "productId"
let KSentOfferPrice                : String  = "price"

let KProductfavourite                 : String  = "favourite"
let KFavouriteBadge                 : String  = "Badge"
let KFavouriteCount                : String  = "favouriteItemCount"
let KExpiryDate                : String  = "userCardExpiry"
let KCardHolderName                : String  = "userCardHolderName"
let KUserCardNumber                : String  = "userCardNumber"
let KCardCVVNum                : String  = "userCardCsv"
let KOfferSENT                : String  = "offerSent"
let KUPDATEPROFILE                : String  = "updateProfile"

let KACCEPTOFFER                : String  = "acceptOffer"
let KREJECTOFFER                : String  = "rejectOffer"
let KNEWOFFER                : String  = "newOffer"

let KStatus                : String  = "status"
let KOfferSendUserId                : String  = "offerSenderUserId"

let KOFFERId                 : String  = "offerId"
let KCONFIRMATIONMESSAGE                 : String  = "Garage Sale is working with Services  provider to confirm your Order "


let KGENDER               : String  = "gender"
let KAGE                : String  = "age"
let KHEIGHT                : String  = "height"

let KWEIGHT                : String  = "weight"
let KPROFESSION               : String  = "profession"
let KPLIFESTYLE               : String  = "lifeStyle"





