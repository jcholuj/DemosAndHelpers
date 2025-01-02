import Foundation
import Helpers

public enum Loadable<
  ContentState: Equatable,
  ErrorId: Hashable
>: Equatable {
  case loading
  case empty
  case content(ContentState)
  case error(ErrorId)

  public var contentState: ContentState? {
    guard case let .content(contentState) = self
    else { return nil }
    return contentState
  }

  public var errorId: ErrorId? {
    guard case let .error(errorId) = self
    else { return nil }
    return errorId
  }
}
