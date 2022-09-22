//
//  ContentView.swift
//  Whistle Timer
//
//  Created by Cam Way on 2022-09-20.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var viewModel = ParameterViewModel()
    @State var backgroundColor = Color.white
    var blue = Color(red: 24/255, green: 79/255, blue: 168/255)
    var green = Color(red: 0, green: 200/255, blue: 0)
    var red = Color.red
    
    var body: some View {
        ZStack{
            backgroundColor.ignoresSafeArea()
            VStack {
                HStack {
                    Text("Whistle Timer")
                        .bold()
                        .font(.largeTitle)
                        .padding(.bottom, 10)
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity)
                .background(blue)
                Spacer()
                Button(action: {
                    if(!viewModel.isRunning) {
                        viewModel.isRunning = !viewModel.isRunning;
                        // set face off time
                        viewModel.setRandomTime()
                        // start timer
                        createTimer()
                    } else {
                        // end timer
                        viewModel.isRunning = false
                    }
                }, label: {
                    Text(viewModel.isRunning ? "End" : "Start")
                        .font(.title)
                        .bold()
                        .padding(40)
                        .background(viewModel.isRunning ? red : green)
                        .foregroundColor(Color.white)
                })
                .cornerRadius(100)

                
                Spacer()
                if(!viewModel.isRunning){
                    Divider().padding()
                    ParameterEditorView(viewModel: viewModel)
                }
            }
        }
        .foregroundColor(Color.black)

    }
    
    
    func createTimer() {
        Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true,
            block: {timer in
                if(viewModel.faceOffTime > 0){
                    viewModel.faceOffTime -= 1
                    backgroundColor = backgroundColor == Color.white ? blue : Color.white
                } else if viewModel.faceOffTime == 0 { // sound whistle / show red screen
                    backgroundColor = Color.red
                    viewModel.playWhistle()
                    viewModel.faceOffTime = -1
                } else { // restart with new timer
                    backgroundColor = Color.white
                    viewModel.setRandomTime()
                }
                
                if(viewModel.isRunning == false){ // User has stopped the timer
                    timer.invalidate()
                    backgroundColor = Color.white
                }
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
