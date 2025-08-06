//
//  Created by Alex.M on 27.05.2022.
//

import Foundation
import Photos

public struct AssetMediaModel {
    public let asset: PHAsset
    public init(asset: PHAsset) {
        self.asset = asset
    }
}

extension AssetMediaModel: MediaModelProtocol {

    public var mediaType: MediaType? {
        switch asset.mediaType {
        case .image:
            return .image
        case .video:
            return .video
        default:
            return nil
        }
    }

    public var duration: CGFloat? {
        CGFloat(asset.duration)
    }

    public func getURL() async -> URL? {
        await asset.getURL()
    }

    public func getThumbnailURL() async -> URL? {
        await asset.getThumbnailURL()
    }

    public func getData() async throws -> Data? {
        try await asset.getData()
    }

    public func getThumbnailData() async -> Data? {
        await asset.getThumbnailData()
    }
}

extension AssetMediaModel: Identifiable {
    public var id: String {
        asset.localIdentifier
    }
}

extension AssetMediaModel: Equatable {
    public static func ==(lhs: AssetMediaModel, rhs: AssetMediaModel) -> Bool {
        lhs.id == rhs.id
    }
}
