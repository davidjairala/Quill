require 'spec_helper'

describe Quill::ActiveRecordExtension do

  let(:users) { [] }

  before do
    (1..100).each do |n|
      users << User.create!(:name => "user-#{n}")
    end
  end

  describe "Users" do

    describe "total_count" do

      it "should correctly get the total number of items in the set" do
        User.page(1).total_count.should eql(100)
      end

      it "should only run the count query once per instance" do
        ActiveRecord::Relation.any_instance.expects(:count).returns(100).once

        page = User.page(1)

        page.total_count.should eql(100)
        page.total_count.should eql(100)
      end

    end

    describe "caching" do

      describe "page caching" do

        it "should correctly determine the page cache key" do
          User.cache_key(:page => 2).should eql('q_users_2_20')
          User.cache_key(:page => 1).should eql('q_users_1_20')
          User.cache_key(:page => 4, :per => 10).should eql('q_users_4_10')
        end

        it "should correctly set the page cache" do
          key = User.cache_key(:page => 1)
          User.page(1)

          cache_users = Rails.cache.read(key)
          cache_users.should be_present

          cache_users.size.should eql(20)

          cache_users.each_with_index do |u, idx|
            u.should eql(users[idx])
          end
        end

        it "should correctly set the page cache for non-default values" do
          key = User.cache_key(:page => 2)
          User.page(2)

          cache_users = Rails.cache.read(key)
          cache_users.should be_present

          cache_users.size.should eql(20)

          cache_users.each_with_index do |u, idx|
            i = idx + (20)
            u.should eql(users[i])
          end
        end

      end

    end

    it "should correctly get the total number of pages in the set" do
      User.page(1).total_pages.should eql(5)
    end

    it "should allow overriding the number of results per page" do
      User.page(1).per(10).size.should eql(10)
    end

    it "should correctly determine if there is a next page" do
      User.page(1).next_page?.should be_true
      User.page(5).next_page?.should be_false
    end

    it "should correctly determine if there is a previous page" do
      User.page(2).previous_page?.should be_true
      User.page(1).previous_page?.should be_false
    end

    it "should correctly get a page of users" do
      page = User.page(1)

      page.size.should eql(20)

      page.each_with_index do |u, idx|
        u.should eql(users[idx])
      end
    end

  end

end