# KituraBotFrontendEchoSample
Kitura Sample Bot Frontend: implement a simple ECHO Bot using the KituraBot and the KituraBotFacebookMessenger channel

**Warning: This is work in progress**

KituraBot (https://github.com/JacopoMangiavacchi/KituraBot) is a Swift, Kitura based, declarative multi-channel BOT framework.

KituraBotFacebookMessenger (https://github.com/JacopoMangiavacchi/KituraBotFacebookMessenger) is a KituraBot plugin for the Facebook Messenger channel.  It comply to the KituraBotProtocol defined in the KituraBot package.


## Setup

Configure Facebook Messenger Bot parameters in the Configuration.swift file and follow Facebook documentation at https://developers.facebook.com/docs/messenger-platform/implementation#subscribe_app_pages

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


## Sample code
## A simple Echo Bot exposed over Facebook Messenger channel in both Syncronous and Asyncronous way

    //1. Instanciate KituraBot and implement BOT logic
    let bot = KituraBot(router: router) { (channelName: String, senderId: String, message: String) -> String? in
        
        //1.a Implement classic Syncronous BOT logic implementation with Watson Conversation, api.ai, wit.ai or other tools
        let responseMessage = "ECHO: \(message)"
        
        //3.a [Optional] Manage classic Asyncronous BOT logic implementation decoupling for example with OpenWhisk
        //let openWhiskMessage = ["channelName" : channelName, "senderId" : senderId, "message" : message]
        //whisk.fireTrigger(name: "xx", package: "xx", namespace: "xx", parameters: openWhiskMessage, callback: {(reply, error) -> Void in {}
        // OpenWhisk chain will use a specific KituraBotPushAction to send back to KituraBot in a asyncronous way the response message to send back to client
        
        //1.b return immediate Syncronouse response or return nil to do not send back any Syncronous response message
        return responseMessage
    }
            
            
    ///3.b [Optional] Activate Async Push Back cross channel functionality
    bot.exposeAsyncPush(securityToken: Configuration.pushApiSecurityToken, webHookPath: "/botPushApi") { (channelName: String, senderId: String, message: String) -> (channelName: String, message: String)? in
        //The implementation of exposePushBack method in KituraBot class will automatically expose REST interface to be called by the Async logic (i.e. KituraBotPushAction)
        
        var responseChannelName = channelName
        var responseMessage = message
        
        //3.c [Optional] implement optional logic to eventually notify back the user on different channels
        //responseChannelName = "..."
        
        ///3.d [Optional] send back Async response message
        //responseMessage = "..."
        
        //3.e return new channel and message or return nil to use the passed channel and message
        //return (responseChannelName, responseMessage)
        
        return nil
    }


    //2. Add specific channel to the KituraBot instance
    do {
        //2.1 Add Facebook Messenger channel
        try bot.addChannel(channelName: "FacebookEcho", channel: KituraBotFacebookMessenger(appSecret: Configuration.appSecret, validationToken: Configuration.validationToken, pageAccessToken: Configuration.pageAccessToken, webHookPath: "/webhook"))
        
        //2.1 Add Slack, Skype etc. channels
        //try bot.addChannel(channelName: "SlackEcho1", KituraBotSlack(slackConfig: "xxx", webHookPath: "/echo1slackcommand"))
        //try bot.addChannel(channelName: "SkypeEcho1", KituraBotSkype(skypeConfig: "xxx", webHookPath: "/echo1skypewebhook"))
        
        //2.2 Add MobileApp channel (use Push Notification for Asyncronous response message
        //try bot.addChannel(channelName: "MobileAppEcho1", KituraBotMobileApp("appSecret": "yyy-yyy-yyy", "appId": "xxx-xxx-xx", apiPath: "/echo1api")))
    } catch is KituraBotError {
        Log.error("Oops... something wrong on Bot Channel name")
    }





