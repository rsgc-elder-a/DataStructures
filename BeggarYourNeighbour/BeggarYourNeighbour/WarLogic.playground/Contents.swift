//
//  main.swift
//  WarLogic
//
//  Created by Andy-E on 2016-12-12.
//  Copyright © 2016 Andy-E. All rights reserved.
//

import Foundation

/*
 func war (comp : Int, play : Int, currentIndex : Int) {
 
 if(comp > play){
 //remove from other deck and add to computer
 
 for j in 0...3{
 //puts correct cards in winners deck
 computerHand.append(computerHand[currentIndex+j])
 playerHand.remove(at: currentIndex+j)
 
 }
 print("Computer wins war")
 } else if(play < comp) {
 for j in 0...3{
 //puts the lossers hand in winner
 playerHand.append(computerHand[currentIndex+j])
 computerHand.remove(at: currentIndex+j)
 
 }
 
 print("Player wins war")
 } else {
 print("another war")
 
 }
 
 }
 */

// Create an enumeration for the suits of a deck of cards
enum Suit : String {
    
    case hearts     = "❤️"
    case diamonds   = "♦️"
    case spades     = "♠️"
    case clubs      = "♣️"
    
    // Given a value, returns the suit
    static func glyph(forHashValue : Int) -> String {
        switch forHashValue {
        case 0 :
            return Suit.hearts.rawValue
        case 1 :
            return Suit.diamonds.rawValue
        case 2 :
            return Suit.spades.rawValue
        case 3 :
            return Suit.clubs.rawValue
        default:
            return Suit.hearts.rawValue
        }
    }
    
}

// Play with the enumeration a bit to see what it gives us
Suit.hearts.hashValue
Suit.hearts.rawValue

// Create a new datatype to represent a playing card
struct Card {
    
    var value : Int
    var suit : Int
    
    // Initializer accepts arguments to set up this instance of the struct
    init(value : Int, suit : Int) {
        self.value = value
        self.suit = suit
    }
    
}

// Initalize a deck of cards
var deck : [Card] = []
for suit in 0...3 {
    for value in 2...14 {
        var card = Card(value: value, suit: suit)
        deck.append(card)
    }
}

// Iterate over the deck of cards
for card in deck {
    //  print("Suit is \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
}

// Initialize hands
var playerHand : [Card] = []
var computerHand : [Card] = []


// "Shuffle" the deck and give half the cards to the player

while deck.count > 26 {
    
    // Generate a random number between 0 and the count of cards still left in the deck
    var position = Int(arc4random_uniform(UInt32(deck.count)))
    
    // Copy the card in this position to the player's hand
    playerHand.append(deck[position])
    
    // Remove the card from the deck for this position
    deck.remove(at: position)
    
}
computerHand = deck

/*
 // Iterate over the player's hand
 print("=====================================")
 print("All cards in the player's hand are...")
 for (value, card) in playerHand.enumerated() {
 print("Card \(value) in player's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
 }
 
 print("=====================================")
 print(computerHand)
 
 
 
 
 
 */
//tempHold [] =[]

print("Start with enter key!", terminator:"")
var cardCount = 0
var arrayIndex = playerHand.count
for k in 0...25 {
    
    for i in 1...arrayIndex-1 {
        
        
        if playerHand.count > computerHand.count {
            arrayIndex = computerHand.count
            print("Cards in computer deck: \(arrayIndex)")
        } else {
            arrayIndex = playerHand.count
            print("Cards in player deck: \(arrayIndex)")
        }
        
        if let input : String = readLine() {
            
            if (playerHand.count > i || computerHand.count > i) {
                var computerCard : Int = computerHand[i].value
                var playerCard : Int = playerHand[i].value
                
                
                if (computerCard == playerCard){
                    print("WAR")
                    
                    print("Player final war card: ", terminator:"")
                    print(playerHand[i+3].value, terminator:"")
                    print(" Computer final war card: ", terminator:"")
                    print(computerHand[i+3].value)
                    
                    
                    if(computerHand[i+3].value > playerHand[i+3].value){
                        //remove from other deck and add to computer
                        
                        for j in 0...3{
                            //puts correct cards in winners deck
                            computerHand.append(computerHand[i+j])
                            playerHand.remove(at: i+j)
                            
                        }
                        print("Computer wins war")
                    } else if(computerHand[i+3].value < playerHand[i+3].value) {
                        for j in 0...3{
                            //puts the lossers hand in winner
                            playerHand.append(computerHand[i+j])
                            computerHand.remove(at: i+j)
                            
                        }
                        
                        print("Player wins war")
                    } else {
                        print("another war")
                        
                    }
                    
                } else if (computerCard > playerCard) {
                    
                    print("Winner: computer")
                    //remove from other deck and add to computer
                    computerHand.append(computerHand[i])
                    playerHand.remove(at: i)
                    
                    
                    cardCount += 1 //setup for next round
                    
                } else {
                    print("Winner: player")
                    //remove from other deck add to player
                    playerHand.append(computerHand[i])
                    computerHand.remove(at: i)
                    
                    cardCount += 1 //setup for next round
                }
                
                //trying to make sure i dont get out of index
                if (playerHand.count > i || computerHand.count > i) {
                    print("Player Card: ", terminator:"")
                    print(playerCard, terminator:"")
                    print(" Computer Card: ", terminator:"")
                    print(computerCard)
                    print("Player cards left: ", terminator:"")
                    print(playerHand.count, terminator:"")
                    print(" Computer cards left: ", terminator:"")
                    print(computerHand.count)
                    
                } else {
                    break
                }
            }
        }
    }
}






