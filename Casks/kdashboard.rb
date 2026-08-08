cask "kdashboard" do
  arch arm: "arm64", intel: "x64"

  version "0.2.0"
  sha256 arm: "8dcaf9b15260e15aaa0117e7dd03352250431ea4bf758433c2e13b57b22823f8", intel: "ac77a7b3dccfe254799b39258a391b3dbadc7ca6c2a0c12f04bdd1438c3e2130"

  url "https://github.com/folio-pro/kdashboard/releases/download/v#{version}/kdashboard-#{version}-#{arch}.dmg"
  name "kdashboard"
  desc "Kubernetes dashboard desktop app"
  homepage "https://github.com/folio-pro/kdashboard"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false

  app "kdashboard.app"

  zap trash: [
    "~/Library/Application Support/kdashboard",
    "~/Library/Preferences/com.kdashboard.app.plist",
    "~/Library/Saved Application State/com.kdashboard.app.savedState",
  ]
end
