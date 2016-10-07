/**
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

/**
 * Configuration settings for integration services
 */
public struct Configuration {
    // App Secret can be retrieved from the App Dashboard
    static let appSecret = "xxx"

    // Arbitrary value used to validate a webhook
    static let validationToken = "xxx"

    // Generate a page access token for your page from the App Dashboard
    static let pageAccessToken = "xxx"

    // Hosted BOT Server URL
    static let botServerUrl = "http://localhost:8090"

    // Async push back path
    static let pushApiPath = "/botpushapi"

    // Token to use for verifing access to the Async Push Notification API
    static let pushApiSecurityToken = "xxx"
    
    // Async push back path
    static let mobileApiPath = "/mobileapi"

    // Token to use for verifing access to the Mobile API
    static let mobileApiSecurityToken = "xxx"

    // Facebook Messenger Channel Name
    static let facebookChanelName = "FacebookEcho"

    // Mobile API Channel Name
    static let mobileAPIChanelName = "MobileAppEcho"


    // Push Bluemix Region
    static let mobileApiPushBluemixRegion = "ng.bluemix.net"
    
    // Push Bluemix AppGuid
    static let mobileApiPushBluemixAppGuid = "xxx"
    
    // Push Bluemix AppSecret
    static let mobileApiPushBluemixAppSecret = "xxx"
}
