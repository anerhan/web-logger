FactoryGirl.define do
  factory :project do
    name 'test-api'
    log_files [{ name: 'production.log', path: '/tmp/logs/production.log'}, { name: 'unicorn.log', path: '/tmp/logs/unicorn.log'}, { name: 'nginx.log', path: '/tmp/logs/nginx.log'}]
  end
end
