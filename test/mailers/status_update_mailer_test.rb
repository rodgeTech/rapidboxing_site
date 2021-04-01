require 'test_helper'

class StatusUpdateMailerTest < ActionMailer::TestCase
  test "status_updated" do
    mail = StatusUpdateMailer.status_updated
    assert_equal "Status updated", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
