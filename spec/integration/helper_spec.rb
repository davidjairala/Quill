require 'spec_helper'

describe Quill::ActionViewExtension do

  let(:users) { [] }

  before do
    (1..105).each do |n|
      users << User.create!(:name => "user-#{n}")
    end
  end

  it "should correctly display the pagination helper" do
    visit '/users'

    response.should contain(users.first.name)
    response.should_not contain(users.last.name)

    response.should contain('Next page')
  end

  it "should correctly display pagination for specific pages" do
    visit '/users?page=2'

    response.should contain('Previous page')
    response.should contain('Next page')
  end

  it "should correctly move between pages" do
    visit '/users'

    click_link /next page/i

    response.should contain(users[25].name)

    click_link /previous page/i

    response.should contain(users.first.name)
  end

end