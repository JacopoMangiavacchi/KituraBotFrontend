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
import KituraBotFacebookMessenger
//import CloudFoundryDeploymentTracker

// Disable all buffering of stdout
setbuf(stdout, nil)

// All web apps need a Router instance to define routes
let router = Router()


// Using the HeliumLogger implementation for Logger
Log.logger = HeliumLogger()

// Serve static content from "public"
router.all("/", middleware: StaticFileServer())


// Change your Facebook Messenger Bot configuration in the Configuration.swift file
let poc = KituraBotFacebookMessenger(appSecret: Configuration.appSecret, validationToken: Configuration.validationToken, pageAccessToken: Configuration.pageAccessToken, webHookPath: "/webhook", sendApiPath: "/sendmessage", router: router) { (senderId: String, message: String) -> String? in
    
    //Implement your BOT logic and return a response message
    let responseMessage = "ECHO: \(message)"

    print("Received message: \(message)")
    print("Response message: \(responseMessage)")
    
    return responseMessage
    
    //return nil //to do not send back any response message
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

