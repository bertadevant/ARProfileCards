//
//  ViewController.swift
//  ARProfileCards
//
//  Created by Berta devant on 10/06/2019.
//  Copyright © 2019 Berta devant. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    /// The view controller that displays the status and "restart experience" UI.
    @IBOutlet var statusView: StatusView!
    // Blurr view for effect of not focusing the camera
    @IBOutlet weak var blurView: UIVisualEffectView!
    let coachingOverlay = ARCoachingOverlayView()
    
    /// Convenience accessor for the session owned by ARSCNView.
    var session: ARSession {
        return arView.session
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCoachingOverlay()
        
        session.delegate = self
        coachingOverlay.delegate = self
        
        // Hook up status view controller callback(s).
        statusView.restartExperienceHandler = { [unowned self] in
            self.restartExperience()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Start the `ARSession`.
        resetTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: arView),
            let locationHitResult = arView.hitTest(location, types: [.estimatedHorizontalPlane]).first else {
            statusView.showMessage("could not find location")
            return
        }
        arView.entity(at: <#T##CGPoint#>)
        guard let bananaFile = try? Experience.loadBanana(),
            let banana = bananaFile.bananaGold else {
            statusView.showMessage("could not find model")
            return
        }
        
        Entity()
        
        // Create an anchor for a horizontal plane where the user touches
        let anchor = AnchorEntity(world: locationHitResult.worldTransform)
        arView.scene.addAnchor(anchor)
        //add the model into the anchor
        anchor.addChild(banana)
    }
    
    func restartExperience() {
        resetTracking()
        //set views to visible 
    }
    
    func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // MARK: - Error handling
    
    func displayErrorMessage(title: String, message: String) {
        // Blur the background.
        blurView.isHidden = false
        
        // Present an alert informing about the error that has occurred.
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
            self.blurView.isHidden = true
            self.restartExperience()
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
    }
}
