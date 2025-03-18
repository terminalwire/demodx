class TerminalAuthorizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_terminal_authorization

  def update
    if confirmation.approve?
      @terminal_authorization.publish JSON.generate(
        status: "approved",
        user_id: current_user.id
      )
      render "approved", status: :see_other
    else
      @terminal_authorization.publish JSON.generate(
        status: "denied",
        user_id: current_user.id
      )
      render "denied", status: :see_other
    end
  end

  protected

  def set_terminal_authorization
    @terminal_authorization = Terminalwire::Rails::Channel.find(params[:id])
  end

  def confirmation
    params.fetch(:commit, "deny").downcase.inquiry
  end
end
