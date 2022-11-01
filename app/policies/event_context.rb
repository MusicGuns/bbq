class EventContext
  attr_reader :event, :password, :cookies

  def initialize(cookies, event, password)
    @cookies = cookies
    @event = event
    @password = password
  end
end
