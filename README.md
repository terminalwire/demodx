# README

This is a demo Rails app that shows how a SaaS can improve their developer experience and streamline onboarding by eliminating the "point click point click ..." instructions of getting an API key to "Install this CLI and run `demodx apitoken create`."

You can learn more about Terminalwire at [Terminalwire.com](https://terminalwire.com) or [talk to a human](https://terminalwire.com/human) and get a demo.

## Live Demo

A live demo for this app is available at [https://demodx.terminalwire.com](https://demodx.terminalwire.com).

[![Live demo of DemoDX](https://immutable.terminalwire.com/UcZiU8JyOPNi2XXEgz3Xd5TiJTQmwfFD6yWPLhqLuIJLt3MOZQJSOItdPKmade7Lm5fCeNoqVYwCSq5xvwEMypeTNaDqdzRWCwVd.png)
](https://demodx.terminalwire.com)

## Video demo

Watch the video walk-through of [Demo DX on YouTube](https://www.youtube.com/watch?v=IIFBD8w7VnA).

[![Walk-through of Demo DX on YouTube](https://immutable.terminalwire.com/tyy9OuWiq8nVOqL0uBbE6ttXyiyuXUmGRY67FVqAtgkPfsJimhPD5r89iXcc9kqkSKHOH9XvaSn2gfNkreTY7pXxaMz2WGJjJuhS.png)
](https://www.youtube.com/watch?v=IIFBD8w7VnA)

## Getting Started

The source code for this project is available for study in this repo. You may clone it to your workstation using the following command.

```bash
$ git clone git@github.com:terminalwire/demodx.git
```

Then install the dependencies:

```bash
$ bundle install
```

And run the server:

```bash
$ bin/rails s
```

Then open the webpage at [http://localhost:3000](http://localhost:3000).

## Running the CLI app

You may run the `bin/demodx` CLI app against the development server by running:

```bash
$ bin/demodx
```

## Notable Source Code

The source code for this application will teach you [Thor](http://whatisthor.com/), [Terminalwire](https://terminalwire.com), and how to build a better onboarding developer experience.

### Terminal App Source Code

Terminalwire streams the command-line from your Rails server to a thin-client. The source for the command-line app is in the [./app/terminal](https://github.com/terminalwire/demodx/tree/main/app/terminal) folder.

### Main Terminal

The [./app/terminal/main_terminal.rb](./app/terminal/main_terminal.rb) file is the entry point for the terminal app. You'll see that it's mounted in the [./config/routes.rb](https://github.com/terminalwire/demodx/blob/main/config/routes.rb#L2-L4) file.

```ruby
# Has root commands like `demodx open` and delegages additional
# commands to sub-commands.
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
```

Here's what a typical sub-command looks like:

```ruby
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

  # ... more code ...
end
```

### Application Terminal

The [./app/terminal/application_terminal.rb](https://github.com/terminalwire/demodx/blob/main/app/terminal/application_terminal.rb) file has baseline code that's used by all terminal apps, including methods that set the current user, authentication, etc. It's analogous to the `ApplicationController` in Rails.

You'll notice this file extends the `Thor` class and includes the `Terminalwire::Terminal` module. This is what enables streaming for a Thor command-line app from the server to the client.

### Routes

The `MainTerminal` is mounted in the [./config/routes.rb](https://github.com/terminalwire/demodx/blob/main/config/routes.rb#L2-L4) file. The URL of this route is the endpoint for Terminalwire clients and licenses.

```ruby
# Mount a Terminal into a Rails app.
match "/terminal",
  to: Terminalwire::Rails::Thor.new(MainTerminal),
  via: [:get, :connect]
```

## Terminalwire Thin-Client

The command-line app that users install on their workstations looks like [./bin/demodx](https://github.com/terminalwire/demodx/blob/main/bin/demodx). You'll notice it has the same URL that's configured in the Rails routes file, which points to your local development server.

You may need to change the URL of the client if you run your development server on a different URL.

```ruby
#!/usr/bin/env terminalwire-exec
url: "http://localhost:3000/terminal"

# This is the contents of a Terminalwire thin-client binary,
# which is pointing at a development server. Changing the url
# can point it to a different environment, including production.git
```
