require 'rails_helper'
require 'rake'

RSpec.describe 'Bot comments rails tasks' do
  before(:all) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require 'tasks/bot_comments'
    Rake::Task.define_task(:environment)
  end

  describe "rails bot_comments:first_waves" do
    context "when user posts messages within an hour" do
      before do
        @factory_users = FactoryBot.create(:user)
        @factory_users_summaries = FactoryBot.create(:users_summary)
        10.times{
          FactoryBot.create(:n_message_post_now)
          FactoryBot.create(:n_message_post_yesterday)
        }
      end

      let(:task) { 'bot_comments:first_waves' }

      it "Bot posts comments at least one" do
        # [todo]
        # Test Case1: posted within an hour, Case2: posted over an hour
        # Fix timestamp bug in posted messages
        expect(@rake[task].invoke).to be_truthy
      end
    end
  end
end
