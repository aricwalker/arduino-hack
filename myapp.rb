# myapp.rb
 require 'sinatra'
 require 'json'
 require 'net/http'
 require 'uri'
 require 'open-uri'
 require 'logger' 
 require 'erb' 

 set :checkins, 0
 set :activity, 0

 get '/' do
   #count = 300 #checkin_count("39.743824%2C-105.02019")
   #inc_checkin_count()
   erb :index
 end

 post '/venueCheckin' do 
   inc_venue_checkin_count()
 end

 get '/venueCheckin' do 
   count = venue_checkin_count()
   reset_checkin_count()
   content_type :json
    { :count => count }.to_json
 end

 get '/venueCheckinTest' do 
   count = venue_checkin_count()
   content_type :json
    { :count => count }.to_json
 end
 
 get '/venueActivityUp' do 
   inc_venue_activity_count()
 end 

 get '/venueActivityDown' do 
   dec_venue_activity_count()
 end
 
 get '/venueActivity' do 
  count = venue_activity_count()
  content_type :json
    { :count => count }.to_json
 end

 def checkin_count(ll) 
   url = "https://api.foursquare.com/v2/venues/search?ll=#{ll}&oauth_token=UXXGMQRINDHFFANQGZS4PHKHAFAHYHAHLOSSIKAPUVF5HZKX&v=20110917&limit=50"
   output = nil
   open(url) {|f|
      output = f.read()
   }
   checkinData = JSON.parse(output)
   checkinData["response"]["venues"].inject(0) { |sum, venue|
      sum + (venue["hereNow"]["count"] || 0)
   }
 end

 def venue_checkin_count()
   settings.checkins
 end

 def inc_venue_checkin_count()
   settings.checkins = settings.checkins + 1
 end

 def inc_venue_activity_count()
   settings.activity += 20
 end

 def dec_venue_activity_count()
   settings.activity -= 20
 end

 def venue_activity_count()
   settings.activity
 end

 def reset_checkin_count()
   settings.checkins = 0
 end

 # Hackfest2011 ids
 # CLIENT ID
 #BTQ3WSOBYL04SMDVKBJJERODROFWXGOTVQV43RDO3PXRE54Y
 # CLIENT SECRET
 #YRKB0IGT4IFZUGXAQ3KAK1ERPJ2CL3LCINQA44ZVF5VZCLUT
  
 #Hackfest2 keys
 #CLIENT ID
 #PZKJUM3JWL35O32B3SQGHSCSCWGRZ45ADEMQBIFEV4PGOKR3
 #CLIENT SECRET
 #O00EXPAK5P4AXFIWEH3HXDMZXCAUNWLZT4H45JXAGT023X5S
  
 #hackfest3 keys
 #CLIENT ID
 #HV4A2IAQCY5E5UIR1WI1UWYXTFQR2HBJDS0JI5C0MS2WZNFT
 #CLIENT SECRET
 #1ACHAB0FTDYWHDHWYZ2CIQKNFXQFXJHK2TVGR5S3AXEXG2ZR

