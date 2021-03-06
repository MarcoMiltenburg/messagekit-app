//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Marco Miltenburg on 29/06/16.
//  Copyright © 2016 Marco Miltenburg. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    var browserViewController: AppleStickerBrowserViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presentAppleStickerViewController(presentationStyle: .compact)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Remove any existing child controllers.
        for child in self.childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        super.didTransition(to: presentationStyle)
        
        if (presentationStyle == .expanded) {
            presentStickerPackSelectionViewController(presentationStyle: presentationStyle)
        } else {
            presentAppleStickerViewController(presentationStyle: presentationStyle)
        }
    }

    func presentStickerPackSelectionViewController(presentationStyle: MSMessagesAppPresentationStyle) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "StickerPackSelection")
        presentViewController(controller: controller)
    }
    
    func presentAppleStickerViewController(presentationStyle: MSMessagesAppPresentationStyle) {
        let controller = AppleStickerBrowserViewController(stickerSize: .regular)
        presentViewController(controller: controller)
        controller.loadAllStickers()
        controller.stickerBrowserView.reloadData()
    }

    func presentViewController(controller: UIViewController) {
        
        // Embed the new controller.
        addChildViewController(controller)
        
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        controller.didMove(toParentViewController: self)
    }

}
