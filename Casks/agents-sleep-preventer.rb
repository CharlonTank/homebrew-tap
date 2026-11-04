cask "agents-sleep-preventer" do
  version "5.8.0"
  sha256 "979838f8c9a2b4bd05d810a41d07dc58798ed34f9524c177c0987a35e5ef7040"

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
