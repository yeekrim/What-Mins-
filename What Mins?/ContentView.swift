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
    @State private var targetTimeWorkItem: DispatchWorkItem?

    var body: some View {
        
        VStack{
            // Language Swap
            Group {
                HStack {
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
                    if !isUpdatingTime {
                        Button(action: {
                            if (selectedInterval > 1) {
                                selectedInterval -= 1
                            }
                        }, label: {
                            Image(systemName: "arrowtriangle.backward")
                                .foregroundColor(.black)
                                .font(.title2)
                        })
                    }
                    
                    Button(action: {
                        if isUpdatingTime {
                            stopUpdatingTime()
                        } else {
                            startUpdatingTime()
                        }
                    }) {
                        if isUpdatingTime {
                            Text("Stop")
                                .bold()
                                .font(.largeTitle)
                        } else {
                            Text("Rush!")
                                .bold()
                                .font(.largeTitle)
                        }
                    }
                    .foregroundColor(isUpdatingTime ? .red : .green)
                    
                    if !isUpdatingTime {
                        Button(action: {
                            selectedInterval += 1
                        }, label: {
                            Image(systemName: "arrowtriangle.forward")
                                .foregroundColor(.black)
                                .font(.title2)
                        })
                    }
                    
                }
                
                Spacer()
                    .frame(height : 50)
                            
                // Quick Button
                Group {
                    VStack {
                        HStack {
                            Button(action : {
                                selectedInterval = 1
                            }, label : {
                                Text("1m")
                            })
                            
                            Button(action : {
                                selectedInterval = 5
                            }, label : {
                                Text("5m")
                            })
                            
                            Button(action : {
                                selectedInterval = 10
                            }, label : {
                                Text("10m")
                            })
                        }
                        
                        Spacer()
                            .frame(height:20)
                        
                        HStack {
                            Button(action : {
                                selectedInterval = 20
                            }, label : {
                                Text("20m")
                            })
                            
                            Button(action : {
                                selectedInterval = 30
                            }, label : {
                                Text("30m")
                            })
                            
                            Button(action : {
                                selectedInterval = 60
                            }, label : {
                                Text("60m")
                            })
                        }
                    }
                    .opacity(isUpdatingTime ? 0.0 : 1.0)
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

    // 현재시각 표시
    func updateTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        currentTime = formatter.string(from: Date())

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            updateTime()
        }
    }

    // Start Btn -> 지정 인터벌에 따른 음성 생성 및 재생
    func startUpdatingTime() {
        stopUpdatingTime() // Stop previous updates if any
        isUpdatingTime = true
        updateTargetTime()
        print("startUpdatingTime - targetTimeWorkItem: \(String(describing: targetTimeWorkItem))")
    }

    // Stop Btn ->
    func stopUpdatingTime() {
        isUpdatingTime = false
        targetTimeWorkItem?.cancel()
        targetTimeWorkItem = nil
        print("stopUpdatingTime - targetTimeWorkItem: \(String(describing: targetTimeWorkItem))")
    }

    //
    func updateTargetTime() {
        let calendar = Calendar.current
        let currentComponents = calendar.dateComponents([.hour, .minute, .second], from: Date())

        guard let currentHour = currentComponents.hour,
                let currentMinute = currentComponents.minute else {
            return
        }

        var nextTargetMinute = (currentMinute + selectedInterval) % 60
        var nextTargetHour = currentHour
        
        if nextTargetMinute >= 60 {
            nextTargetHour += 1
            nextTargetMinute %= 60
        }
        
        if nextTargetHour >= 24 {
            nextTargetHour %= 24
        }
        
        let targetTime = calendar.date(bySettingHour: currentHour, minute: nextTargetMinute, second: 0, of: Date())!
        let timeDiff = targetTime.timeIntervalSinceNow
            targetTimeWorkItem = DispatchWorkItem {
                if isUpdatingTime {
                    speakCurrentTime()
                    updateTargetTime()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + timeDiff, execute: targetTimeWorkItem!)
        }

    func speakCurrentTime() {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            let timeString = formatter.string(from: Date())
        DetectMuteMode { muteMode in
            if muteMode {
                speechSynthesizer.vibrate()
            } else {
                speechSynthesizer.speak(timeString)
            }
        }
    }
    
    func DetectMuteMode(completion: @escaping (Bool) -> Void) {
            SKMuteSwitchDetector.checkSwitch { (success: Bool, silent: Bool) in
                let muteMode = success && silent
                completion(muteMode)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
