
class MainTerminal < ApplicationTerminal
  desc "hello NAME", "say hello to NAME"
  def hello(name)
    puts "Hello #{name}"
  end

  desc "login", "Login to your account"
  def login
    Terminalwire::Rails::Channel.new do |channel|
      url = root_url(channel: channel.id)
      puts "Launching #{url}"
      browser.launch terminal_authorization_url(channel.id)

      # if data = JSON.parse channel.read
      #   puts "Successfully logged in as #{data["email"]}."
      # else
      #   fail "Login failed."
      # end
    end
  end

  desc "whoami", "Displays current user information."
  def whoami
    if self.current_user
      puts "Logged in as #{current_user.email}."
    else
      fail "Not logged in. Run `#{self.class.basename} login` to login."
    end
  end

  desc "logout", "Logout of your account"
  def logout
    session.reset
    puts "Successfully logged out."
  end
end
