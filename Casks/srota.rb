cask "srota" do
  version "0.0.6"
  sha256 "9407dda50b09a25ed14a97d8f7301c7584e876773ac23ef1c85fbc158155f7ae"

  url "https://github.com/k161196/homebrew-srota/releases/download/v#{version}/Srota-#{version}.zip"
  name "Srota"
  desc "Native macOS terminal for running and orchestrating coding agents"
  homepage "https://k161196.github.io/srota-site/"

  app "Srota.app"
  binary "#{appdir}/Srota.app/Contents/MacOS/srota-cli", target: "srota-cli"

  postflight do
    # Srota is not notarized (no paid Developer ID), so macOS quarantines it on first launch.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Srota.app"],
                   sudo: false
  end

  uninstall quit:      "com.kiran.srota",
            launchctl: "com.kiran.srota.daemon"

  zap trash: [
    "~/.srota",
    "~/Library/LaunchAgents/com.kiran.srota.daemon.plist",
    "~/Library/Preferences/com.kiran.srota.plist",
  ]
end
