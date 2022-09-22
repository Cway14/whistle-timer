//
//  ParameterEditorView.swift
//  Whistle Timer
//
//  Created by Cam Way on 2022-09-20.
//

import SwiftUI

struct ParameterEditorView: View {
    @StateObject var viewModel: ParameterViewModel
    var body: some View {
        VStack{
            HStack{
                Text("Shortest Time")
                Slider(
                    value: $viewModel.shortestTime,
                    in: 3...viewModel.longestTime,
                    step: 1
                )
                Text("\(viewModel.shortestTime, specifier: "%.0f")")
            }.padding()
            HStack{
                Text("Longest Time")
                Slider(
                    value: $viewModel.longestTime,
                    in: viewModel.shortestTime...20,
                    step: 1
                )
                Text("\(viewModel.longestTime, specifier: "%.0f")")

            }.padding()
        }
    }
}

struct ParameterEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ParameterEditorView(viewModel: ParameterViewModel())
    }
}
