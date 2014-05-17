# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :home_top_advert do
    type ""
    name "MyString"
    pic_url ""
    advert_url ""
    advert_content "MyText"
    sort ""
    status ""
    ctime ""
    etime ""
  end
end
