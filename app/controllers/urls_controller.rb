class UrlsController < ApplicationController

  before_action :authenticate_user!, :except => :redirectors

  def index
    p user_signed_in?
    @url = Url.new
    @urls = Url.all
  end

  def create
    @url = Url.new( url_params )
    @url.save
    redirect_to urls_path
  end

  def show
    @url = Url.find( params[:id] )
  end

  def preview
    @url = Url.find_by( hashed:  params[:code] )
  end

  def redirectors
    @url = Url.find_by( hashed:  params[:code] )
    redirect_to @url.link
  end

  def destroy
    @url = Url.find( params[:id] )
    @url.destroy 
    redirect_to urls_path
  end

  private

  def url_params
    params.require( :url ).permit( :link )
  end

end
