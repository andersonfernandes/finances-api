module RequestHelpers
  def authorization_header(user)
    token = create(:token, user: user, status: :active)
    access_token = JWT.encode(
      token.access_token_payload,
      Figaro.env.secret_key_base
    )

    { 'Authorization' => "Bearer #{access_token}" }
  end

  def response_body
    JSON.parse(response.body)
  end
end
