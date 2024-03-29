require 'spec_helper'

describe Relationship do

  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  describe "accessible attribute" do
    it "should not allow access to follower_id" do
      expect do
        Relationship.new(follower_id: follower.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    its(:follower) { should == follower }
    its(:followed) { should == followed }
  end

  describe "when followed id is not present" do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end

  describe "when follower is not present" do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end

  describe "relationship associations" do

    it "should destroy associated follower" do
      relationships = follower.relationships
      follower.destroy

      relationships.each do |r|
        Relationship.find_by_id(r.id).should be_nil
      end
    end

    it "should destroy associated followed user" do
      relationships = followed.relationships
      followed.destroy

      relationships.each do |r|
        Relationship.find_by_id(r.id).should be_nil
      end
    end
  end
end
