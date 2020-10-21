RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  #config.include Devise::Test::IntegrationHelpers
  #config.include Devise::TestHelpers, type: :controller
  config.include Warden::Test::Helpers
end