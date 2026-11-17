cask "agents-sleep-preventer" do
  version "5.8.9"
  sha256 "cd47edc9ff2d94e0ab9b2cfc7e3873ab300f66005bb1dbc64c7256ca9035f0d0"

  url "https://github.com/CharlonTank/agents-sleep-preventer/releases/download/v#{version}/AgentsSleepPreventer-#{version}.dmg"
  name "Agent Session Pilot"
  desc "Keeps coding agents awake, watches them and drives them from Telegram"
  homepage "https://github.com/CharlonTank/agents-sleep-preventer"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "AgentsSleepPreventer.app"

  uninstall launchctl: "com.charlontank.agents-sleep-preventer",
            quit:      "com.charlontank.agents-sleep-preventer"

  zap trash: [
    "~/Library/Application Support/AgentsSleepPreventer",
    "~/Library/Caches/com.charlontank.agents-sleep-preventer",
    "~/Library/HTTPStorages/com.charlontank.agents-sleep-preventer",
    "~/Library/HTTPStorages/com.charlontank.agents-sleep-preventer.binarycookies",
    "~/Library/Logs/AgentsSleepPreventer",
    "~/Library/Preferences/com.charlontank.agents-sleep-preventer.plist",
  ]

  caveats <<~EOS
    Open Agents Sleep Preventer once to set up the coding agent hooks.

    Before uninstalling, remove the hooks and the pmset sudoers rule with:
      /Applications/AgentsSleepPreventer.app/Contents/MacOS/asp uninstall
  EOS
end
