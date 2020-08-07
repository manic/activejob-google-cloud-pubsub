module ActiveJob
  module GoogleCloudPubsub
    autoload :Adapter, 'activejob_google_cloud_pubsub/adapter'
    autoload :VERSION, 'activejob_google_cloud_pubsub/version'
    autoload :Worker,  'activejob_google_cloud_pubsub/worker'

    def self.register_action(action, klass)
      @mapped_action_klass ||= {}
      @mapped_action_klass[action] = klass
    end

    def self.fetch_class(action)
      @mapped_action_klass ||= {}
      @mapped_action_klass[action]
    end
  end
end

require 'active_job'
require 'google/cloud/pubsub'

ActiveJob::QueueAdapters.autoload :GoogleCloudPubsubAdapter, 'activejob_google_cloud_pubsub/adapter'
