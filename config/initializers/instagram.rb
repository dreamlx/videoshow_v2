require "instagram"

# All methods require authentication (either by client ID or access token).
# To get your Instagram OAuth credentials, register an app at http://instagr.am/oauth/client/register/
Instagram.configure do |config|
  config.client_id = '80d957c56456440fa205a651372bbcb3'
  config.client_secret = "5df17d330dff419abe935395f79b5aac"
  #config.access_token = 'YOUR_ACCESS_TOKEN'
end