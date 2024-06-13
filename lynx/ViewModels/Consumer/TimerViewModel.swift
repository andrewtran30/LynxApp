//
//  TimerViewModel.swift
//  lynx
//
//  Created by Andrew Tran on 8/18/22.
//

import Foundation
import Firebase

extension CurrentOrderCell {
    final class TimerViewModel: ObservableObject {
        @Published var isActive = false
//        @Published var showingAlert = false
        @Published var time: String = "5:00"
        @Published var minutes: Float = 5.0 {
            didSet {
                self.time = "\(Int(minutes))"
            }
        }
        
        private var initialTime = 0
        private var endDate = Date()
        
        func start(minutes: Float) {
            self.initialTime = Int(minutes)
            self.endDate = Date()
            self.isActive = true
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
        }
        
        func reset() {
            self.minutes = Float(initialTime)
            self.isActive = false
            self.time = "\(Int(minutes)):00"
        }
        
        func updateCountdown() {
            guard isActive else { return }
            
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if diff <= 0 {
                self.isActive = false
                self.time = "0:00"
//                self.showingAlert = true
                return
            }
            
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            
            self.minutes = Float(minutes)
            self.time = String(format: "%d:%02d", minutes, seconds)
        }
        
    }
}


//extension Timestamp {
//
//    static func - (leftHandSide: Timestamp, rightHandSide: Timestamp) -> Int64 {
//        return leftHandSide.seconds - rightHandSide.seconds
//    }
//
//}
