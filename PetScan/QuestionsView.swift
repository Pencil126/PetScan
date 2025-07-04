//
//  QuestionsView.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/7/4.
//

import SwiftUI

struct Question {
    let id: Int
    let text: String
    let options: [String]
    let correctAnswer: Int
}

struct QuestionsView: View {
    
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    let selectedColor: Color = Color(red: 103/255, green: 118/255, blue: 121/255)
    
    @State private var selectedAnswer = 0
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var isAnswered = false
    @State private var showResult = false
    
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }
    
    let questions = [
        Question(
            id: 1,
            text: "下列何者是狗狗可以吃的東西？",
            options: ["巧克力", "雞骨頭", "無調味肉乾"],
            correctAnswer: 3
        ), Question(
            id: 2,
            text: "狗狗每天要睡多久？",
            options: ["6~8小時", "8~10小時", "10~15小時"],
            correctAnswer: 3
        ), Question(
            id: 3,
            text: "為什麼狗狗的鼻子總是溼溼的？",
            options: ["一直喝水", "增加嗅覺", "舌頭舔的"],
            correctAnswer: 2
        )
    ]
    
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                themeColor
                
                if showResult {
                    resultView
                } else {
                    questionView
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("常識問答")
                        .font(.system(size: 24))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(currentQuestionIndex + 1)/\(questions.count)")
                        .font(.system(size: 16))
                        .foregroundColor(selectedColor)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var questionView: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350,height: 258)
                    .foregroundStyle(.white)
                
                HStack(alignment: .top){
                    Text("Q.")
                        .font(.system(size: 32))
                    Text(currentQuestion.text)
                        .font(.system(size: 32))
                        .multilineTextAlignment(.leading)
                }
                .frame(width: 330,alignment: .center)
                
                if isAnswered {
                    if selectedAnswer == currentQuestion.correctAnswer {
                        Circle()
                            .frame(width: 150)
                            .foregroundStyle(.clear)
                            .overlay(
                                Circle()
                                    .stroke(.green,lineWidth: 45)
                            )
                    } else {
                        Image(systemName: "cross.fill")
                            .resizable()
                            .rotationEffect(.degrees(45))
                            .foregroundStyle(.red)
                            .frame(width: 180,height: 180)
                    }
                }
            }
            
            ForEach(Array(currentQuestion.options.enumerated()), id: \.offset) { index, option in
                answerButton(
                    letter: String(Character(UnicodeScalar(65 + index)!)),
                    text: option,
                    answerIndex: index + 1
                )
                .padding(4)
            }
            
            if isAnswered {
                nextButton
                    .padding(.top, 20)
            }else {
                Rectangle()
                    .frame(width: 350, height: 65)
                    .foregroundStyle(themeColor)
                    .padding(.top, 20)
            }
        }
    }
    
    func buttonColor(for answerIndex: Int) -> Color {
        if !isAnswered {
            return selectedColor
        }
        
        if answerIndex == currentQuestion.correctAnswer {
            return .green
        } else if answerIndex == selectedAnswer && selectedAnswer != currentQuestion.correctAnswer {
            return .red
        } else {
            return Color(red: 226/255, green: 233/255, blue: 233/255)
        }
    }
    
    func answerButton(letter: String, text: String, answerIndex: Int) -> some View {
        Button{
            if !isAnswered {
                selectedAnswer = answerIndex
                isAnswered = true
                
                if selectedAnswer == currentQuestion.correctAnswer {
                    score += 1
                }
            }
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 350, height: 70)
                    .foregroundStyle(buttonColor(for: answerIndex))
                
                HStack{
                    Text(letter)
                        .foregroundStyle(.white)
                        .font(.system(size: 32))
                    Spacer()
                    Text(text)
                        .foregroundStyle(.white)
                        .font(.system(size: 32))
                    Spacer()
                }
                .frame(width: 300, height: 70)
            }
        }
        .disabled(isAnswered)
    }
    
    var nextButton: some View {
        Button {
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
                selectedAnswer = 0
                isAnswered = false
            } else {
                showResult = true
            }
        } label: {
            Text(currentQuestionIndex < questions.count - 1 ? "下一題" : "查看結果")
                .foregroundStyle(.white)
                .frame(width: 350, height: 65)
                .font(.system(size: 24))
                .background(selectedColor)
                .clipShape(RoundedRectangle(cornerRadius: 50))
        }
    }
    
    var resultView: some View {
        let percentage = Double(score) / Double(questions.count) * 100
        
        return VStack(spacing: 30) {
            Text("測驗完成！")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(selectedColor)
            
            VStack(spacing: 10) {
                Text("你的得分")
                    .font(.system(size: 24))
                    .foregroundColor(selectedColor)
                
                Text("\(score)/\(questions.count)")
                    .font(.system(size: 60, weight: .black))
                    .foregroundColor(Color(red: 207/255, green: 116/255, blue: 65/255))
                
                Text(String(format: "%.0f%%", percentage))
                    .font(.system(size: 24))
                    .foregroundColor(selectedColor)
            }
            
            VStack(spacing: 10) {
                if percentage >= 80 {
                    Text("🎉 優秀")
                        .font(.system(size: 32))
                        .foregroundColor(selectedColor)
                    Text("你對寵物照護知識很了解！")
                        .font(.system(size: 18))
                        .foregroundColor(selectedColor)
                } else if percentage >= 60 {
                    Text("👍 不錯")
                        .font(.system(size: 32))
                        .foregroundColor(selectedColor)
                    Text("還有進步空間，繼續加油！")
                        .font(.system(size: 18))
                        .foregroundColor(selectedColor)
                } else {
                    Text("💪 加油")
                        .font(.system(size: 32))
                        .foregroundColor(selectedColor)
                    Text("多了解一些寵物知識會更好喔！")
                        .font(.system(size: 18))
                        .foregroundColor(selectedColor)
                }
            }
            
            Button {
                currentQuestionIndex = 0
                selectedAnswer = 0
                score = 0
                isAnswered = false
                showResult = false
            } label: {
                Text("重新測驗")
                    .foregroundStyle(.white)
                    .frame(width: 300, height: 50)
                    .font(.system(size: 20))
                    .background(selectedColor)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
            }
        }
        .padding()
    }
}

#Preview {
    TabBarView(tabViewSelection: 3)
}
