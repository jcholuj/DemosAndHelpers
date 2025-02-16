import Helpers
import SwiftUI

public struct TagsView: View {
  @State private var tag: String = ""
  @Binding private var tags: [String]
  @Binding private var selectedTags: [String]

  public init(
    tags: Binding<[String]>,
    selectedTags: Binding<[String]>
  ) {
    _tags = tags
    _selectedTags = selectedTags
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
        .clipShape(.rect(cornerRadius: .radius100))
      }

      if !self.tags.isEmpty {
        Divider()
          .frame(maxWidth: .infinity, alignment: .leading)

        FlexibleStack(alignment: .leading) {
          ForEach(self.tags, id: \.self) { tag in
            Button(
              action: { self.tagTapped(tag) },
              label: {
                Text(tag)
                  .font(.footnote.weight(.semibold))
                  .padding(.vertical, .spacing75)
                  .padding(.horizontal, .spacing125)
                  .foregroundStyle(self.selectedTags.contains(tag) ? Color.white : Color.blue)
                  .background(Color.blue.opacity(self.selectedTags.contains(tag) ? 1.0 : 0.2))
                  .clipShape(.rect(cornerRadius: .radius100))
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

  func tagTapped(_ tag: String) {
    if self.selectedTags.contains(tag) {
      self.selectedTags.removeAll { $0 == tag }
    } else {
      self.selectedTags.append(tag)
    }
  }
}
