import Foundation

enum DataLoadingError: Error {
    case networkFailure(statusCode: String)
    case invalidData
}

extension DataLoadingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkFailure(let statusCode):
            return NSLocalizedString("Data Request Error." + "With Status Code" + " " + statusCode, comment: "")
        case .invalidData:
            return NSLocalizedString("Invalid Data Error", comment: "")
        }
    }
}
