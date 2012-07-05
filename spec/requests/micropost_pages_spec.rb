require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.should_not change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.should change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.should change(Micropost, :count).by(-1)
      end
    end
  end

  describe "microposts pagination" do
    before do
      FactoryGirl.create(:micropost, user: user, content: "First post")
      50.times { FactoryGirl.create(:micropost, user: user) }
    end

    before { visit root_path }

    describe "page 1" do
      it { should_not have_content('First post') }
      it { should have_content('Next') }
    end

    describe "page 2" do
      before { click_link "Next" }

      it { should have_content('First post') }
    end
  end
end
