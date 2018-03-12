require 'rails_helper'

describe "Designers API" do
  before :each do 
    Designer.destroy_all
    @user = User.create(name: "Erika")
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
  end

  describe "#index" do
    it "returns all designers" do
      get '/api/v1/designers'

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.length).to be(2)
    end
  end

  describe "#show" do
    context "valid designer" do
      it "returns an individual designer" do
        get "/api/v1/designers/#{@novella_royalle.id}"

        json = JSON.parse(response.body)

        expect(response).to be_success
        expect(json["company"]).to eq("Novella Royalle")
      end
    end

    context "invalid designer" do
      it "returns an error message" do
        get "/api/v1/designers/x"
        
        json = JSON.parse(response.body)

        expect(response.status).to eq(404)
      end
    end
  end

  describe "#create" do
    context "valid attributes" do
      it "creates a new instance of a designer" do
        post "/api/v1/designers", params: {designer: {company: "Stone Cold Fox",
                                                      contact: "Frankie",
                                                      phone: "5862432244",
                                                      email: "frankie@frankie.com",
                                                      user_id: @user.id}}
        
        json = JSON.parse(response.body)

        expect(response).to be_success
        expect(Designer.last.company).to eq("Stone Cold Fox")
        expect(Designer.all.count).to eq(3)
      end
    end

    context "invalid attributes" do
      it "will return an error message" do
        post "/api/v1/designers", params: {designer: {company: "Stone Cold Fox",
                                                      contact: "Frankie",
                                                      user_id: @user.id}}
        
        expect(response.status).to eq(400)
      end
    end
  end

  describe "#update" do
    context "valid attributes" do
      it "updates the designer" do
        patch "/api/v1/designers/#{@novella_royalle.id}", params: {designer: {company: "Novella Royalle",
                                                                              contact: "Elaina",
                                                                              phone: "5867816012",
                                                                              email: "elaina@elaina.com",
                                                                              user_id: @user.id}}
      
        designer = Designer.find(@novella_royalle.id)
        expect(designer.company).to eq("Novella Royalle")
        expect(designer.phone).to eq("5867816012")
      end
    end
  end

end