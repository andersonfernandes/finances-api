module RequestHelpers
  def authorization_header(user)
    token = create(:token, user: user, status: :active)
    access_token = JWT.encode(
      token.access_token_payload,
      ENV['SECRET_KEY_BASE']
    )

    { 'Authorization' => "Bearer #{access_token}" }
  end

  def response_body
    JSON.parse(response.body)
  end
end
