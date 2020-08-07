require 'google/cloud/pubsub'

module ActiveJob
  module GoogleCloudPubsub
    module PubsubExtension
      refine Google::Cloud::Pubsub::Project do
        def topic_for(queue_name)
          topic(queue_name) || create_topic(queue_name)
        end

        def subscription_for(queue_name, worker_name: nil)
          name = worker_name || "#{queue_name}-worker"
          subscription(name) || topic_for(queue_name).subscribe(name)
        end
      end

      refine Google::Cloud::Pubsub::ReceivedMessage do
        def scheduled_at
          return nil unless (timestamp = attributes['timestamp'])

          Time.at(timestamp.to_f)
        end

        def remaining_time_to_schedule
          scheduled_at ? [(scheduled_at - Time.now).to_f.ceil, 0].max : 0
        end

        def time_to_process?
          remaining_time_to_schedule.zero?
        end
      end
    end
  end
end
