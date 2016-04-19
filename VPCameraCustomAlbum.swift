//
//  VPCameraCustomAlbum.swift
//  VPCameraCustomAlbum
//
//  Created by Vlad Petruk on 1/3/16.
//  Copyright © 2016 Vlad Petruk. All rights reserved.
//

import Foundation
import Photos

class VPCameraCustomAlbum {
    
    static let albumName = "XXX"
    static let sharedAlbum = VPCameraCustomAlbum()
    
    var assetCollection: PHAssetCollection!
    
    init() {
        
        func fetchAssetCollectionForAlbum() -> PHAssetCollection! {
            
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", VPCameraCustomAlbum.albumName)
            let collection = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
            
            if let firstObject: AnyObject? = collection.firstObject {
                return firstObject as? PHAssetCollection
            }
            
            return nil
        }
        
        if let assetCollection = fetchAssetCollectionForAlbum() {
            self.assetCollection = assetCollection
            return
        }
        
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(VPCameraCustomAlbum.albumName)
            }) { success, _ in
                if success {
                    self.assetCollection = fetchAssetCollectionForAlbum()
                }
        }
    }
    
    func saveImage(image: UIImage) {
        
        if assetCollection == nil {
            return  // Skip the save.
        }
        
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
            let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection)
            albumChangeRequest?.addAssets([assetPlaceholder!])
            }, completionHandler: nil)
    }
    
}
