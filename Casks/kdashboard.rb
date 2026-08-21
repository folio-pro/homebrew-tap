cask "kdashboard" do
  arch arm: "arm64", intel: "x64"

  version "0.8.0"
  sha256 arm: "39bdb5f9d6b730d7cdbbf49b24d1db185963b3da6202ca8a9cdca02bda10c1f8", intel: "3560459948121a1628a84c00b1ba26de014c180faf6738792c6ed5adb47dfb86"

  url "https://github.com/folio-pro/kdashboard/releases/download/v#{version}/kdashboard-#{version}-#{arch}.dmg"
  name "Kdashboard"
  desc "Kubernetes dashboard desktop app"
  homepage "https://github.com/folio-pro/kdashboard"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false

  # Bundle name follows electron-builder's productName ("Kdashboard");
  # the .dmg filenames stay lowercase via the mac artifactName in
  # package.json, so the url above keeps working across versions.
  app "Kdashboard.app"

  # The app is ad-hoc signed but not notarized (no Apple Developer ID),
  # so macOS blocks the first launch of a quarantined copy and the user
  # has to allow it under Privacy & Security. Drop the quarantine flag
  # here instead, the same tradeoff as installing with --no-quarantine.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Kdashboard.app"]
  end

  zap trash: [
    "~/Library/Application Support/kdashboard",
    "~/Library/Preferences/com.kdashboard.app.plist",
    "~/Library/Saved Application State/com.kdashboard.app.savedState",
  ]
end
