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
    static let appSecret = "4c36e757ed0976a2856564976aac973d"

    // Arbitrary value used to validate a webhook
    static let validationToken = "JacopoMangiavacchiToken"

    // Generate a page access token for your page from the App Dashboard
    static let pageAccessToken = "EAAIlxjmRZB7YBADlpLZCugk0wku7qprQK2oOEMSPnUZBQVXyt1VwW2o4BPciBTu6eE9jUOAei7ZAcnXIg7g0EiG88QtQEJWDfU4q1dRZAtVmKQSOyF63LZCk111ldKO7cfd6PP5AZBp4pFssPYz4QrrpfUGkG4es7w0zaDQZAJrRZAAZDZD"
    
    // Token to use for verifing access to the Async Push Notification API
    static let pushApiSecurityToken = "1234"
    
    // Token to use for verifing access to the Mobile API
    static let mobileApiSecurityToken = "1234"

    // Push certificate path
    static let mobileApiPushPassPath = "./Certificates/apns-dev.crt.pem"
    
    // Push key path
    static let mobileApiPushKeyPath = "./Certificates/apns-dev.key.pem"

    // Push topic
    static let mobileApiPushTopic = "com.jacopomangiavacchi.KituraBot"
}
