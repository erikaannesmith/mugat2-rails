require 'rails_helper'

describe "Styles API" do
  before :each do 
    Designer.destroy_all
    Style.destroy_all
    @user = User.create(email: "Erika")
    @novella_royalle = Designer.create(company: "Novella Royalle", 
                                       contact: "Elaina", 
                                       phone: "3135508645", 
                                       email: "elaina@elaina.com", 
                                       user: @user)
    @planet_blue = Designer.create(company: "Planet Blue", 
                                   contact: "Mac", 
                                   phone: "5868504413", 
                                   email: "mac@mac.com", 
                                   user: @user)
    @jasmine_jumpsuit = Style.create(name: "Jasmine Jumpsuit",
                                     description: "Polka dotted 50's flared leg",
                                     designer: @novella_royalle)
    @cleopatra_dress = Style.create(name: "Cleopatra Dress",
                                    description: "Gold chiffon midi",
                                    designer: @novella_royalle)
    @aribella_top = Style.create(name: "Aribella Top",
                                 description: "Black cross waist crop",
                                 designer: @planet_blue)
  end

  describe "#index" do
    it "returns all styles associated with a designer" do
      get "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/styles"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.length).to be(2)
    end
  end

  describe "#show" do
    context "valid style" do
      it "returns an individual style" do
        get "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/styles/#{@jasmine_jumpsuit.id}"

        json = JSON.parse(response.body)

        expect(response).to be_success
        expect(json["name"]).to eq("Jasmine Jumpsuit")
        expect(json["description"]).to eq("Polka dotted 50's flared leg")
      end
    end

    context "invalid style" do
      it "returns an error message" do
        get "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/styles/#{@aribella_top.id}"

        json = JSON.parse(response.body)

        expect(response.status).to eq(404)
      end
    end
  end

  describe "#create" do
    context "valid attributes" do
      it "creates a new instance of a style" do
        post "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/styles", params: {style: {name: "Eli Blouse",
                                                                                description: "Frilled long sleeves with cherry print",
                                                                                designer_id: @novella_royalle.id}}
        
        json = JSON.parse(response.body)

        expect(response).to be_success
        expect(Style.last.name).to eq("Eli Blouse")
        expect(Style.last.description).to eq("Frilled long sleeves with cherry print")
        expect(@novella_royalle.styles.count).to eq(3)   
      end 
    end

    context "invalid attributes" do
      it "returns an error message" do
        post "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/styles", params: {style: {name: "Eli Blouse",
                                                                                designer_id: @novella_royalle.id}}
        
        expect(response.status).to eq(400)
      end
    end
  end
end