import SwiftUI

struct ContentState: Equatable {
  let title = "Successful operation!"
  let description = "Congratulations, everything is working perfectly!"
}

struct ErrorId: Hashable {}

struct LoadableDemoView: View {
  @State var viewState: Loadable<ContentState, ErrorId> = .loading

  var body: some View {
    NavigationStack {
      LoadableView(state: viewState) { contentState in
        ResultView(
          icon: .successIcon,
          iconColor: .green,
          title: contentState.title,
          description: contentState.description
        )
      } error: { _ in
        ResultView(
          icon: .errorIcon,
          iconColor: .red,
          title: .errorTitle,
          description: .errorDescription
        )
      } empty: {
        ResultView(
          icon: .emptyIcon,
          iconColor: .blue,
          title: .emptyTitle,
          description: .emptyDescription
        )
      }
      .toolbar {
        ToolbarItemGroup(placement: .bottomBar) {
          Button("Loading") { viewState = .loading }

          Spacer()

          Button("Empty") { viewState = .empty }

          Spacer()

          Button("Error") { viewState = .error(ErrorId()) }

          Spacer()

          Button("Content") { viewState = .content(ContentState()) }
        }
      }
    }
  }
}

private struct ResultView: View {
  let icon: String
  let iconColor: Color
  let title: String
  let description: String

  var body: some View {
    VStack(spacing: .spacing200) {
      Image(systemName: icon)
        .resizable()
        .frame(.iconSize)
        .foregroundStyle(iconColor)

      VStack(spacing: .spacing100) {
        Text(title)
          .font(.title2.weight(.semibold))
          .foregroundStyle(Color(.label))
          .frame(maxWidth: .infinity)

        Text(description)
          .foregroundStyle(Color(.secondaryLabel))
          .frame(maxWidth: .infinity)
      }
    }
    .multilineTextAlignment(.center)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

private extension CGFloat {
  static let iconSize = 64.0
  static let spacing200 = 16.0
  static let spacing100 = 8.0
}

private extension String {
  static let successIcon = "checkmark.circle"
  static let emptyIcon = "magnifyingglass.circle"
  static let errorIcon = "exclamationmark.circle"
  static let emptyTitle = "No results"
  static let emptyDescription = "We can't find what you're looking for."
  static let errorTitle = "Something went wrong"
  static let errorDescription = "The content of the screen could not be loaded. Please try again later."
}

#Preview {
  LoadableDemoView()
}
