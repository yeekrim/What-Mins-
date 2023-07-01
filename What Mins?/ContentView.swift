//
//  ContentView.swift
//  What Mins?
//
//  Created by 길지훈 on 2023/06/01.
//

import SwiftUI

struct ContentView: View {
    //@State 속성은 값이 변경될 때마다 뷰를 새로 그리는 기능을 한다.
    @State private var currentTime: String = ""
    @State private var selectedInterval: Int = 1
    @State private var isUpdatingTime = false
    @StateObject private var speechSynthesizer = SpeechSynthesizer()
    @State private var selectedLanguage: String = "ko-KR"

    var body: some View {
        
        VStack{
            // Language Swap
            Group {
                HStack {
                    Spacer()
                    Menu {
                        Section("Set your voice language") {
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("ko-KR")
                                selectedLanguage = "ko-KR"
                            }) {
                                Label("Korean", systemImage: selectedLanguage == "ko-KR" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("en-US")
                                selectedLanguage = "en-US"
                            }) {
                                Label("English(US)", systemImage: selectedLanguage == "en-US" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("en-UK")
                                selectedLanguage = "en-UK"
                            }) {
                                Label("English(UK)", systemImage: selectedLanguage == "en-UK" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("es-ES")
                                selectedLanguage = "es-ES"
                            }) {
                                Label("Spanish", systemImage: selectedLanguage == "es-ES" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("zh-CN")
                                selectedLanguage = "zh-CN"
                            }) {
                                Label("Chinese", systemImage: selectedLanguage == "zh-CN" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("ja-JP")
                                selectedLanguage = "ja-JP"
                            }) {
                                Label("Japanese", systemImage: selectedLanguage == "ja-JP" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("de-DE")
                                selectedLanguage = "de-DE"
                            }) {
                                Label("German", systemImage: selectedLanguage == "de-DE" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("fr-FR")
                                selectedLanguage = "fr-FR"
                            }) {
                                Label("French", systemImage: selectedLanguage == "fr-FR" ? "checkmark" : "")
                            }
                        }
                        
                    } label: {
                        Label("Language", systemImage: "globe")
                    }
                    .padding(7)
                    .padding(.leading, -3.0)
                    .padding(.vertical, -5.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    
                    .imageScale(.large)
                    .foregroundColor(.black)
                    .padding([.trailing], 30)
                    .padding(.top, 20)
                }
            }
            
            Spacer()
            
            // Time & Control
            Group {
                Text("⚡️Activating⚡️")
                    .font(.subheadline)
                    .bold()
                    .italic()
                    .opacity(isUpdatingTime ? 1.0 : 0.0)
                
                Text(currentTime)
                    .font(.largeTitle)
                    .padding()
                
                Text("Interval: \(selectedInterval) min" + (selectedInterval > 1 ? "s" : ""))
                    .padding()
                    .bold()
                
                HStack {
                    Button(action: {
                        if (selectedInterval > 1) {
                            selectedInterval -= 1
                        }
                    }, label: {
                        Image(systemName: "minus.circle")
                    })
                    
                    Button(action: {
                        startUpdatingTime()
                    }, label: {
                        Text("Start")
                    })
                    
                    Button(action: {
                        stopUpdatingTime()
                    }, label: {
                        Text("Stop")
                    })
                    
                    Button(action: {
                        selectedInterval += 1
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                    
                }
                
                Spacer()
                Spacer()
                
                    .onAppear {
                        updateTime()
                    }
            }
            
        }
        .onChange(of: selectedLanguage) { newValue in
            print("Selected Language: \(newValue)")
        }
        
    }

    // functions
    func updateTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        currentTime = formatter.string(from: Date())

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            updateTime()
        }
    }

    func startUpdatingTime() {
        stopUpdatingTime() // Stop previous updates if any
        isUpdatingTime = true
        updateTargetTime()
    }

    func stopUpdatingTime() {
        isUpdatingTime = false
    }

    func updateTargetTime() {
        let calendar = Calendar.current
        let currentComponents = calendar.dateComponents([.hour, .minute, .second], from: Date())
        guard let currentHour = currentComponents.hour,
              let currentMinute = currentComponents.minute else {
            return
        }

        let nextTargetMinute = (currentMinute + selectedInterval) % 60
        let targetTime = calendar.date(bySettingHour: currentHour, minute: nextTargetMinute, second: 0, of: Date())!

        let timeDiff = targetTime.timeIntervalSinceNow
        DispatchQueue.main.asyncAfter(deadline: .now() + timeDiff) {
            if self.isUpdatingTime {
                self.speakCurrentTime()
                self.updateTargetTime()
            }
        }
    }

    func speakCurrentTime() {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            let timeString = formatter.string(from: Date())
            speechSynthesizer.speak(timeString)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
