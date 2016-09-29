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
    static let appSecret = "..."

    // Arbitrary value used to validate a webhook
    static let validationToken = "..."

    // Generate a page access token for your page from the App Dashboard
    static let pageAccessToken = "..."
    
    // Token to use for verifing access to the Async Push Notification API
    static let pushApiSecurityToken = "..."

}
