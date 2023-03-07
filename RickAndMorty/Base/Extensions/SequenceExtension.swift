//
//  SequenceExtension.swift
//  RickAndMorty
//
//  Created by Doni on 3/6/23.
//

import Foundation

extension Sequence {
    func asyncForEach(
        _ operation: (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
}
