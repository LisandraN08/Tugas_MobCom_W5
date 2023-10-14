//
//  ContentView.swift
//  TestW04
//
//  Created by MacBook Pro on 14/10/23.
//

import SwiftUI

struct ContentView: View {
    
    var asean = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"]
    
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var isAnswerCorrect = false
    @State private var showingAlert = false
    @State private var shuffledQuestions = [Int]()
    
    var body: some View {
        Text("ASEAN FLAGS GAME")
            .fontWeight(.bold)
            .font(.title)
            .foregroundColor(.black)
        
        ZStack {
            Color.pink
                .ignoresSafeArea()
            VStack {
                if currentQuestionIndex < shuffledQuestions.count {
                    Text("Pilih Bendera dari Negara : ")
                        .foregroundColor(.white)
                    Text(asean[shuffledQuestions[currentQuestionIndex]])
                        .foregroundColor(.white)
                } else {
                    Text("Permainan Selesai")
                        .foregroundColor(.white)
                    Text("Skor Anda: \(score)")
                        .foregroundColor(.white)
                }
            }
        }
        .frame(width: 800, height: 250)
        
        HStack {
            Spacer()
            VStack {
                ForEach(0..<5) { number in
                    Button(action: {
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
                ForEach(5..<10) { number in
                    Button(action: {
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
            if currentQuestionIndex >= asean.count {
                return Alert(title: Text("Selamat!"), message: Text("Skor Anda: \(score)"), dismissButton: .default(Text("Selesai")) {
                })
            } else {
                return Alert(title: Text(isAnswerCorrect ? "Jawaban Benar" : "Jawaban Salah"), message: Text("Skor Anda: \(score)"), dismissButton: .default(Text("Lanjut")) {
                    self.showNextQuestion()
                })
            }
        }
        .onAppear {
            self.shuffleQuestions()
        }
    }
        
    func checkAnswer(_ selectedFlagIndex: Int) {
        if currentQuestionIndex < shuffledQuestions.count {
            if selectedFlagIndex == shuffledQuestions[currentQuestionIndex] {
                score += 1
                isAnswerCorrect = true
            } else {
                isAnswerCorrect = false
            }
            showingAlert = true
        }
    }
    
    func shuffleQuestions() {
        shuffledQuestions = Array(0..<asean.count).shuffled()
    }
    
    func showNextQuestion() {
        currentQuestionIndex += 1
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
