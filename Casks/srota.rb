cask "srota" do
  version "0.0.1"
  sha256 "a4cb006ddae753dbc763e778590318f15b3f795dee6959f4be91a18e210f9453"

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
