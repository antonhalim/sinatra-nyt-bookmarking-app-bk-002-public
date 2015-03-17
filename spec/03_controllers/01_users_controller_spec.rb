describe UsersController do
  let(:attributes) {
    {
      :name => "Isabel Correia",
      :avatar => "http://isabel-correia.jpg.to/"
    }
  }
  let(:user) { User.create(attributes) }
  context "GET" do
    describe "#show" do
      before do
        get "/users/#{user.id}"
      end

      it "responds with a 200 status code" do
        expect(last_response).to be_successful
        expect(last_response).to be_ok
      end

      it "renders the show template" do
        html_parts = [
          "Isabel Correia", 
          'Bookmarked Articles', 
          'Read Articles', 
          '<img src="http://isabel-correia.jpg.to/"', 
          "<a href=\"/users/#{user.id}/articles\">View Articles</a>"
        ]
        html_parts.each do |html|
          expect(last_response.body).to include(html)
        end
      end

      it "displays the user's avatar in a img tag with a class of 'avatar'" do
        visit "/users/#{user.id}"
        expect(page.find('.avatar')['src']).to eq(attributes[:avatar])
      end
    end

    describe "#new" do
      before do
        get "/users/new"
      end

      it "responds with a 200 status code" do
        expect(last_response).to be_successful
        expect(last_response).to be_ok
      end

      it "renders the new template" do  
        expect(last_response.body).to include('<form action="/users" method="post">') 
        attributes.each do |method, value|
          field_name = "name=\"user[#{method}]\">"
          expect(last_response.body).to include(field_name)  
        end
        expect(last_response.body).to include('<input type="submit" value="Sign Up"')
      end
    end

    describe "#edit" do
      before do
        get "/users/#{user.id}/edit"
      end

      it "responds with a 200 status code" do
        expect(last_response).to be_ok
      end

      it "renders the edit template" do
        expect(last_response.body).to include("<h1>Editing User</h1>")  
        
        form = "<form action=\"/users/#{user.id}\" method=\"post\">"
        expect(last_response.body).to include(form)
        
        patch_method = '<input type="hidden" name="_method" value="patch">'
        expect(last_response.body).to include(patch_method)

        attributes.each do |method, value|
          field_name = "name=\"user[#{method}]\">"
          expect(last_response.body).to include(field_name)
          expect(last_response.body).to include(user.send(method))
        end
        
        expect(last_response.body).to include('<input type="submit" value="Submit"')
      end
    end
  end

  context "POST" do
    describe "#create" do
      before(:all) do
        @name = 'Sojourner Truth'
        @avatar = 'http://upload.wikimedia.org/wikipedia/commons/0/0d/Sojourner_Truth_c1864.jpg'
        post "/users", {:'user[name]'=> @name, :'user[avatar]'=> @avatar}
        follow_redirect!  
      end

      it "adds the user to the database" do
        sojourner = User.find_by(:name => @name)
        expect(sojourner.id).to_not be_nil
        expect(sojourner.avatar).to eq(@avatar)
      end

      it "redirects to the users's show page" do
        sojourner = User.find_by(:name => @name)
        expect(last_request.url).to eq("http://example.org/users/#{sojourner.id}")
      end
    end
  end

  context "PATCH" do
    describe "#update" do
      before(:all) do
        @old_attributes = {
          :name => ' Harriettt Tubman',
          :avatar => 'http://upload.wikimedia.org/wikipedia/commons/5/5d/Harriet-Tubman-248x300.jpg',
        }
        @updated_attributes = {
          :name => 'Harriet Tubman',
          :avatar => 'http://www.herstorynetwork.com/wp-content/uploads/harriet-tubman.jpg',
        }
        @user = User.create(@old_attributes)
        params =  {
          :'user[name]' => @updated_attributes[:name], 
          :'user[avatar]' => @updated_attributes[:avatar]
        }
        patch "/users/#{@user.id}", params
        follow_redirect!
      end

      it "updates the database" do
        found = User.find_by(:name => @old_attributes[:name])
        expect(found).to be_nil
      end

      it "redirects to the user's show page" do
        expect(last_request.url).to eq("http://example.org/users/#{@user.id}")
      end

      it "updates all the attributes" do
        @old_attributes.each do |type, value|
          expect(last_response.body).to_not include(value)
        end
        @updated_attributes.each do |type, value|
          expect(last_response.body).to include(value)
        end
      end
    end
  end

  context "DELETE" do
    describe "#destory" do
      before do
        @attributes = {
          :name => 'Maria W. Stewart',
          :avatar => 'http://zinnedproject.wpengine.netdna-cdn.com/wp-content/uploads/2011/12/mariastewart.jpg',
        }
        user = User.create(@attributes)
        @user_id = user.id
        delete "/users/#{@user.id}"
        follow_redirect!
      end

      it "responds with a 200 status code" do
        expect(last_response).to be_ok
      end

      it "redirects to the home page" do
        expect(last_request.url).to eq("http://example.org/")
      end

      it "deletes the user from the database" do
        @attributes[:id] = @user_id
        @attributes.each do |attribute, value|
          found = User.find_by(attribute => value)
          expect(found).to be_nil
        end
      end

      it "delelets all the bookmarks that joined the user to articles" do
        found_bookmarks = Bookmark.where(:user_id => @user_id)
        expect(found_bookmarks).to be_empty
      end
    end
  end
end