require 'spec_helper'

describe Quill::ActiveRecordExtension do

  let(:users) { [] }

  before do
    (1..105).each do |n|
      users << User.create!(:name => "user-#{n}")
    end
  end

  describe "Users" do

    describe "pagination" do

      it "should correctly paginate" do
        users = User.limit(20)
        page = User.qpage(1)

        page.size.should eql(20)
        page.class.should eql(ActiveRecord::Relation)


        page.each_with_index do |u, idx|
          u.should eql(users[idx])
        end
      end

      it "should grab other pages correctly" do
        page = User.qpage(2)

        page.size.should eql(20)
        page.first.name.should eql("user-21")
      end

    end

    describe "pages" do

      it "should correctly identify if there's a next page" do
        User.qpage(1).next_page?.should be_true
        User.qpage(6).next_page?.should be_false
      end

      it "should correctly identify if there's a previous page" do
        User.qpage(1).previous_page?.should be_false
        User.qpage(6).previous_page?.should be_true
      end

    end

  end

end