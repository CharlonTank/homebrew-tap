cask "agents-sleep-preventer" do
  version "5.6.0"
  sha256 "d7c5ea89e826cf4b9659a0cdb255383c3571f38212488719baf10c0d0af54e95"

  url "https://github.com/CharlonTank/agents-sleep-preventer/releases/download/v#{version}/AgentsSleepPreventer-#{version}.dmg"
  name "Agents Sleep Preventer"
  desc "Prevents sleep while coding agents work and shows their status"
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
