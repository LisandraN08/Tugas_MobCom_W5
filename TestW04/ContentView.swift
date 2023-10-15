//
//  ContentView.swift
//  TestW04
//
//  Created by MacBook Pro on 14/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var asean = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"]
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var isAnswerCorrect = false
    @State private var showingAlert = false
    
    @State private var leftSideFlags = [Int]()
    @State private var rightSideFlags = [Int]()
    
    var body: some View {
        Text("ASEAN FLAGS GAME")
            .fontWeight(.bold)
            .font(.title)
            .foregroundColor(.black)
        
        ZStack {
            Color.pink
                .ignoresSafeArea()
            VStack {
                if currentQuestionIndex < asean.count {
                    Text("Pilih Bendera dari Negara : ")
                        .foregroundColor(.white)
                    Text(asean[currentQuestionIndex])
                        .foregroundColor(.white)
                } else {
                    Text("Permainan Selesai")
                        .foregroundColor(.white)
                    Text("Skor Anda: \(score)")
                        .foregroundColor(.white)
                    
                    Button(action: {
                        restartGame()
                    }) {
                        Text("Restart")
                            .padding(10)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .frame(width: 800, height: 250)
        
        HStack {
            Spacer()
            VStack {
                ForEach(leftSideFlags, id: \.self) { number in Button(action: {
                        self.checkAnswer(number)
                    }) {
                        Image(asean[number])
                            .resizable()
                            .frame(width: 105, height: 65)
                    }
                }
            }
            Spacer()
            VStack {
                ForEach(rightSideFlags, id: \.self) { number in Button(action: {
                        self.checkAnswer(number)
                    }) {
                        Image(asean[number])
                            .resizable()
                            .frame(width: 105, height: 65)
                    }
                }
            }
            Spacer()
        }
        
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(isAnswerCorrect ? "Jawaban Benar" : "Jawaban Salah"), message: Text("Skor Anda: \(score)"), dismissButton: .default(Text("Lanjut")) {
                self.showNextQuestion()
            })
        }
        .onAppear {
            self.shuffleQuestions()
        }
    }
    
    func checkAnswer(_ selectedFlagIndex: Int) {
        if currentQuestionIndex < asean.count {
            if selectedFlagIndex == currentQuestionIndex {
                score += 1
                isAnswerCorrect = true
            } else {
                isAnswerCorrect = false
            }
            showingAlert = true
        }
    }
    
    func shuffleQuestions() {
        leftSideFlags = Array(0..<5).shuffled()
        rightSideFlags = Array(5..<10).shuffled()
    }
    
    func showNextQuestion() {
        currentQuestionIndex += 1
        shuffleQuestions() // Mengacak flags setiap kali soal berganti
    }
    func restartGame() {
            currentQuestionIndex = 0
            score = 0
            isAnswerCorrect = false
            showingAlert = false
            shuffleQuestions()
            asean.shuffle()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
