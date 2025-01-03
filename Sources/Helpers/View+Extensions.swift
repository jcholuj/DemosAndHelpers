import SwiftUI

public extension View {
  func frame(_ size: CGFloat) -> some View {
    self
      .frame(width: size, height: size)
  }

  func radius(_ radius: CGFloat) -> some View {
    self
      .clipShape(.rect(cornerRadius: radius))
  }
}
