//
//  main.swift
//
//
//  Created by Dmitry Novikov on 11.08.2022.
//

import Foundation

for color in Color.allColors {
	print(color)
}

print()

for value in Value.allValues {
	print(value)
}

print()

let card1 : Card = Card(color: .hearts, value:.KING)
let card2 : Card = Card(color: .diamonds, value: .two)
let card3 : Card = Card(color: .clubs, value: .ACE)
let card4 : Card = Card(color: .hearts, value: .ten)
let card5 : Card = Card(color: .clubs, value: .ten)
let card6 : Card = Card(color: .clubs, value: .ACE)

print(card1)
print(card2)
print(card3)
print(card4)
print(card5)
print(card6)

print()

print("Tests for isEqual function:")
print("\(card1) is equal to \(card3): \(card1.isEqual(card3))")
print("\(card3) is equal to \(card5): \(card3.isEqual(card5))")
print("\(card4) is equal to \(card5): \(card4.isEqual(card5))")
print("\(card3) is equal to \(card6): \(card3.isEqual(card6))")
print("\(card6) is equal to \(card6): \(card6.isEqual(card6))")

print()

print("Tests for == operator:")
print("\(card1) == \(card3): \(card1 == (card3))")
print("\(card3) == \(card5): \(card3 == (card5))")
print("\(card4) == \(card5): \(card4 == (card5))")
print("\(card3) == \(card6): \(card3 == (card6))")
print("\(card6) == \(card6): \(card6 == (card6))")

print()

print(Deck.allSpades, " | ", Deck.allSpades.count, " cards")
print()
print(Deck.allDiamonds, " | ", Deck.allDiamonds.count, " cards")
print()
print(Deck.allHearts, " | ", Deck.allHearts.count, " cards")
print()
print(Deck.allClubs, " | ", Deck.allClubs.count, " cards")
print()
print(Deck.allCards, " | ", Deck.allCards.count, " cards")
print()

var allCards = Deck.allCards
allCards.shuffle()
print(allCards, " | ", allCards.count, " cards shuffled")


var cardsPack = Deck(isShuffled: true)

print(cardsPack)

cardsPack = Deck(isShuffled: false)
print()
for _ in 0...12 {
	print(cardsPack.draw() ?? card1)
}

print()
print(cardsPack.outs)

print()
for _ in 0...5 {
	cardsPack.fold(cardToFold: cardsPack.outs[0])
}

print()
print(cardsPack.discards)
print()
print(cardsPack.outs)
print()
print(cardsPack.cards)
