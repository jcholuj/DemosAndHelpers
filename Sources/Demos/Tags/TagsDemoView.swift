import Helpers
import SwiftUI

struct TagsDemoView: View {
  @State private var tags: [String] = ["Copenhagen", "London", "New York", "Paris"]
  var body: some View {
    TagsView(tags: $tags.animation())
      .padding(.spacing200)
      .background(Color.white)
      .clipShape(.rect(cornerRadius: 16))
      .padding(.spacing200)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(.secondarySystemBackground))
  }
}

#Preview {
  TagsDemoView()
}
