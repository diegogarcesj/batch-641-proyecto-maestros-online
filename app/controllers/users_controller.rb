class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = [{lat:@user.latitude, lng:@user.longitude}]
  end
end
