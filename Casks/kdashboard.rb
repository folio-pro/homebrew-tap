cask "kdashboard" do
  arch arm: "arm64", intel: "x64"

  version "0.3.0"
  sha256 arm: "d5fd6b30c1cd3c514df193cf274cb6af7f500edf8e1a6efc1a91704c98b0db59", intel: "1b26772a378e9ef30502489207642a8f36ca687385db864d510ab7193710a570"

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

  zap trash: [
    "~/Library/Application Support/kdashboard",
    "~/Library/Preferences/com.kdashboard.app.plist",
    "~/Library/Saved Application State/com.kdashboard.app.savedState",
  ]
end
