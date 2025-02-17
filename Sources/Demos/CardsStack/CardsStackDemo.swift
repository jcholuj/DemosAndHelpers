import Helpers
import SwiftUI

struct CardsStackDemo: View {
  let colors = [Color.yellow, Color.green, Color.blue, Color.orange, Color.red, Color.mint, Color.purple, Color.pink, Color.teal]
  @State private var isExpanded = false

  var body: some View {
    NavigationView {
      ScrollViewReader { proxy in
        ScrollView {
          CardsStack(spacing: self.isExpanded ? (.cardHeight + .spacing100) : .cardOffset) {
            ForEach(Array(self.colors.enumerated()), id: \.offset) { color in
              CardView(color: color.element)
                .id(color.offset)
                .onTapGesture { self.expandAndScrollTo(color.offset, using: proxy) }
            }
          }
          .padding(.spacing200)
        }
      }
    }
  }

  private func expandAndScrollTo(_ index: Int, using proxy: ScrollViewProxy) {
    if #available(iOS 17.0, *) {
      withAnimation {
        self.isExpanded.toggle()
      } completion: {
        withAnimation { proxy.scrollTo(index, anchor: .bottom) }
      }
    } else {
      withAnimation(.easeInOut(duration: 0.3)) { self.isExpanded.toggle() }
      Task {
        try? await Task.sleep(for: .milliseconds(300))
        withAnimation { proxy.scrollTo(index, anchor: .bottom) }
      }
    }
  }
}

private struct CardView: View {
  let color: Color

  var body: some View {
    VStack(alignment: .leading, spacing: .spacing200) {
      Group {
        Text(color.description.capitalized)
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.headline.weight(.semibold))
          .foregroundStyle(Color.white)

        Spacer()
      }
      .padding(.spacing200)
    }
    .frame(height: .cardHeight)
    .frame(maxWidth: .infinity)
    .background(color.gradient)
    .clipShape(.rect(cornerRadius: .radius200))
  }
}

private extension CGFloat {
  static let cardOffset = 52.0
  static let cardHeight = 192.0
}

#Preview {
  CardsStackDemo()
}
