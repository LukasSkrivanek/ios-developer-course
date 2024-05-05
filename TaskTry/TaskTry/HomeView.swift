//
//  ContentView.swift
//  TaskTry
//
//  Created by macbook on 27.04.2024.
//
import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel
    var body: some View {
        HSplitView {
            inputLeftPanel
            outputRightPanel
        }
        .padding()
    }
    
    @ViewBuilder
    private var inputLeftPanel: some View {
        VStack{
            Text("Input for your script: ")
            TextField("", text: $viewModel.filePath)
                .placeholder(when: viewModel.filePath.isEmpty) {
                    Text("Type your path for script").foregroundColor(.gray)
                }
                .foregroundStyle(.black)
                .background(Color.white)
                .disabled(!viewModel.scriptText.isEmpty)
                .padding(.horizontal)
            
            VStack{
                TextView(text: $viewModel.scriptText, coloredStrings: viewModel.coloredStrings)
                    .frame(minWidth: 200, idealWidth: 400, minHeight: 200, idealHeight: 600)
                    .padding()
                
            }
        }
    }
    @ViewBuilder
    private var outputRightPanel: some View {
        VStack {
            Text("Run Script")
                .buttonBorderShape(.automatic)
                .disabled(viewModel.isRunning)
                .onTapGesture {
                    viewModel.executeScript()
                    viewModel.lastExitCodeVisible = true
                }
                .padding(.vertical, 5)
            if  viewModel.lastExitCodeVisible && !viewModel.isRunning{
                Text("Last Exit Code: \(viewModel.lastExitCode)")
                    .foregroundColor(viewModel.lastExitCode != 0 ? .red : .green)
            }
            TextEditor(text: $viewModel.outputText)
                .frame(minWidth: 200, idealWidth: 400, minHeight: 200, idealHeight: 600)
                .disabled(true)
                .foregroundStyle(.black)
                .scrollContentBackground(.hidden)
                .background(Color.white)
                .overlay {
                    if viewModel.isRunning{
                        VStack() {
                            ProgressView {
                                Text("Loading")
                                    .foregroundColor(.pink)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .progressViewStyle(.linear)
                        }
                    }
                }
        }
    }
}

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView(viewModel: HomeViewModel())
        }
    }

