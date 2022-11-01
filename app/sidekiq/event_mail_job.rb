class EventMailJob
  include Sidekiq::Job

  def perform(event_id, record_id, record_class)
    record = record_class.constantize.find(record_id.to_i)
    event = Event.find(event_id.to_i)

    if record.instance_of?(Subscription)
      EventMailer.subscription(event, record).deliver_now
      return
    end

    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [record.user&.email]).uniq

    if record.instance_of?(Photo)
      all_emails.each { |mail| EventMailer.photo(event, record, mail).deliver_now }
    elsif record.instance_of?(Comment)
      all_emails.each { |mail| EventMailer.comment(event, record, mail).deliver_now }
    end
  end
end
