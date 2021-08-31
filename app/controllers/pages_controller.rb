class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:about, :help, :we]

  def about
  end

  def help
  end

  def we
  end
end
