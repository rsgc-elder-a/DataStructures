//
//  main.swift
//  BeggarYourNeighbour
//
//  Created by Russell Gordon on 12/14/16.
//  Copyright © 2016 Russell Gordon. All rights reserved.
//

import Foundation




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

// Initialize hands
var playerHand : [Card] = []
var computerHand : [Card] = []
var cardPile : [Card] = []

func addToPile (index : Int, cardType : Bool) {
    if (cardType == true) { // for computer hand // makes sure this isnt backwards
        cardPile.append(computerHand[index])
        computerHand.remove(at: index)
    } else { //for player hand
        cardPile.append(playerHand[index])
        playerHand.remove(at: index)
    }
   // print("Added \(cardPile[0]) to pile")
    
}

func penalty (index: Int, cardType: Bool, amount: Int){
    for i in 1...amount {
        addToPile(index: i+index, cardType: cardType)
    }
}


func addCards(cardType : Bool){ //for putting the card in proper places
    
    //card pile could be the problem
    if (cardType == true) { //this could cause problems later
        for j in 1...cardPile.count { // for computer hand
            //removes from pile into hand
            playerHand.append(cardPile[0])
            //if this breaks here someone has won
            cardPile.remove(at: 0)
        }
    } else { //player hand
        
        for j in 1...cardPile.count  {
            //remove from pile into hand
             computerHand.append(cardPile[0])
            //if this breaks here someone has won
             cardPile.remove(at: 0) //always take away the last one?
        }
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



while deck.count > 26 {
    
    // Generate a random number between 0 and the count of cards still left in the deck
    var position = Int(arc4random_uniform(UInt32(deck.count)))
    
    // Copy the card in this position to the player's hand
    playerHand.append(deck[position])
    
    // Remove the card from the deck for this position
    deck.remove(at: position)
    
}
computerHand = deck


print("Beggar your Neighbour Start with enter key!", terminator:"")


var arrayIndex = computerHand.count



for i in 1...arrayIndex-1 {
    
    if playerHand.count > computerHand.count { //this keeps the loop in the index of the array
        arrayIndex = computerHand.count
        print("Cards in computer deck: \(arrayIndex)")
    } else {
        arrayIndex = playerHand.count
        print("Cards in player deck: \(arrayIndex)")
    }
    
    
    if let input : String = readLine() {
        
        var currentCard : Int
        var cardType : Bool //if true computer otherwise player
        if (i % 2 == 0) { //even
            
            currentCard = computerHand[i].value
            cardType = true
            print("Computer Turn")
            //if even its a computer card
        } else {
            currentCard = playerHand[i].value
            cardType = false
            // it would be player card
            print("Player Turn")
        }
        
        switch currentCard { //for checking the computer card
        case(11): //jack
            print("put 1 in pile and current player pick up pile")
            penalty(index: i, cardType: cardType, amount: 1)
            addCards(cardType: cardType)
            
        case(12): //queen
            print("put 2 in pile and current player pick up pile")
            penalty(index: i, cardType: cardType, amount: 2)
            addCards(cardType: cardType)
            
        case(13): //king
            print("put 3 in pile and current player pick up pile")
            penalty(index: i, cardType: cardType, amount: 3)
            addCards(cardType: cardType)
            
        case(14): //ace
            print("put 4 in pile and current player pick up pile")
            penalty(index: i, cardType: cardType, amount: 4)
            addCards(cardType: cardType)
            
        default: //just adds to pile
            print("add to pile")
            addToPile(index: i, cardType: cardType)
        }
        
        
        
        if(i % 2 == 1){
            print("Player Card: ", terminator:"")
            print(currentCard)
        } else {
            print(" Computer Card: ", terminator:"")
            print(currentCard)
        }
        print("Current Pile: ", terminator:"")
        print(cardPile)
        print("Player cards left: ", terminator:"")
        print(playerHand.count, terminator:"")
        print(" Computer cards left: ", terminator:"")
        print(computerHand.count)
        
        
    }
    
}







