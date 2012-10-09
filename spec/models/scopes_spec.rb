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

      it "should correctly identify if it's the first page" do
        User.qpage(1).should be_first_page
        User.qpage(3).should_not be_first_page
      end

      it "should correctly identify if it's the last page" do
        User.qpage(1).should_not be_last_page
        User.qpage(6).should be_last_page
      end

      it "should correctly retrieve the current page number" do
        User.qpage(1).current_page.should eql(1)
        User.qpage(5).current_page.should eql(5)
      end

    end

    describe "counting" do

      it "should correctly count the total results" do
        User.qpage(1).total_count.should eql(105)
      end

      it "should correctly get the total number of pages" do
        User.qpage(1).total_pages.should eql(6)
      end

    end

    describe "accessors" do

      it "should get the limit_value" do
        User.qpage(1).limit_value.should eql(20)
      end

      it "should get the offset_value" do
        User.qpage(1).offset_value.should eql(0)
        User.qpage(4).offset_value.should eql(60)
      end

    end

  end

end