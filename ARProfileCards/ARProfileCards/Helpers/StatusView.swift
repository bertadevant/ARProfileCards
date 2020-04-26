/*
 Copyright © 2019 Apple Inc.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Abstract:
Utility class for showing messages above the AR view.
*/

import Foundation
import ARKit

/**
 Displayed at the top of the main interface of the app that allows users to see
 the status of the AR experience, as well as the ability to control restarting
 the experience altogether.
 - Tag: StatusView
*/
class StatusView: UIView {

    // MARK: - IBOutlets
    
    @IBOutlet weak private var messageLabel: UILabel!
    
    @IBOutlet weak private var restartExperienceButton: UIButton!

    // MARK: - Properties
    
    /// Seconds before the timer message should fade out. Adjust if the app needs longer transient messages.
    private let displayDuration: TimeInterval = 6
    /// Trigerred when the "Restart Experience" button is tapped.
    var restartExperienceHandler: () -> Void = {}
    
    // MARK: - Message Handling
    
    func showMessage(_ text: String) {
        messageLabel.text = text
        messageLabelIsHidden(false)
        
        Timer.scheduledTimer(withTimeInterval: displayDuration, repeats: false, block: { [weak self] timer in
            self?.messageLabelIsHidden(true)
            timer.invalidate()
        })
    }
    
    // MARK: - ARKit
    func showTrackingQualityInfo(for trackingState: ARCamera.TrackingState) {
        showMessage(trackingState.presentationString)
    }
    
    func escalateFeedback(for trackingState: ARCamera.TrackingState) {
        var message = trackingState.presentationString
        if let recommendation = trackingState.recommendation {
            message.append(": \(recommendation)")
        }
        
        self.showMessage(message)
    }
    
    // MARK: - IBActions
    
    @IBAction private func restartExperience(_ sender: UIButton) {
        restartExperienceHandler()
    }
    
    private func messageLabelIsHidden(_ isHidden: Bool) {
        messageLabel.isHidden = isHidden
        backgroundColor = isHidden ? .clear: .white
    }
}

extension ARCamera.TrackingState {
    var presentationString: String {
        switch self {
        case .notAvailable:
            return "TRACKING UNAVAILABLE"
        case .normal:
            return "TRACKING NORMAL"
        case .limited(.excessiveMotion):
            return "TRACKING LIMITED\nExcessive motion"
        case .limited(.insufficientFeatures):
            return "TRACKING LIMITED\nLow detail"
        case .limited(.initializing):
            return "Initializing"
        case .limited(.relocalizing):
            return "Recovering from interruption"
        }
    }

    var recommendation: String? {
        switch self {
        case .limited(.excessiveMotion):
            return "Try slowing down your movement, or reset the session."
        case .limited(.insufficientFeatures):
            return "Try pointing at a flat surface, or reset the session."
        case .limited(.relocalizing):
            return "Return to the location where you left off or try resetting the session."
        default:
            return nil
        }
    }
}
