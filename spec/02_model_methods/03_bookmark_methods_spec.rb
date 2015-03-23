describe Bookmark do

  before(:all) do
    @avi = User.create(:name => "Avi Flombaum", :avatar => "https://pbs.twimg.com/profile_images/464511280833785856/oVjSmCu9_400x400.jpeg")
    @steven = User.create(:name => "Steven Nunez", :avatar => "https://pbs.twimg.com/profile_images/378800000342325291/5537f4d7ec05c42a22b0035c8698b15a_400x400.png")
    @ucla_article = Article.find_by(:title => "In U.C.L.A. Debate Over Jewish Student, Echoes on Campus of Old Biases")

    @first_article  = Article.find_by(:title => "Did a Human or a Computer Write This?")
    @second_article = Article.find_by(:title => "The Feel-Good Gene")
    @third_article  = Article.find_by(:title => "With the Clintons, Only the Shadow Knows")
    @forth_article  = Article.find_by(:title => "It's Not Always Depression")
    all_articles = [@first_article, @second_article, @third_article, @forth_article]
    
    @avis_bookmarked_articles = all_articles.map do |article|
      b = Bookmark.create(:user_id => @avi.id, :article_id => article.id, :read => false)
      b.article
    end

    @stevens_bookmarked_articles = [@first_article, @third_article].map do |article|
      b = Bookmark.create(:user_id => @steven.id, :article_id => article.id, :read => false)
      b.article
    end

    @steven.bookmarks.last.update(:read => true)
  end

  describe ".delete_associated_bookmarks" do
    it "accepts one argument, a user object or an article object" do
      expect { Bookmark.delete_associated_bookmarks(@avi) }.to_not raise_error
      expect { Bookmark.delete_associated_bookmarks(@first_article) }.to_not raise_error
    end

    it "deletes all the bookmarks associated with the object" do
      Bookmark.delete_associated_bookmarks(@avi)
      expect(@avi.bookmarks).to be_empty
      expect(@avi.articles).to_not include(@first_article)

      Bookmark.delete_associated_bookmarks(@third_article)
      expect(Bookmark.where(:article_id => @third_article.id)).to be_empty
    end 
  end
end
