require 'rails_helper'

RSpec.describe Visible do
  let(:user) do
    User.create(
      username: 'eshaik',
      email: 'eduin.shaik.kommit@gmail.com',
      password: 'xyz001',
      info: "We don't know much about him/her, but we're sure that he/she is great."
    )
  end

  let(:article_params_public) do
    {
      title: 'Hello, Rails!',
      body: 'This is the first article on the blog.',
      status: 'public',
      author: user.username
    }
  end
  let(:article_params_private) do
    {
      title: 'Hello, Rails!',
      body: 'This is the first article on the blog.',
      status: 'private',
      author: user.username
    }
  end

  let(:article_params_archived) do
    {
      title: 'Hello, Rails!',
      body: 'This is the first article on the blog.',
      status: 'archived',
      author: user.username
    }
  end

  let(:article_params_other) do
    {
      title: 'Hello, Rails!',
      body: 'This is the first article on the blog.',
      status: 'inprogress',
      author: user.username
    }
  end

  describe 'validate statuses' do
    context 'when status is public or private or archived' do
      it 'with public expects true' do
        article = Article.new(article_params_public)
        expect(article).to be_valid
      end

      it 'with private expects true' do
        article = Article.new(article_params_private)
        expect(article).to be_valid
      end

      it 'with archived expects true' do
        article = Article.new(article_params_archived)
        expect(article).to be_valid
      end
    end

    context 'when status is not public or private or archived' do
      it 'expects false with other status' do
        article = Article.new(article_params_other)
        expect(article).not_to be_valid
      end
    end
  end


  describe '#archived?' do
    context 'when status is archived' do
      it 'expects true' do
        article = Article.create(article_params_archived)
        expect(article.archived?).to eq(true)
      end
    end
  
    context 'when status is not archived' do
      it 'expects false with public' do
        article = Article.create(article_params_public)
        expect(article.archived?).to eq(false)
      end
      
      it 'expects false with private' do
        article = Article.create(article_params_private)
        expect(article.archived?).to eq(false)
      end
    end
  end
end
