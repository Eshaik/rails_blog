require 'rails_helper'

RSpec.describe 'Comment', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    User.create(
      username: 'celd902',
      email: 'celd902@hotmail.com',
      password: 'xyz001',
      info: "We don't know much about him/her, but we're sure that he/she is great."
    )
  end

  before do
    sign_in user
  end

  let(:article) do
    Article.create(
      title: 'Hello, Rails!',
      body: 'This is the first article on the blog.',
      status: 'public',
      author: user.username
    )
  end

  let(:valid_params) do
    {
      body: 'Nice article!',
      status: 'public',
      commenter: user.username
    }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
        it 'expects to create and redirect' do
          comment_params = {
              comment: {
                body: valid_params[:body],
                status: valid_params[:status],
                commenter: valid_params[:commenter]
              }
          }
          # creating and checking is created
          expect { post article_comments_path(article), params: comment_params }.to change { Comment.count }.by(1)
          # redirect
          expect(response).to redirect_to(article_path(article))
        end
    end
  end

  describe 'DELETE #destroy' do
    context "when delete article's comment and redirect to article"
      it'expects to find the comment and destroy it' do
        # create
        comment1 = article.comments.create(body: 'nice article', commenter: user.username, status: 'public')
        # checking that is created
        expect(article.comments.count).to eq(1)

        # delete
        delete article_comment_path(article.id, comment1.id)

        # checking that is deleted
        expect(article.comments.count).to eq(0)

        # redirect
        expect(response).to redirect_to(article_path(article))
      end

  end

end
