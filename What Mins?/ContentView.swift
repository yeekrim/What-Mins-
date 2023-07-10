//
//  ContentView.swift
//  What Mins?
//
//  Created by 길지훈 on 2023/06/01.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentTime: String = ""
    @State private var selectedInterval: Int = 1
    @State private var isUpdatingTime = false
    @State private var selectedLanguage: String = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "ko-KR"
    @State private var targetTimeWorkItem: DispatchWorkItem?
    @StateObject private var speechSynthesizer = SpeechSynthesizer()

    var body: some View {
        
        VStack{
            // Language Swap
            Group {
                HStack {
                    Menu {
                        Section("Country Language Settings") {
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("ko-KR")
                                selectedLanguage = "ko-KR"
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                Label("한국어", systemImage: selectedLanguage == "ko-KR" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("en-US")
                                selectedLanguage = "en-US"
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                Label("English(US)", systemImage: selectedLanguage == "en-US" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("en-UK")
                                selectedLanguage = "en-UK"
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                Label("English(UK)", systemImage: selectedLanguage == "en-UK" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("es-ES")
                                selectedLanguage = "es-ES"
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                Label("Espagnol", systemImage: selectedLanguage == "es-ES" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("zh-CN")
                                selectedLanguage = "zh-CN"
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                Label("中文", systemImage: selectedLanguage == "zh-CN" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("ja-JP")
                                selectedLanguage = "ja-JP"
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                Label("日本語", systemImage: selectedLanguage == "ja-JP" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("de-DE")
                                selectedLanguage = "de-DE"
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                Label("Deutsch", systemImage: selectedLanguage == "de-DE" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("fr-FR")
                                selectedLanguage = "fr-FR"
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                Label("Français", systemImage: selectedLanguage == "fr-FR" ? "checkmark" : "")
                            }
                            
                            Button(action: {
                                speechSynthesizer.updateSelectedLanguage("it-IT")
                                selectedLanguage = "it-IT"
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                Label("Lingua italiana", systemImage: selectedLanguage == "it-IT" ? "checkmark" : "")
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
                    .font(.system(size: 50))
                    .fontWeight(.light)
                    .padding()
                
                HStack {
                    Text("Interval:")
                        .padding(.top, 3.0)
                        .font(.title2)
                    
                    Text("\(selectedInterval)")
                        .font(.title)
                    
                    Text("Min")
                        .padding(.top, 3.0)
                        .font(.title2)
                }
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
                            Text("Start")
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
                            Button(action: {
                                selectedInterval = 1
                            }, label: {
                                Text("1m")
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
                            })
                            .offset(x:-40,y:0)
                            
                            Button(action : {
                                selectedInterval = 3
                            }, label : {
                                Text("3m")
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
                            })
                            .offset(x:0,y:0)
                            
                            Button(action : {
                                selectedInterval = 5
                            }, label : {
                                Text("5m")
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
                            })
                            .offset(x:40,y:0)
                        }
                        
                        Spacer()
                            .frame(height:20)
                        
                        HStack {
                            Button(action : {
                                selectedInterval = 10
                            }, label : {
                                Text("10m")
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
                                
                            })
                            .offset(x:-23,y:0)
                            
                            Button(action : {
                                selectedInterval = 30
                            }, label : {
                                Text("30m")
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
                            })
                            
                            Button(action : {
                                selectedInterval = 60
                            }, label : {
                                Text("60m")
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
                            })
                            .offset(x:25,y:0)
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
        .onAppear {
            // 앱 시작 시 선택된 언어를 복원
            if let storedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") {
                selectedLanguage = storedLanguage
            }
            print("Current Language: \(selectedLanguage)")
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
    }

    // Stop Btn -> 생성된 인터벌객체 중지 및 제거
    func stopUpdatingTime() {
        isUpdatingTime = false
        targetTimeWorkItem?.cancel()
        targetTimeWorkItem = nil
    }

    // nextTarget을 조정하여 생성
    func updateTargetTime() {
        let calendar = Calendar.current
        let currentComponents = calendar.dateComponents([.hour, .minute, .second], from: Date())

        guard let currentHour = currentComponents.hour,
                let currentMinute = currentComponents.minute else {
            return
        }
        
        var nextTargetMinute = (currentMinute + selectedInterval)
        var nextTargetHour = currentHour
    
        if nextTargetMinute >= 60 {
            nextTargetHour += 1
            nextTargetMinute %= 60
        }
        
        if nextTargetHour == 24 {
            nextTargetHour = 0
        }
        
        let targetTime = calendar.date(bySettingHour: nextTargetHour, minute: nextTargetMinute, second: 0, of: Date())!
        let timeDiff = targetTime.timeIntervalSinceNow
            targetTimeWorkItem = DispatchWorkItem {
            if isUpdatingTime {
                speakCurrentTime()
                updateTargetTime()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + timeDiff, execute: targetTimeWorkItem!)
        print("nextTarget Hour: \(nextTargetHour)")
        print("nextTarget Min: \(nextTargetMinute)")
    }

    // 무음모드 여부를 판단하여 소리 or 진동 출력
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
    
    // 무음모드 여부 판단
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
