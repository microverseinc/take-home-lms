# frozen_string_literal: true

class Authenticator
  def initialize(app)
    @app = app
    @bearer_token = ENV['API_KEY']
  end

  def call(env)
    auth_header = env['HTTP_AUTHORIZATION']

    return unauthorized_response unless auth_header&.start_with?('Bearer ')

    token = auth_header.split(' ')[1]
    return unauthorized_response unless token == @bearer_token

    @app.call(env)
  end

  private

  def unauthorized_response
    [401, { 'Content-Type' => 'text/plain' }, ['Unauthorized']]
  end
end
