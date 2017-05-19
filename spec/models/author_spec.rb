require 'rails_helper'

RSpec.describe Author, type: :model do

  context 'valid inputs' do

    it 'saves to database' do
      @author = create(:author)
      expect(Author.last).to eq(@author)
    end

    it "books can be added to author's books" do
      @author = create(:author, name:"Bro")
      @book = create(:book, title:"Stuff", author:@author)
      expect(@author.books).to include(@book)


    end



  end

  context 'invalid inputs' do
    it "if name is not blank it doesnt save to database" do
      @author = build(:author, name:'')
      expect(@author.save).to eq(false)
    end
  end



end
