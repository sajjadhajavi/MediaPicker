//
//  SwiftUIView.swift
//  
//
//  Created by Alisa Mylnikova on 12.07.2022.
//

import SwiftUI
import UniformTypeIdentifiers
import AVFoundation

public struct URLMediaModel {
    public let url: URL
    public init(url: URL) {
        self.url = url
    }
}

extension URLMediaModel: MediaModelProtocol {

    public var mediaType: MediaType? {
        if url.isImageFile {
            return .image
        }
        if url.isVideoFile {
            return .video
        }
        return nil
    }

    public var duration: CGFloat? {
        get async {
            let asset = AVURLAsset(url: url)
            do {
                let duration = try await asset.load(.duration)
                return CGFloat(CMTimeGetSeconds(duration))
            } catch {
                return nil
            }
        }
    }

    public func getURL() async -> URL? {
        url
    }

    public func getThumbnailURL() async -> URL? {
        switch mediaType {
        case .image:
            return url
        case .video:
            return await url.getThumbnailURL()
        case .none:
            return nil
        }
    }

    public func getData() async throws -> Data? {
        try? Data(contentsOf: url)
    }

    public func getThumbnailData() async -> Data? {
        switch mediaType {
        case .image:
            return try? Data(contentsOf: url)
        case .video:
            return await url.getThumbnailData()
        case .none:
            return nil
        }
    }
}

extension URLMediaModel: Identifiable {
    public var id: String {
        url.absoluteString
    }
}

extension URLMediaModel: Equatable {
    public static func ==(lhs: URLMediaModel, rhs: URLMediaModel) -> Bool {
        lhs.id == rhs.id
    }
}
