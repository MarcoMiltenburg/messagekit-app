//
//  AppleStickerBrowserViewController.swift
//  MessagekitApp
//
//  Created by Marco Miltenburg on 29/06/16.
//  Copyright © 2016 Marco Miltenburg. All rights reserved.
//

import Foundation
import UIKit
import Messages

class AppleStickerBrowserViewController: MSStickerBrowserViewController {
    
    var stickers = [MSSticker]()
    
    func createMSSticker(asset: String, localizedDescription: String) {
        guard let stickerPath = Bundle.main().pathForResource(asset, ofType: "png") else {
            print("Couldn't create the sticker pat for: \(asset)")
            return
        }
        
        let stickerURL = URL(fileURLWithPath: stickerPath)
        
        let sticker: MSSticker
        do {
            try sticker = MSSticker(contentsOfFileURL: stickerURL, localizedDescription: localizedDescription)
            stickers.append(sticker)
        } catch {
            print("Oops, something went wrong: \(error)")
            return
        }
    }
    
    override func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return 0
    }
    
    override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt index: Int) -> MSSticker {
        return stickers[index]
    }

}
