
class MainTerminal < ApplicationTerminal
  desc "open", "Open website"
  def open
    browser.launch root_url
  end

  desc "auth", "Login to Terminalwire"
  subcommand "auth", AuthorizationCommands

  desc "keys", "Manage API Keys"
  subcommand "keys", ApiKeyCommands
end
