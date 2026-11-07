# my-demo-app-ios

*My Demo App* is a... demo app! 
It was built by the Sauce Labs team to showcase product capabilities of the Sauce Labs mobile devices cloud, The Sauce Labs mobile beta testing platform, TestFairy, and more products and technologies that will be added to this project soon.

This app is part of a set of demo apps.

[My Demo App - Android](https://github.com/saucelabs/my-demo-app-android)

[My Demo App - iOS](https://github.com/saucelabs/my-demo-app-ios)

### QR code scanner

This app has a QR code scanner.
You can find it in the menu under the option "QR CODE SCANNER".
This page opens the camera (you first need to allow the app to use the camera) which can be used to scan a QR Code.
If the QR code holds an URL it will automatically open it in a browser. The [following image](./docs/assets/qr-code.png)
can be used to demo this option.

![QR Code](./docs/assets/qr-code.png)

## Publish

To publish a new version, create a release with a valid semver tag name. A CI workflow will handle setting the app version name/code and upload the APK into the release. 

## SDK credentials

The app runs Backtrace and the Sauce Mobile Beta SDK side by side.

1. Copy `Config/Local.xcconfig.example` to `Config/Local.xcconfig` and fill in `SAUCE_MOBILE_BETA_TOKEN`, `SAUCE_MOBILE_BETA_ENDPOINT` (both from Organization Settings > SDK Settings), `BACKTRACE_UNIVERSE` and `BACKTRACE_TOKEN`. The endpoint is the Server Endpoint (`https://<host>/services/`). The SDK's built-in default server is no longer in service, so without the endpoint the app skips Sauce Mobile Beta.

2. Build. `Config/Demo.xcconfig` includes your file, Xcode expands the values into Info.plist
   (`sauceMobileBetaToken`, `sauceMobileBetaEndpoint`, `backtraceUniverse`, `backtraceToken`) and `Credentials.swift` reads them.

## Sauce Visual development integration

This example uses the revised SauceVisual SDK in the **UI-test runner only**. It must not change the app's MAD Ad Hoc distribution configuration.

The contribution restores the existing app Debug and Release signing settings to the reviewed main-branch values. A separate **VisualDebug** configuration and **Sauce Visual Development** scheme use development signing for local UI testing. No distribution entitlement is forced, and existing archive/export schemes are not replaced.

The UI-test target resolves `SauceVisual` directly from [saucelabs/visual-sdks](https://github.com/saucelabs/visual-sdks), using its root Swift package manifest. It is pinned to revision [`671a9fb05c5bd0c76e9f5602288f0d9af6283e86`](https://github.com/saucelabs/visual-sdks/commit/671a9fb05c5bd0c76e9f5602288f0d9af6283e86) from [SDK PR #311](https://github.com/saucelabs/visual-sdks/pull/311). No sibling SDK checkout or local package override is required. This is a development integration pin for the open SDK PR; update it to an approved revision or release before merging the demo. Open `My Demo App.xcworkspace` to use the shared package lockfile.

Configure Sauce credentials privately. They are never committed in the shared scheme. Run only the optional visual suite:

```bash
export DEVELOPER_DIR=/Applications/Xcode_26.6.app/Contents/Developer
TEST_RUNNER_SAUCE_USERNAME="$SAUCE_USERNAME" \
TEST_RUNNER_SAUCE_ACCESS_KEY="$SAUCE_ACCESS_KEY" \
xcodebuild test -workspace 'My Demo App.xcworkspace' \
  -scheme 'Sauce Visual Development' -configuration VisualDebug \
  -destination 'platform=iOS Simulator,id=YOUR_SIMULATOR_UDID' \
  -only-testing:MyDemoAppUITests/VisualTest
```

Select a valid development team/profile for a physical-device run in VisualDebug only. Separately build/export the established MAD Ad Hoc artifact using its existing pipeline. Both outputs must be accepted before this demo PR is merged.

Without credentials these optional demo tests skip. They await each submission, fail with Swift errors when required UI is absent, and inspect the receipt. Submission does not assert visual equality. `VISUAL_CHECK=true` selects the demonstration user with intentionally different content; `false`, an empty value, or an unset variable selects the normal user.

The scroll example explicitly allows a bounded prefix and checks `captureExtent`; it does not claim a complete page after an ambiguity. It does not attach first-viewport DOM/masks to a stitched image. DOM requested for a viewport is required and must upload successfully. Ignore regions are not redaction.
