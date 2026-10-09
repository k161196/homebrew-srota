cask "srota" do
  version "0.0.21"
  sha256 "35957659c5f457a4daca9bbbb6266882698597f65fe5b06b7f2c25181c7af774"

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

  # No  here on purpose — the app quits itself after a self-triggered upgrade (UpgradeSheet's
  # dismissThenQuit) once the upgrade actually finishes. brew's own quit-mid-upgrade attempt needs
  # Automation permission we can't assume, warns and no-ops without it, and when it IS granted it's
  # racing our own app (which spawned this very brew process) to quit itself before we're done — pure
  # downside either way, since brew replaces the files regardless of whether the quit succeeds.
  uninstall launchctl: "com.kiran.srota.daemon"

  zap trash: [
    "~/.srota",
    "~/Library/LaunchAgents/com.kiran.srota.daemon.plist",
    "~/Library/Preferences/com.kiran.srota.plist",
  ]
end
