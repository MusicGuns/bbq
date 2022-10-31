class EventContext
  attr_reader :event, :password

  def initialize(event, password)
    @event = event
    @password = password
  end
end