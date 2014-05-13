# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :req_config_cach, :class => 'ReqConfigCache' do
    config_id ""
    type ""
    page ""
    content ""
    update_time ""
  end
end
