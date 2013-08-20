OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  id = "165187500340089"
  secret = "bd71bf1d4fa6d1b605bf87193bee8f15"
  provider :facebook, id, secret
end