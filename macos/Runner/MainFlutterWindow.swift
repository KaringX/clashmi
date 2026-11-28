import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
    private var profileStorageChannel: FlutterMethodChannel?

    override func awakeFromNib() {
        let flutterViewController = FlutterViewController()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: false)
        self.setContentSize(NSSize(width: 400, height: 700))
        //let window: NSWindow! = self.contentView?.window
        //window.styleMask.remove(.resizable)
        RegisterGeneratedPlugins(registry: flutterViewController)
        profileStorageChannel = ProfileStorage.register(with: flutterViewController.engine.binaryMessenger)

        super.awakeFromNib()
    }
}
