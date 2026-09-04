cask "kdashboard" do
  arch arm: "arm64", intel: "x64"

  version "0.9.1"
  sha256 arm: "08158f5ccd8f7684fa53918dde9d6301ca2560cc3d5b43bb528bed38a3663dbd", intel: "7dfaa283e7bc2ca587bf4726da2ba95fd759b3d3c947782784ed180be65637ab"

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
