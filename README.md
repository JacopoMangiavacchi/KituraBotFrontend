# KituraBotFrontendEchoSample
Kitura Sample Bot Frontend: implement a simple ECHO Bot using the KituraBot and the KituraBotFacebookMessenger channel

KituraBot (https://github.com/JacopoMangiavacchi/KituraBot) is a Swift, Kitura based, declarative multi-channel BOT framework.

KituraBotFacebookMessenger (https://github.com/JacopoMangiavacchi/KituraBotFacebookMessenger) is a KituraBot plugin for the Facebook Messenger channel.  It comply to the KituraBotProtocol defined in the KituraBot package.


SETUP:

Configure Facebook Messenger Bot parameters in the Configuration.swift file and follow Facebook documentation at https://developers.facebook.com/docs/messenger-platform/implementation#subscribe_app_pages


Sample code:
    
Usage:

    //1. Instanciate KituraBot and implement BOT logic
    let bot = KituraBot(router: router) { (channelName: String, senderId: String, message: String) -> String? in
        //1.a Implement classic Syncronous BOT logic implementation with Watson Conversation, api.ai, wit.ai or other tools
        let responseMessage = "ECHO: \(message)"
        //1.b return immediate Syncronouse response or return nil to do not send back any Syncronous response message
        return responseMessage
    }

        
    //2. Add specific channel to the KituraBot instance
    do {
        //2.1 Add Facebook Messenger channel
        try bot.addChannel(channelName: "FacebookEcho", channel: KituraBotFacebookMessenger(appSecret: "...", validationToken: "...", pageAccessToken: "...", webHookPath: "/webhook"))
    } catch is KituraBotError {
        Log.error("Oops... something wrong on Bot Channel name")
    }




