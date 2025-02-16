import Helpers
import SwiftUI

struct TagsDemoView: View {
  @State private var tags: [String] = ["Copenhagen", "London", "New York", "Los Angeles", "Paris", "Warsaw", "Barcelona"]
  @State private var selectedTags: [String] = []

  var body: some View {
    TagsView(
      tags: self.$tags.animation(),
      selectedTags: self.$selectedTags.animation()
    )
    .padding(.spacing200)
    .background(Color.white)
    .clipShape(.rect(cornerRadius: .radius200))
    .padding(.spacing200)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.secondarySystemBackground))
  }
}

#Preview {
  TagsDemoView()
}
