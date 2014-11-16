require 'csv'
require 'securerandom'


class UrlShortnerController < ActionController::Base
  URLS = '/tmp/urldata.txt'

  def display
    @shortened = params[:id]

    if not @shortened or @shortened.empty? then
      head(404)
    else
      urldata = CSV.open(URLS)
      entity = urldata.select {|e| !e.empty? and e[0] == @shortened}[0]
      @url = entity[1]
      render 'display' 
    end
  end

  def short
    u = params[:url]
    @link = u[:link]
		
		urldata = CSV.open(URLS)
    entity = urldata.select {|e| !e.empty? and e[1] == @link}[0]
		
		if not entity or entity == [] then
			@short = SecureRandom.hex[0..5]

			CSV.open(URLS, 'a') do |csv_object|
				csv_object << [@short, @link]
    	end
		else
			@short = entity[0]
		end

    redirect_to({:action => :display, :id => @short})
  end

  def index
    @shortened = params[:id]
    if @shortened then
      urldata = CSV.open(URLS)
      entity = urldata.select {|e| !e.empty? and e[0] == @shortened}[0]

    	if entity and !entity.empty? then							
      	redirect_to entity[1]
      	return ;
    	end
    end
    render 'index'
  end

end
