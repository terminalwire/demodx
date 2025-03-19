
class MainTerminal < ApplicationTerminal
  desc "hello NAME", "say hello to NAME"
  def hello(name)
    puts "Hello #{name}"
  end

  desc "auth", "Login to Terminalwire"
  subcommand "auth", AuthorizationCommands
end
