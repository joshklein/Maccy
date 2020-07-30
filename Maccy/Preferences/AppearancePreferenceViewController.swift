import Cocoa
import Preferences

class AppearancePreferenceViewController: NSViewController, PreferencePane {
  public let preferencePaneIdentifier = PreferencePane.Identifier.appearance
  public let preferencePaneTitle = NSLocalizedString("preferences_appearance", comment: "")
  public let toolbarItemIcon = NSImage(named: NSImage.colorPanelName)!

  override var nibName: NSNib.Name? { "AppearancePreferenceViewController" }

  @IBOutlet weak var popupAtButton: NSPopUpButton!
  @IBOutlet weak var pinToButton: NSPopUpButton!
  @IBOutlet weak var imageHeightSlider: NSSlider!
  @IBOutlet weak var imageHeightLabel: NSTextField!
  @IBOutlet weak var menuSizeSlider: NSSlider!
  @IBOutlet weak var menuSizeLabel: NSTextField!
  @IBOutlet weak var showMenuIconButton: NSButton!
  @IBOutlet weak var showSearchFieldButton: NSButton!
  @IBOutlet weak var showTitleButton: NSButton!
  @IBOutlet weak var showFooterButton: NSButton!

  override func viewWillAppear() {
    super.viewWillAppear()
    populatePopupPosition()
    populatePinTo()
    populateImageHeight()
    populateMenuSize()
    populateShowMenuIcon()
    populateShowSearchField()
    populateShowTitle()
    populateShowFooter()
  }

  @IBAction func popupPositionChanged(_ sender: NSPopUpButton) {
    switch sender.selectedTag() {
    case 2:
      UserDefaults.standard.popupPosition = "statusItem"
    case 1:
      UserDefaults.standard.popupPosition = "center"
    default:
      UserDefaults.standard.popupPosition = "cursor"
    }
  }

  @IBAction func pinToChanged(_ sender: NSPopUpButton) {
    switch sender.selectedTag() {
    case 1:
      UserDefaults.standard.pinTo = "bottom"
    default:
      UserDefaults.standard.pinTo = "top"
    }
  }

  @IBAction func imageHeightChanged(_ sender: NSSlider) {
    let old = String(UserDefaults.standard.imageMaxHeight)
    let new = String(imageHeightSlider.integerValue)
    updateImageHeightLabel(old: old, new: new)
    UserDefaults.standard.imageMaxHeight = sender.integerValue
  }

  @IBAction func menuSizeChanged(_ sender: NSSlider) {
    let old = String(UserDefaults.standard.maxMenuItems)
    let new = String(menuSizeSlider.integerValue)
    updateMenuSizeLabel(old: old, new: new)
    UserDefaults.standard.maxMenuItems = sender.integerValue
  }

  @IBAction func showMenuIconChanged(_ sender: NSButton) {
    UserDefaults.standard.showInStatusBar = (sender.state == .on)
  }

  @IBAction func showSearchFieldChanged(_ sender: NSButton) {
    UserDefaults.standard.hideSearch = (sender.state == .off)
  }

  @IBAction func showTitleChanged(_ sender: NSButton) {
    UserDefaults.standard.hideTitle = (sender.state == .off)
  }

  @IBAction func showFooterChanged(_ sender: NSButton) {
    UserDefaults.standard.hideFooter = (sender.state == .off)
  }

  private func populatePopupPosition() {
    switch UserDefaults.standard.popupPosition {
    case "statusItem":
      popupAtButton.selectItem(withTag: 2)
    case "center":
      popupAtButton.selectItem(withTag: 1)
    default:
      popupAtButton.selectItem(withTag: 0)
    }
  }

  private func populatePinTo() {
    switch UserDefaults.standard.pinTo {
    case "bottom":
      pinToButton.selectItem(withTag: 1)
    default:
      pinToButton.selectItem(withTag: 0)
    }
  }

  private func populateImageHeight() {
    imageHeightSlider.integerValue = UserDefaults.standard.imageMaxHeight
    let new = String(imageHeightSlider.integerValue)
    updateImageHeightLabel(old: "{imageHeight}", new: new)
  }

  private func updateImageHeightLabel(old: String, new: String) {
    let newLabelValue = imageHeightLabel.stringValue.replacingOccurrences(
      of: old,
      with: new,
      options: [],
      range: imageHeightLabel.stringValue.range(of: old)
    )
    imageHeightLabel.stringValue = newLabelValue
  }

  private func populateMenuSize() {
    menuSizeSlider.integerValue = UserDefaults.standard.maxMenuItems
    let new = String(menuSizeSlider.integerValue)
    updateMenuSizeLabel(old: "{menuSize}", new: new)
  }

  private func updateMenuSizeLabel(old: String, new: String) {
    let newLabelValue = menuSizeLabel.stringValue.replacingOccurrences(
      of: old,
      with: new,
      options: [],
      range: menuSizeLabel.stringValue.range(of: old)
    )
    menuSizeLabel.stringValue = newLabelValue
  }

  private func populateShowMenuIcon() {
    showMenuIconButton.state = UserDefaults.standard.showInStatusBar ? .on : .off
  }

  private func populateShowSearchField() {
    showSearchFieldButton.state = UserDefaults.standard.hideSearch ? .off : .on
  }

  private func populateShowTitle() {
    showTitleButton.state = UserDefaults.standard.hideTitle ? .off : .on
  }

  private func populateShowFooter() {
    showFooterButton.state = UserDefaults.standard.hideFooter ? .off : .on
  }
}
