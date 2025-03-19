# Learn how to use Thor at http://whatisthor.com.
class ApplicationTerminal < Thor
  include ActiveSupport::Callbacks
  define_callbacks :command

  # Define a class method to register before callbacks
  def self.before_command(method_name)
    set_callback :command, :before, method_name
  end

  # Override invoke_command to run the callbacks before invoking the command
  def invoke_command(command, *args)
    run_callbacks :command do
      super
    end
  end

  # Enables IO Streaming.
  include Terminalwire::Thor

  # The name of your binary. Thor uses this for its help output.
  def self.basename = "demodx"

  private

  def current_user=(user)
    # The Session object is a hash-like object that encrypts and signs a hash that's
    # stored on the client's file sytem. Conceptually, it's similar to Rails signed
    # and encrypted client-side cookies.
    session["user_id"] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session["user_id"])
  end

  def require_user
    unless current_user
      puts "Run `#{self.class.basename} auth login` to authenticate and continue."
      throw :abort
    end
  end
end
