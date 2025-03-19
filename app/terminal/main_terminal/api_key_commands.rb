class MainTerminal::ApiKeyCommands < ApplicationTerminal
  before_command :require_user

  desc "list", "List API keys"
  map ls: :list
  def list
    api_keys = current_user.api_keys

    if api_keys.empty?
      puts "No API keys. Run `#{self.class.basename} keys create` to create one."
    else
      puts "ID\tName"
      current_user.api_keys.each do |api_key|
        puts [api_key.id, api_key.name].join("\t")
      end
    end
  end

  desc "create", "Create an API key"
  option :name, aliases: "-n", desc: "Name of the API key"
  def create
    name = options.fetch(:name, ApiKey.generate_name)
    api_key = current_user.api_keys.create!(name:)
    puts api_key.token
  end

  desc "delete ID", "Delete an API key"
  map rm: :delete
  def delete(id)
    if api_key = current_user.api_keys.find(id)
      api_key.destroy!
      puts "API key #{id} deleted."
    else
      puts "API key #{id} not found."
    end
  end

  desc "open", "Open API key in browser"
  def open(id = nil)
    if id.nil?
      browser.launch api_keys_url
    elsif api_key = current_user.api_keys.find(id)
      browser.launch api_key_url(api_key)
    else
      puts "API key #{id} not found."
    end
  end
end
