# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  community_id :bigint           not null
#  post_id      :bigint
#  title        :string           not null
#  content      :text             not null
#  status       :integer          default("draft"), not null
#  pin          :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:article) { create(:post) }

  describe 'validations' do
    it { should validate_presence_of(:community_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  context 'when reply' do
    it 'create a comment' do
      comment = article.reply(article.user, 'Reply')
      expect(article.comments.include?(comment)).to be_truthy
    end

    it 'does not list a deleted comment' do
      comment = article.reply(article.user, 'Reply')
      comment.deleted!

      expect(article.comments.include?(comment)).to be_falsy
    end
  end
end
