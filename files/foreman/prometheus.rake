desc <<-END_DESC
  Create an admin user for prometheus exporter.
END_DESC
namespace :prometheus do
  task :create_user => :environment do
    User.as_anonymous_admin do
        user = User.new(:login => ENV['F_MONITORING_USER'] || 'prometheus',
                        :mail  => ENV['F_MONITORING_MAIL'] || "prometheus@kubernetes.local")
        user.admin=true
        user.auth_source = AuthSourceInternal.find_by_type "AuthSourceInternal"
        user.password = ENV['F_MONITORING_PASSWORD'] || 'changeme'
        user.save
    end
  end
end