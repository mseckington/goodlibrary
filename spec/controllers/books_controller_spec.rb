require 'spec_helper'

describe BooksController do

  describe ":index" do
    before do
      Book.stub_chain(:with_image, :all)
    end
    let(:books) { double(:books) }

    it 'fetches all books with images' do
      Book.stub_chain(:with_image, :all).and_return(books)

      get :index
      expect(assigns(:books)).to eql(books)
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

end
