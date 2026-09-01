cask "srota" do
  version "0.0.7"
  sha256 "a55cf18a111a3086a0ec1e9d938a34a3c4c2d68b6da106f37bb229739b327e18"

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

  # The daemon (com.kiran.srota.daemon) is deliberately NOT unloaded here: it manages its own
  # lifecycle across an upgrade (self-exec handoff of live PTY sessions, srota-daemon/HandoffManager.swift)
  # instead of being force-killed by the cask. Only the GUI app needs to quit to pick up new app-shell code.
  uninstall quit: "com.kiran.srota"

  zap trash: [
    "~/.srota",
    "~/Library/LaunchAgents/com.kiran.srota.daemon.plist",
    "~/Library/Preferences/com.kiran.srota.plist",
  ]
end
