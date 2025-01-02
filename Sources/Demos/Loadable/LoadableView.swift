import SwiftUI

public struct LoadableView<
  ContentState: Equatable,
  ErrorId: Hashable,
  ContentView: View,
  ErrorStateView: View,
  EmptyStateView: View
>: View {
  private let state: Loadable<ContentState, ErrorId>
  private let content: (ContentState) -> ContentView
  private let error: (ErrorId) -> ErrorStateView
  private let empty: () -> EmptyStateView

  public init(
    state: Loadable<ContentState, ErrorId>,
    @ViewBuilder content: @escaping (ContentState) -> ContentView,
    @ViewBuilder error: @escaping (ErrorId) -> ErrorStateView,
    @ViewBuilder empty: @escaping () -> EmptyStateView
  ) {
    self.state = state
    self.content = content
    self.error = error
    self.empty = empty
  }

  public var body: some View {
    VStack(spacing: .zero) {
      switch self.state {
      case .loading:
        ProgressView()
          .tint(Color(.secondaryLabel))

      case .empty:
        empty()

      case let .content(value):
        content(value)

      case let .error(errorId):
        error(errorId)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
