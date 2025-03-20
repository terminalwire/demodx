# README

This is a demo Rails app that shows how a SaaS can improve their developer experience and streamline onboarding by eliminating the "point click point click ..." instructions of getting an API key to "Install this CLI and run `demodx apitoken create`."

## Live Demo

A live demo for this app is available at [https://demodx.terminalwire.com](https://demodx.terminalwire.com).

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

### Application Terminal

The [./app/terminal/application_terminal.rb](https://github.com/terminalwire/demodx/blob/main/app/terminal/application_terminal.rb) file has baseline code that's used by all terminal apps, including methods that set the current user, authentication, etc. It's analogous to the `ApplicationController` in Rails.

You'll notice this file extends the `Thor` class and includes the `Terminalwire::Terminal` module. This is what enables streaming for a Thor command-line app from the server to the client.

### Routes

The `MainTerminal` is mounted in the [./config/routes.rb](https://github.com/terminalwire/demodx/blob/main/config/routes.rb#L2-L4) file. The URL of this route is the endpoint for Terminalwire clients and licenses.

## Terminalwire Thin-Client

The command-line app that users install on their workstations looks like [./bin/demodx](https://github.com/terminalwire/demodx/blob/main/bin/demodx). You'll notice it has the same URL that's configured in the Rails routes file, which points to your local development server.

You may need to change the URL of the client if you run your development server on a different URL.
