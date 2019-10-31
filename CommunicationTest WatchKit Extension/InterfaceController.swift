//
//  InterfaceController.swift
//  CommunicationTest WatchKit Extension
//
//  Created by Parrot on 2019-10-26.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    

    var seconds = 60
var gameTimer: Timer?
    
    var hunger = 0
    var health = 100
    // MARK: Outlets
    // ---------------------
    @IBOutlet var messageLabel: WKInterfaceLabel!
   
    // Imageview for the pokemon
    @IBOutlet var pokemonImageView: WKInterfaceImage!
    // Label for Pokemon name (Albert is hungry)
    @IBOutlet var nameLabel: WKInterfaceLabel!
    // Label for other messages (HP:100, Hunger:0)
    @IBOutlet var outputLabel: WKInterfaceLabel!
    
    @IBOutlet var hungerOutput: WKInterfaceLabel!
    
    
    // MARK: Delegate functions
    // ---------------------

    // Default function, required by the WCSessionDelegate on the Watch side
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //@TODO
    }
    
    // 3. Get messages from PHONE
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("WATCH: Got message from Phone")
        // Message from phone comes in this format: ["course":"MADT"]
        let messageBody = message["course"] as! String
        messageLabel.setText(messageBody)
        
        if(messageBody == "POKEMON")
        {
            var image : UIImage = UIImage(named:"pikachu")!
            pokemonImageView.setImage(image)
        //    pokemonImageView = WKInterfaceImage?(image: image)
        }
        else  if(messageBody == "CATERPIE")
        {
            var image : UIImage = UIImage(named:"caterpie")!
            pokemonImageView.setImage(image)
            //    pokemonImageView = WKInterfaceImage?(image: image)
        }
        
    }
  //  gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)

//
//    func runTimer() {
//        gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: Selector(("updateCounting")), userInfo: nil, repeats: true)
//            print("hellloooo")
//
//    }
//
    
    
    
    
//
//    func scheduledTimerWithTimeInterval(){
//        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("updateCounting"), userInfo: nil, repeats: true)
//    }
//
    func updateCounting(){
       // NSLog("counting..")

        print("checking updation ")
    }
//
//
//
//
    
    
    
    
   
//
//    override func viewDidLoad() {
//        scheduledTimerWithTimeInterval()
//    }
//
    
    
     // timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: Selector(("updateCounting")), userInfo: nil, repeats: true)
    
    
    
    //timer.invalidate()

    
    // MARK: WatchKit Interface Controller Functions
    // ----------------------------------
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        // 1. Check if teh watch supports sessions
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    // MARK: Actions
    // ---------------------
    
    // 2. When person presses button on watch, send a message to the phone
    @IBAction func buttonPressed() {
        
      
        
        if WCSession.default.isReachable {
            print("Attempting to send message to phone")
          //  self.messageLabel.setText("Sending msg to watch")
            WCSession.default.sendMessage(
                ["name" : "pokemon"],
                replyHandler: {
                    (_ replyMessage: [String: Any]) in
                    // @TODO: Put some stuff in here to handle any responses from the PHONE
                    print("Message sent, put something here if u are expecting a reply from the phone")
                    self.messageLabel.setText("Got reply from phone")
            }, errorHandler: { (error) in
                //@TODO: What do if you get an error
                print("Error while sending message: \(error)")
                self.messageLabel.setText("Error sending message")
            })
        }
        else {
            print("Phone is not reachable")
            self.messageLabel.setText("Cannot reach phone")
        }
    }
    
    
    // MARK: Functions for Pokemon Parenting
    @IBAction func nameButtonPressed() {
        print("name button pressed")
        
        // 1. When person clicks on button, show them the input UI
        let suggestedResponses = ["Albert", "Jenelle", "Pritesh", "Mohammad"]
        presentTextInputController(withSuggestions: suggestedResponses, allowedInputMode: .plain) { (results) in
            
            
            if (results != nil && results!.count > 0) {
                // 2. write your code to process the person's response
                let userResponse = results?.first as? String
                self.nameLabel.setText(userResponse)
            }
        }

        
        
    }

    @IBAction func startButtonPressed() {
        print("Start button pressed")
        
        
        // HERE'S CODE TO INCREASE HUNGER EVERY 5 SECONDS BY 10%
        
//        if(hungerOutput.text == "paused")
//        {
//
//        }
        hunger = hunger + 10
        if(hunger >= 100)
        {
            hunger = 100
        }

        if(hunger >= 80 && hunger <= 100)
        {
            health = health-5
        }
        else if(hunger < 80)
        {
           health = health + 40
        }
        if(health > 100)
        {
            health = 100
        }
        
        if(health <= 0)
        {
            let death = "PLAYER DIED"
            health = 0
            nameLabel.setText(death)
        
            
            
        }
        
        let myString = String(hunger)
        hungerOutput.setText(myString)
        
        let myStringForHealth = String(health)
        outputLabel.setText(myStringForHealth)
        
        
        
        // UPDATE IN THE UILABEL
//        NSString *labelstr = @"Your text for a label";
//        urlabelname.text = [NSString stringWithFormat:@"%@%@",textfieldname.text,labelstr];
        
        
      // runTimer()
       // scheduledTimerWithTimeInterval()
        
    }
    
    @IBAction func feedButtonPressed() {
        print("Feed button pressed")
        
        hunger = hunger-12
//       // let x : Int = 42
        if(hunger <= 0)
        {
          //  var newhunger =
            hunger = 0
        }
        let myString = String(hunger)
       hungerOutput.setText(myString)
        
        
        
    }
    
    
    @IBAction func hibernateButtonPressed() {
        print("Hibernate button pressed")
        let pause = "GAME PAUSED"
        nameLabel.setText(pause)
        outputLabel.setText(pause)
        hungerOutput.setText(pause)
        
        
        
        if WCSession.default.isReachable {
            print("app is in hibernation mode")
            //  self.messageLabel.setText("Sending msg to watch")
            WCSession.default.sendMessage(
                ["Status" : "HiberNate MODE ON"],
                replyHandler: {
                    (_ replyMessage: [String: Any]) in
                   
            }, errorHandler: { (error) in
                //@TODO: What do if you get an error
                print("Error while sending message: \(error)")
                self.messageLabel.setText("Error sending message")
            })
        }
        
        
    }
    @IBAction func restartButtonPressed() {
        
        if WCSession.default.isReachable {
            print("Attempting to send message to phone")
            //  self.messageLabel.setText("Sending msg to watch")
            WCSession.default.sendMessage(
                ["Status" : "Restart MODE ON"],
                replyHandler: {
                    (_ replyMessage: [String: Any]) in
                    // @TODO: Put some stuff in here to handle any responses from the PHONE
                    print("Message sent, put something here if u are expecting a reply from the phone")
                    self.messageLabel.setText("Got reply from phone")
            }, errorHandler: { (error) in
                //@TODO: What do if you get an error
                print("Error while sending message: \(error)")
                self.messageLabel.setText("Error sending message")
            })
        }
        
        
    }
}
