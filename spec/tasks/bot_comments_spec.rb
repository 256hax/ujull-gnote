require 'rails_helper'
require 'rake'

RSpec.describe 'Bot comments rails tasks' do
  #--- call Rails Tasks ---#
  before(:all) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require 'tasks/bot_comments'
    Rake::Task.define_task(:environment)
  end

  describe "rails bot_comments:first_waves" do
    before do
      @factory_users = FactoryBot.create(:user)
      @factory_users_summaries = FactoryBot.create(:users_summary)
    end

    context "when user posts messages now" do
      before do
        10.times{
          FactoryBot.create(:n_message_post_now)
        }
      end

      let(:task) { 'bot_comments:first_waves' }

      it "Bot posts comments at least one" do
        @rake[task].invoke # excute Rails Tasks
        expect(Comment.count).to be >= 1
      end
    end

    context "when user posts messages yesterday" do
      before do
        10.times{
          FactoryBot.create(:n_message_post_yesterday)
        }
      end

      let(:task) { 'bot_comments:first_waves' }

      it "Bot posts comments at least one" do
        @rake[task].invoke # excute Rails Tasks
        expect(Comment.count).to eq 0
      end
    end
  end
end
