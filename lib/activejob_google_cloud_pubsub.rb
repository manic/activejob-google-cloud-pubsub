module ActiveJob
  module GoogleCloudPubsub
    autoload :Adapter, 'activejob_google_cloud_pubsub/adapter'
    autoload :VERSION, 'activejob_google_cloud_pubsub/version'
    autoload :Worker,  'activejob_google_cloud_pubsub/worker'
  end
end

require 'active_job'
require 'google/cloud/pubsub'

ActiveJob::QueueAdapters.autoload :GoogleCloudPubsubAdapter, 'activejob_google_cloud_pubsub/adapter'
