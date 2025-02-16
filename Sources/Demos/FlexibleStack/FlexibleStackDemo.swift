import Helpers
import SwiftUI

struct FlexibleStackDemo: View {
  private let items: [String] = Calendar.current.weekdaySymbols
  
  var body: some View {
    ScrollView {
      FlexibleStack(alignment: .leading, spacing: .spacing150) {
        ForEach(items, id: \.self) { item in
          HStack(spacing: .spacing100) {
            Text(item.capitalized)

            Divider()

            Image(systemName: "xmark")
          }
          .font(.callout)
          .padding(.vertical, .spacing100)
          .padding(.horizontal, .spacing150)
          .foregroundStyle(Color.blue)
          .background(Color.blue.opacity(0.2))
          .clipShape(.rect(cornerRadius: .radius100))
        }
      }
      .padding(.spacing200)
    }
  }
}

#Preview {
  FlexibleStackDemo()
}
