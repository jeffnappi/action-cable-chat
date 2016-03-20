class Message < ApplicationRecord
  after_create_commit { BroadcastMessageJob.perform_later self  }
end
