//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Terry Thrasher on 2021-04-18.
//
//  Challenge: Rock Paper Scissors
//  Each turn the app will randomly pick one of rock, paper, or scissors.
//  Each turn the app will prompt the player to pick the option that will win or lose the hand.
//  The player player must tap the option that will win or lose the hand, as prompted.
//  If the player is corret, they earn a point, and lose a point otherwise.
//  The game ends after 10 questions, and then the score is shown.

import SwiftUI

struct ContentView: View {
    @State private var showingResult = false
    @State private var roundResult = ""
    @State private var score = 0
    @State private var round = 0
    @State private var shouldWin = Bool.random()
    @State private var whichObject = Int.random(in: 0...2)
    
    let objects = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.gray, Color.white, Color.gray]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("RPS Training")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("I throw... \(objects[whichObject])!")
                Text("I want you to \(shouldWin ? "WIN!" : "LOSE!")")
                
                VStack {
                    ForEach(0..<3) { number in
                        Button(action: {
                            self.buttonTapped(number)
                        }) {
                            Text("\(objects[number])")
                        }
                    }
                    .frame(maxWidth: 140, maxHeight: 140)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3)
                    .font(.title)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .padding(50)
                }
                
                Spacer()
                
                Text("Round \(round)")
            }
        }
        .alert(isPresented: $showingResult) {
            Alert(title: Text("Result"), message: Text(roundResult), dismissButton: .default(Text("Continue")) {
                self.newRound()
            })
        }
    }
    
    func buttonTapped(_ number: Int) {
        // I assume there's an easier way to specify what we're looking for... like if shouldWin, number should be equal to whichObject +1 spot in the array, else -1 spot in the array, taking wrapping into account. But I'm not sure how to do that!
        switch whichObject {
        case 0:
            if shouldWin && number == 1 {
                checkAnswer(correct: true)
            } else if !shouldWin && number == 2 {
                checkAnswer(correct: true)
            } else {
                checkAnswer(correct: false)
            }
        
        case 1:
            if shouldWin && number == 2 {
                checkAnswer(correct: true)
            } else if !shouldWin && number == 0 {
                checkAnswer(correct: true)
            } else {
                checkAnswer(correct: false)
            }
            
        default:
            if shouldWin && number == 0 {
                checkAnswer(correct: true)
            } else if !shouldWin && number == 1 {
                checkAnswer(correct: true)
            } else {
                checkAnswer(correct: false)
            }
        }
    }
    
    func checkAnswer(correct: Bool) {
        if correct {
            score += 1
            roundResult = "You were correct!"
        }
        else {
            score -= 1
            roundResult = "You were wrong!"
        }
        
        round += 1
        if round >= 10 {
            roundResult = roundResult + " And the game is over! Your score is \(score) out of a possible 10!"
            print("Game is over")
        }
        
        showingResult = true
        print("Result should be shown")
    }
    
    func newRound() {
        if round >= 10 {
            round = 1
            score = 0
        }
                
        whichObject = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
