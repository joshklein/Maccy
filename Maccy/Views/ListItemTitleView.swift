import SwiftUI

struct ListItemTitleView<Title: View>: View {
  var attributedTitle: AttributedString? = nil
  @ViewBuilder var title: () -> Title

  var body: some View {
    if let attributedTitle {
      Text(attributedTitle)
        .accessibilityIdentifier("copy-history-item")
        .lineLimit(1)
        .truncationMode(.middle)
        .padding(.leading, 10)
    } else {
      title()
        .accessibilityIdentifier("copy-history-item")
        .lineLimit(1)
        .truncationMode(.middle)
        .padding(.leading, 10)
    }
  }
}
