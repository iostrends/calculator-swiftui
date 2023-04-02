//
//  ContentView.swift
//  Calculator SwiftUI
//
//  Created by mohammad ali panhwar on 02/04/2023.
//

import SwiftUI

enum CalculatorButton: String{
    case zero, one, two, three, four, five, six, seven, eight, nine
    case multiply, add, divide, subtract, equals
    case decimal
    case ac, plusMinus, percent
    
    var backgroundColor: Color{
        switch self {
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        case .divide, .multiply, .subtract, .add, .equals:
            return Color(.orange)
        default:
            return Color(.darkGray)
        }
    }
    
    var title: String{
        switch self{
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .multiply: return "X"
        case .add: return "+"
        case .divide: return "/"
        case .subtract: return "-"
        case .equals: return "="
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .decimal: return "."
        default:
            return "AC"
        }
    }
    
}

class GlobalEnvironment: ObservableObject{
    @Published var display = ""
    
    func recieveInput(calculatorButton: CalculatorButton){
        self.display = calculatorButton.title
    }
}

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equals]
    ]
    
    
    var body: some View {
        ZStack (alignment: .bottom){
            Color.black.edgesIgnoringSafeArea(.all)
            VStack (spacing: 12) {
                HStack{
                    Spacer()
                    Text(env.display)
                        .font(.system(size:  64))
                        .foregroundColor(.white)
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack{
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
}

struct CalculatorButtonView: View{
    
    var button: CalculatorButton
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Button {
            env.recieveInput(calculatorButton: button)
        } label: {
            Text(button.title)
                .font(.system(size: 32))
                .frame(width: buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(buttonWidth(button: button))
        }
    }
    
    func buttonWidth(button: CalculatorButton) -> CGFloat{
        if button == .zero{
            return (UIScreen.main.bounds.width - 5 * 12) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
