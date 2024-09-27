//
//  ContentView.swift
//  Edutainment
//
//  Created by Иван Семикин on 27/09/2024.
//

import SwiftUI

struct Question {
    let text: String
    let answer: Int
}

struct ContentView: View {
    @State private var maxTable = 5
    @State private var numberOfQuestions = 5
    @State private var questions: [Question] = []
    
    @State private var gameStarted = false
    @State private var currentQuestion = 0
    @State private var userAnswer = ""
    @State private var score = 0
    @State private var gameOver = false
    
    var body: some View {
        NavigationView {
            VStack {
                if gameStarted {
                    if gameOver {
                        VStack {
                            Text("Game Over!")
                                .font(.largeTitle)
                                .padding()
                            
                            Text("You got \(score) out of \(numberOfQuestions) correct.")
                                .font(.title2)
                                .padding()
                            
                            Button("Play Again") {
                                restartGame()
                            }
                            .font(.title)
                            .padding()
                        }
                    } else {
                        Text(questions[currentQuestion].text)
                            .font(.largeTitle)
                            .padding()
                        
                        TextField("Your answer", text: $userAnswer)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button("Submit") {
                            submitAnswer()
                        }
                        .font(.title)
                        .padding()
                        
                        Text("Score: \(score)")
                            .font(.headline)
                            .padding()
                    }
                } else {
                    VStack {
                        Text("Choose max table to practice")
                        Stepper("Up to \(maxTable)", value: $maxTable, in: 2...12)
                            .padding()
                        
                        Text("Choose number of questions")
                        Picker("Questions", selection: $numberOfQuestions) {
                            Text("5").tag(5)
                            Text("10").tag(10)
                            Text("20").tag(20)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        Button("Start Game") {
                            startGame()
                        }
                        .font(.title)
                        .padding()
                    }
                }
            }
            .navigationTitle("Multiplication Game")
        }
    }
    
    func startGame() {
        gameStarted = true
        score = 0
        currentQuestion = 0
        userAnswer = ""
        gameOver = false
        generateQuestions()
    }
    
    func generateQuestions() {
        questions.removeAll()
        for _ in 0..<numberOfQuestions {
            let a = Int.random(in: 2...maxTable)
            let b = Int.random(in: 2...12)
            let question = Question(text: "What is \(a) x \(b)?", answer: a * b)
            questions.append(question)
        }
    }
    
    func submitAnswer() {
        guard let userAnswerInt = Int(userAnswer) else { return }
        
        if userAnswerInt == questions[currentQuestion].answer {
            score += 1
        }
        
        userAnswer = ""
        
        if currentQuestion < numberOfQuestions - 1 {
            currentQuestion += 1
        } else {
            gameOver = true
        }
    }
    
    func restartGame() {
        gameStarted = false
        gameOver = false
    }
}

#Preview {
    ContentView()
}
