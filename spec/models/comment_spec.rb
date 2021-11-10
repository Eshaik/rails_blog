require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) do
    User.create(
      username: 'celd902',
      email: 'celd902@hotmail.com',
      password: 'xyz001',
      info: "We don't know much about him/her, but we're sure that he/she is great."
    )
  end

  let(:article) do
    Article.create(
      title: 'Hello, Rails!',
      body: 'This is the first article on the blog.',
      status: 'public',
      author: 'eshaik'
    )
  end

  subject do
    described_class.new(
      commenter: "#{author}",
      body: 'Nice article!',
      status: 'public',
      article_id: article.id
    )
  end

  let(:author) { user.username }

  # Testing creation:
  describe 'belongs to article' do
    it 'no relation' do
      subject.article_id = nil
      expect(subject).not_to be_valid
    end

    it 'relation with a non-existent article' do
      subject.article_id = 0
      expect(subject).not_to be_valid
    end 

    it 'relation with existing article' do
      subject.article_id = article.id
      expect(subject).to be_valid
    end
  end

  context 'when has valid attributes' do
    it { is_expected.to be_valid }
  end

  #Testing scopes:
  describe ".publics" do
    it "includes comments with public status" do
      comment1 = article.comments.create(status: 'public')
      expect(Comment.publics).to include(comment1)
    end

    it 'exclude comments with private/archived status' do
      comment2 = article.comments.create(status: 'private')
      comment3 = article.comments.create(status: 'archived')
      expect(Comment.publics).not_to include(comment2)
      expect(Comment.publics).not_to include(comment3)
    end
  end
  
  describe ".owner_u" do
    it 'includes comments with specific commenter' do
      comment1 = article.comments.create(commenter: user.username, status: 'public')
      expect(Comment.owner_u(user)).to include(comment1)
    end

    it 'excludes comments with other commenter' do
     comment1 = article.comments.create(commenter: 'kommiter', status: 'public')
     expect(Comment.owner_u(user)).not_to include(comment1) 
    end
  end

  #Testing methods:
  describe '#owner' do
    context 'when owner is an existing user' do
      it 'expects true' do
        expect(subject.owner).to eq(user), "Hey, I expected #{user} but I got #{subject.owner} instead!"
      end
    end

    context 'when the owner is not an existing user' do
      let(:author) { 'kommiter' }
      it 'expects false' do
        expect(subject.owner).to be_nil
      end
    end
  end
end
