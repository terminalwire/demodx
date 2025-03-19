module ApplicationHelper
  def command(*tokens)
    tokens.prepend(MainTerminal.basename).join(' ')
  end
end
