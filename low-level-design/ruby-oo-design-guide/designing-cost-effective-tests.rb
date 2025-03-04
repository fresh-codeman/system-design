class EmailNotifier
  def send_notification
    puts "Sending email notification..."
  end
end

class User
  def initialize(notifier)
    @notifier = notifier
  end

  def notify
    @notifier.send_notification
  end
end
