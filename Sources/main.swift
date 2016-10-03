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

// Kitura-Starter-Bluemix shows examples for creating custom routes.
import Foundation
import Kitura
//import KituraSys
import KituraNet
import LoggerAPI
import HeliumLogger
import CloudFoundryEnv
import KituraBot
import KituraBotFacebookMessenger
import KituraBotMobileAPI
//import CloudFoundryDeploymentTracker

// Disable all buffering of stdout
setbuf(stdout, nil)

// All web apps need a Router instance to define routes
let router = Router()


// Using the HeliumLogger implementation for Logger
Log.logger = HeliumLogger()

// Serve static content from "public"
router.all("/", middleware: StaticFileServer())


//1. Instanciate KituraBot and implement BOT logic
let bot = KituraBot(router: router) { (channelName: String, senderId: String, message: String, context: [String: Any]?) -> (responseMessage: String, context: [String: Any]?)? in
    
    //1.a Implement classic Syncronous BOT logic implementation with Watson Conversation, api.ai, wit.ai or other tools
    let responseMessage = "ECHO: \(message)"
    
    //3.a [Optional] Manage classic Asyncronous BOT logic implementation decoupling for example with OpenWhisk
    //let openWhiskMessage = ["channelName" : channelName, "senderId" : senderId, "message" : message]
    //whisk.fireTrigger(name: "xx", package: "xx", namespace: "xx", parameters: openWhiskMessage, callback: {(reply, error) -> Void in {}
    // OpenWhisk chain will use a specific KituraBotPushAction to send back to KituraBot in a asyncronous way the response message to send back to client
    
    //1.b return immediate Syncronouse response or return nil to do not send back any Syncronous response message
    return (responseMessage, context)
}
        
        
//3.b [Optional] Activate Async Push Back cross channel functionality
bot.exposeAsyncPush(securityToken: Configuration.pushApiSecurityToken, webHookPath: "/botpushapi") { (channelName: String, senderId: String, message: String, context: [String: Any]?) -> (channelName: String, message: String, context: [String: Any]?)? in
    //The implementation of exposePushBack method in KituraBot class will automatically expose REST interface to be called by the Async logic (i.e. KituraBotPushAction)
    
    var responseChannelName = channelName
    var responseMessage = message
    var responseContext = context
    
    //3.c [Optional] implement optional logic to eventually notify back the user on different channels
    //responseChannelName = "..."
    
    //3.d [Optional] send back Async response message
    //responseMessage = "..."
    //responseContext = [:]
    
    //3.e return new channel and message or return nil to use the passed channel and message
    //return (responseChannelName, responseMessage, responseContext)
    
    return nil
}


//2. Add specific channel to the KituraBot instance
do {
    //2.1 Add Facebook Messenger channel
    try bot.addChannel(channelName: "FacebookEcho", channel: KituraBotFacebookMessenger(appSecret: Configuration.appSecret, validationToken: Configuration.validationToken, pageAccessToken: Configuration.pageAccessToken, webHookPath: "/webhook"))

    //2.2 Add MobileApp channel (use Push Notification for Asyncronous response message
    try bot.addChannel(channelName: "MobileAppEcho", channel: KituraBotMobileAPI(securityToken: Configuration.mobileApiSecurityToken, webHookPath: "/mobileapi"))

    //2.3 Add Slack, Skype etc. channels
    //try bot.addChannel(channelName: "SlackEcho1", KituraBotSlack(slackConfig: "xxx", webHookPath: "/echo1slackcommand"))
    //try bot.addChannel(channelName: "SkypeEcho1", KituraBotSkype(skypeConfig: "xxx", webHookPath: "/echo1skypewebhook"))
} catch is KituraBotError {
    Log.error("Oops... something wrong on Bot Channel name")
}


// Start Kitura-Starter-Bluemix server
do {
  let appEnv = try CloudFoundryEnv.getAppEnv()
  let port: Int = appEnv.port
  Log.info("Server will be started on '\(appEnv.url)'.")
  //CloudFoundryDeploymentTracker(repositoryURL: "https://github.com/IBM-Swift/Kitura-Starter-Bluemix.git", codeVersion: nil).track()
  Kitura.addHTTPServer(onPort: port, with: router)
  Kitura.run()
} catch CloudFoundryEnvError.InvalidValue {
  Log.error("Oops... something went wrong. Server did not start!")
}

