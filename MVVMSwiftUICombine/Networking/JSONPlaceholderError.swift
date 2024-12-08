import Foundation

enum JSONPlaceholderError: Error {
    case networkFailure
    case invalidData
}

extension JSONPlaceholderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkFailure:
            return NSLocalizedString("Network Failure Error", comment: "")
        case .invalidData:
            return NSLocalizedString("Invalid Data Error", comment: "")
        }
    }
}
