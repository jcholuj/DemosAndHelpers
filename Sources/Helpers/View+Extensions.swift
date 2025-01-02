import SwiftUI

public extension View {
  func frame(_ size: CGFloat) -> some View {
    self
      .frame(width: size, height: size)
  }
}
