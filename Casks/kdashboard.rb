cask "kdashboard" do
  arch arm: "arm64", intel: "x64"

  version "0.9.0"
  sha256 arm: "e0d0537ee0487bd071fd3b924ca8c8d7f6b9b9139cc2187c8a822ef1f2b1f882", intel: "07d5abacd65ce8de2453ba9ef1dcb650e5552450f438aef0e1e448f912d037d2"

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
