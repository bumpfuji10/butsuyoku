module RequstHelpers
  def json
    JSON.parse(response.body)
  end
end
