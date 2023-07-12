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
    @State private var selectedLanguage: String = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en-US"
    @State private var targetTimeWorkItem: DispatchWorkItem?
    @StateObject private var speechSynthesizer = SpeechSynthesizer()
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("sectionText") var sectionText: String = UserDefaults.standard.string(forKey: "sectionText") ?? "Country Language Settings"
    @AppStorage("LangText") var LangText: String = UserDefaults.standard.string(forKey: "LangText") ?? "Language"
    @AppStorage("ActText") var ActText: String = UserDefaults.standard.string(forKey: "ActText") ?? "⚡️ Activating ⚡️"
    @AppStorage("InvText") var InvText: String = UserDefaults.standard.string(forKey: "InvText") ?? "Interval:"
    @AppStorage("MinText") var MinText: String = UserDefaults.standard.string(forKey: "MinText") ?? "Min"
    @AppStorage("StartText") var StartText: String = UserDefaults.standard.string(forKey: "StartText") ?? "Start"
    @AppStorage("StopText") var StopText: String = UserDefaults.standard.string(forKey: "StopText") ?? "Stop"
    @AppStorage("Text_1m") var Text_1m: String = UserDefaults.standard.string(forKey: "Text_1m") ?? "1m"
    @AppStorage("Text_3m") var Text_3m: String = UserDefaults.standard.string(forKey: "Text_3m") ?? "3m"
    @AppStorage("Text_5m") var Text_5m: String = UserDefaults.standard.string(forKey: "Text_5m") ?? "5m"
    @AppStorage("Text_10m") var Text_10m: String = UserDefaults.standard.string(forKey: "Text_10m") ?? "10m"
    @AppStorage("Text_30m") var Text_30m: String = UserDefaults.standard.string(forKey: "Text_30m") ?? "30m"
    @AppStorage("Text_60m") var Text_60m: String = UserDefaults.standard.string(forKey: "Text_60m") ?? "60m"
    
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = false
    @State private var isFirstPlace: String = ""
    

    var body: some View {
        
        
        
        VStack{
            // Language Swap
            Group {
                HStack {
                    Menu {
                        Section(LocalizedStringKey(sectionText)) {
                            Button(action: {
                                // 한국어
                                isFirstLaunch = true
                                speechSynthesizer.updateSelectedLanguage("ko-KR")
                                selectedLanguage = "ko-KR"
                                sectionText = "국가별 언어 설정 "
                                LangText = "언어 "
                                ActText = "⚡️ 활성화 ⚡️ "
                                InvText = "시간 간격: "
                                MinText = "분 "
                                StartText = "시작 "
                                StopText = "중지 "
                                Text_1m = "1분 "
                                Text_3m = "3분 "
                                Text_5m = "5분 "
                                Text_10m = "10분 "
                                Text_30m = "30분 "
                                Text_60m = "60분 "
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                if selectedLanguage.hasPrefix("ko-") {
                                    Label("한국어", systemImage: "checkmark")
                                } else {
                                    Label("한국어", systemImage: selectedLanguage == "ko-KR" || isFirstPlace == "ko-Kore_US" ? "checkmark" : "")
                                }
                            }
                            
                            Button(action: {
                                // 영어(미국)
                                isFirstLaunch = true
                                speechSynthesizer.updateSelectedLanguage("en-US")
                                selectedLanguage = "en-US"
                                sectionText = "Country Language Settings "
                                LangText = "Language "
                                ActText = "⚡️ Activating ⚡️ "
                                InvText = "Interval: "
                                MinText = "Min "
                                StartText = "Start "
                                StopText = "Stop "
                                Text_1m = "1m "
                                Text_3m = "3m "
                                Text_5m = "5m "
                                Text_10m = "10m "
                                Text_30m = "30m "
                                Text_60m = "60m "
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                if selectedLanguage.hasPrefix("en-US") {
                                    Label("English(US)", systemImage: "checkmark")
                                } else {
                                    Label("English(US)", systemImage: selectedLanguage == "en-US" || Locale.current.identifier == "en_US" ? "checkmark" : "")
                                }
                            }
                            
                            Button(action: {
                                // 영어(영국)
                                isFirstLaunch = true
                                speechSynthesizer.updateSelectedLanguage("en-UK")
                                selectedLanguage = "en-UK"
                                sectionText = "Country Language Settings "
                                LangText = "Language "
                                ActText = "⚡️ Activating ⚡️ "
                                InvText = "Interval: "
                                MinText = "Min "
                                StartText = "Start "
                                StopText = "Stop "
                                Text_1m = "1m "
                                Text_3m = "3m "
                                Text_5m = "5m "
                                Text_10m = "10m "
                                Text_30m = "30m "
                                Text_60m = "60m "
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                if selectedLanguage.hasPrefix("en-UK") {
                                    Label("English(UK)", systemImage: "checkmark")
                                } else {
                                    Label("English(UK)", systemImage: selectedLanguage == "en-UK" || isFirstPlace == "en_UK" ? "checkmark" : "")
                                }
                            }
                            
                            Button(action: {
                                // 스페인어
                                isFirstLaunch = true
                                speechSynthesizer.updateSelectedLanguage("es-ES")
                                selectedLanguage = "es-ES"
                                sectionText = "Configuraciones lingüísticas por país "
                                LangText = "El lenguaje "
                                ActText = "⚡️ activación ⚡️ "
                                InvText = "Intervalo: "
                                MinText = "Min "
                                StartText = "Comienzo "
                                StopText = "Detente. "
                                Text_1m = "1m "
                                Text_3m = "3m "
                                Text_5m = "5m "
                                Text_10m = "10m "
                                Text_30m = "30m "
                                Text_60m = "60m "
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                if selectedLanguage.hasPrefix("es-ES") {
                                    Label("Espagnol", systemImage: "checkmark")
                                } else {
                                    Label("Espagnol", systemImage: selectedLanguage == "es-ES" || isFirstPlace == "es_ES" ? "checkmark" : "")
                                }
                            }
                            
                            Button(action: {
                                // 중국어(홍콩기준)
                                isFirstLaunch = true
                                speechSynthesizer.updateSelectedLanguage("zh-CN")
                                selectedLanguage = "zh-CN"
                                sectionText = "国家语言设置 "
                                LangText = "语文 "
                                ActText = "⚡️ 启动 ⚡️ "
                                InvText = "间隙: "
                                MinText = "分 "
                                StartText = "开始 "
                                StopText = "中止 "
                                Text_1m = "1分 "
                                Text_3m = "3分 "
                                Text_5m = "5分 "
                                Text_10m = "10分 "
                                Text_30m = "30分 "
                                Text_60m = "60分 "
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                if selectedLanguage.hasPrefix("zh-") {
                                    Label("中文", systemImage: "checkmark")
                                } else {
                                    Label("中文", systemImage: (selectedLanguage == "zh-CN" || isFirstPlace == "zh_CN") ? "checkmark" : "")
                                }
                            }
                            
                            Button(action: {
                                // 일본어
                                isFirstLaunch = true
                                speechSynthesizer.updateSelectedLanguage("ja-JP")
                                selectedLanguage = "ja-JP"
                                sectionText = "国別言語設定 "
                                LangText = "げんご "
                                ActText = "⚡️ 活性化 ⚡️ "
                                InvText = "間隔: "
                                MinText = "分 "
                                StartText = "スタート "
                                StopText = "ストップ "
                                Text_1m = "1分 "
                                Text_3m = "3分 "
                                Text_5m = "5分 "
                                Text_10m = "10分 "
                                Text_30m = "30分 "
                                Text_60m = "60分 "
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                if selectedLanguage.hasPrefix("ja-") {
                                    Label("日本語", systemImage: "checkmark")
                                } else {
                                    Label("日本語", systemImage: (selectedLanguage == "ja-JP" || isFirstPlace == "ja_JP") ? "checkmark" : "")
                                }
                            }
                            
                            Button(action: {
                                // 독일어
                                isFirstLaunch = true
                                speechSynthesizer.updateSelectedLanguage("de-DE")
                                selectedLanguage = "de-DE"
                                sectionText = "Spracheinstellungen "
                                LangText = "Sprache "
                                ActText = "⚡️ Aktivieren ⚡️ "
                                InvText = "Intervall: "
                                MinText = "Min "
                                StartText = "Beginn "
                                StopText = "Halt "
                                Text_1m = "1m "
                                Text_3m = "3m "
                                Text_5m = "5m "
                                Text_10m = "10m "
                                Text_30m = "30m "
                                Text_60m = "60m "
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                if selectedLanguage.hasPrefix("de-") {
                                    Label("Deutsch", systemImage: "checkmark")
                                } else {
                                    Label("Deutsch", systemImage: (selectedLanguage == "de-DE" || isFirstPlace == "de_DE") ? "checkmark" : "")
                                }
                            }
                            
                            Button(action: {
                                // 프랑스어
                                isFirstLaunch = true
                                speechSynthesizer.updateSelectedLanguage("fr-FR")
                                selectedLanguage = "fr-FR"
                                sectionText = "établissement des langues "
                                LangText = "Language "
                                ActText = "⚡️ Activation ⚡️ "
                                InvText = "Intervalle: "
                                MinText = "Min "
                                StartText = "Départ "
                                StopText = "Cessation "
                                Text_1m = "1m "
                                Text_3m = "3m "
                                Text_5m = "5m "
                                Text_10m = "10m "
                                Text_30m = "30m "
                                Text_60m = "60m "
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                if selectedLanguage.hasPrefix("fr-") {
                                    Label("Français", systemImage: "checkmark")
                                } else {
                                    Label("Français", systemImage: (selectedLanguage == "fr-FR" || isFirstPlace == "fr_FR") ? "checkmark" : "")
                                }
                            }
                            
                            Button(action: {
                                // 이탈리아어
                                isFirstLaunch = true
                                speechSynthesizer.updateSelectedLanguage("it-IT")
                                selectedLanguage = "it-IT"
                                sectionText = "Impostazione linguistica "
                                LangText = "Lingua "
                                ActText = "⚡️ Attivazione ⚡️ "
                                InvText = "Intervallo: "
                                MinText = "Min "
                                StartText = "princìpio "
                                StopText = "fermare "
                                Text_1m = "1m "
                                Text_3m = "3m "
                                Text_5m = "5m "
                                Text_10m = "10m "
                                Text_30m = "30m "
                                Text_60m = "60m "
                                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                            }) {
                                if selectedLanguage.hasPrefix("it-") {
                                    Label("Lingua italiana", systemImage: "checkmark")
                                } else {
                                    Label("Lingua italiana", systemImage: (selectedLanguage == "it-IT" || isFirstPlace == "it_IT") ? "checkmark" : "")
                                }
                            }
                        }
                        
                    } label: {
                        Label(LocalizedStringKey(LangText), systemImage: "globe")
                    }
                    .onTapGesture {
                        print("\(selectedLanguage)")
                    }
                    .padding(7)
                    .padding(.leading, -3.0)
                    .padding(.vertical, -5.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 2)
                    )
                    .imageScale(.large)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.top, 20)
                }
            }
            
            Spacer()
            
            // Time & Control
            Group {
                Text(LocalizedStringKey(ActText))
                    .font(.title2)
                    .bold()
                    .italic()
                    .opacity(isUpdatingTime ? 1.0 : 0.0)
                
                Text(currentTime)
                    .font(.system(size: 50))
                    .fontWeight(.light)
                    .padding()
                
                HStack {
                    Text(LocalizedStringKey(InvText))
                        .padding(.top, 3.0)
                        .font(.title2)
                    
                    Text("\(selectedInterval)")
                        .font(.title)
                    
                    Text(LocalizedStringKey(MinText))
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
                                .foregroundColor(colorScheme == .dark ? .white : .black)
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
                            Text(LocalizedStringKey(StopText))
                                .bold()
                                .font(.largeTitle)
                        } else {
                            Text(LocalizedStringKey(StartText))
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
                                .foregroundColor(colorScheme == .dark ? .white : .black)
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
                                Text(LocalizedStringKey(Text_1m))
                                    .font(.system(size: 30))
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            })
                            .offset(x:-40,y:0)
                            
                            Button(action : {
                                selectedInterval = 3
                            }, label : {
                                Text(LocalizedStringKey(Text_3m))
                                    .font(.system(size: 30))
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            })
                            .offset(x:0,y:0)
                            
                            Button(action : {
                                selectedInterval = 5
                            }, label : {
                                Text(LocalizedStringKey(Text_5m))
                                    .font(.system(size: 30))
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            })
                            .offset(x:40,y:0)
                        }
                        
                        Spacer()
                            .frame(height:20)
                        
                        HStack {
                            Button(action : {
                                selectedInterval = 10
                            }, label : {
                                Text(LocalizedStringKey(Text_10m))
                                    .font(.system(size: 30))
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                
                            })
                            .offset(x:-23,y:0)
                            
                            Button(action : {
                                selectedInterval = 30
                            }, label : {
                                Text(LocalizedStringKey(Text_30m))
                                    .font(.system(size: 30))
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            })
                            
                            Button(action : {
                                selectedInterval = 60
                            }, label : {
                                Text(LocalizedStringKey(Text_60m))
                                    .font(.system(size: 30))
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
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
                    print("\(String(describing: Locale.current.identifier))")
                    
                    if isFirstLaunch == false {
                        print("first coming! : your place is \(Locale.current.identifier)")
                        selectedLanguage = Locale.current.identifier
                        isFirstPlace = selectedLanguage
                    } else { print(" Hi, old User.")}
                }
            }
            
        }
        .onChange(of: selectedLanguage) { newValue in
            print("Selected Language: \(newValue)")
        }
        
//        .onAppear {
//            // 앱 시작 시 선택된 언어를 복원
//            if let storedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") {
//                selectedLanguage = storedLanguage
//            }
//            if let storedSectionText = UserDefaults.standard.string(forKey: "sectionText") {
//                sectionText = storedSectionText
//            }
//        }
//        .onDisappear {
//            // 뷰가 사라질 때 UserDefaults에 값을 저장
//            UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
//            UserDefaults.standard.set(sectionText, forKey: "sectionText")
//        }
        
    }

    // 현재시각 표시
    func updateTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: selectedLanguage)
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
        Group {
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
