
class MainTerminal < ApplicationTerminal
  desc "hello NAME", "say hello to NAME"
  def hello(name)
    puts "Hello #{name}"
  end

  desc "login", "Login to your account"
  def login
    Terminalwire::Rails::Channel.new do |channel|
      url = terminal_authorization_url(channel)
      puts "Launching #{url}"
      browser.launch url

      case JSON.parse(channel.read.data, symbolize_names: true)
      in status: "approved", user_id:
        self.current_user = User.find(user_id)
        puts "Logged in in as #{current_user.email}."
      else
        fail "Login failed."
      end
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
