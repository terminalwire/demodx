# Learn how to use Thor at http://whatisthor.com.
class ApplicationTerminal < Thor
  # Enables IO Streaming.
  include Terminalwire::Thor

  # The name of your binary. Thor uses this for its help output.
  def self.basename = "my-app"

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
end
