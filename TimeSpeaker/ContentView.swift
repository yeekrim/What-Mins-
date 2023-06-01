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
    let speechSynthesizer = SpeechSynthesizer()

    var body: some View {
        VStack{
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

            

            
        }
        .onAppear {
            updateTime()
        }
    }

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
