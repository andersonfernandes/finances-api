module RequestHelpers
  def authorization_header(user_id)
    token = JsonWebToken.encode(user_id: user_id)
    { 'Authorization' => token }
  end

  def response_body
    JSON.parse(response.body)
  end
end
