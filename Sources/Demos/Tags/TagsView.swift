import Helpers
import SwiftUI

public struct TagsView: View {
  @State private var tag: String = ""
  @Binding private var tags: [String]

  public init(tags: Binding<[String]>) {
    _tags = tags
  }

  public var body: some View {
    VStack(spacing: .spacing200) {
      HStack(spacing: .spacing200) {
        TextField("Add new tag", text: $tag)

        Button(
          action: { self.addTag(tag) },
          label: {
            Image(systemName: "plus")
          }
        )
        .foregroundStyle(Color.blue)
        .padding(.spacing100)
        .background(Color.blue.opacity(0.2))
        .clipShape(.rect(cornerRadius: 8))
      }

      if !self.tags.isEmpty {
        Divider()
          .frame(maxWidth: .infinity, alignment: .leading)

        VStack(alignment: .leading) {
          ForEach(self.tags, id: \.self) { tag in
            Button(
              action: { self.removeTag(tag) },
              label: {
                HStack(spacing: .spacing100) {
                  Text(tag)

                  Image(systemName: "xmark")
                }
                .font(.callout)
                .padding(.vertical, .spacing100)
                .padding(.horizontal, .spacing150)
                .foregroundStyle(Color.blue)
                .background(Color.blue.opacity(0.2))
                .clipShape(.rect(cornerRadius: 8))
              }
            )
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
}

private extension TagsView {
  func addTag(_ tag: String) {
    guard !tag.isEmpty else { return }
    guard !self.tags.contains(tag) else { return }
    self.tags.append(tag)
    self.tag = ""
  }

  func removeTag(_ tag: String) {
    self.tags.removeAll { $0 == tag }
  }
}
