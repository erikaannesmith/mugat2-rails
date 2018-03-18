require "rails_helper"
require 'date'

describe "Style Comments API" do
  before :each do
    Designer.destroy_all
    Style.destroy_all
    StyleComment.destroy_all
    @user = User.create(email: "Erika")
    @novella_royalle = Designer.create(company: "Novella Royalle", 
                                       contact: "Elaina", 
                                       phone: "3135508645", 
                                       email: "elaina@elaina.com", 
                                       user: @user)
    @jasmine_jumpsuit = Style.create(name: "Jasmine Jumpsuit",
                                     description: "Polka dotted 50's flared leg",
                                     designer: @novella_royalle)
    @cleopatra_dress = Style.create(name: "Cleopatra Dress",
                                    description: "Gold chiffon midi",
                                    designer: @novella_royalle)
    @comment_1 = StyleComment.create(date: Date.new,
                                     body: "Here is my first style comment!",
                                     style_id: @jasmine_jumpsuit.id)
    @comment_2 = StyleComment.create(date: Date.new,
                                     body: "Here is my second style comment!",
                                     style_id: @jasmine_jumpsuit.id)
    @comment_3 = StyleComment.create(date: Date.new,
                                     body: "Here is my third style comment!",
                                     style_id: @cleopatra_dress.id)
  end

  describe "#index" do
    it "returns all styles comments associated with a style" do
      get "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/styles/#{@jasmine_jumpsuit.id}/style_comments"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq(@jasmine_jumpsuit.style_comments.count)
    end
  end

  describe "#create" do
    context "valid attributes" do
      it "creates a new instance of a style comment" do
        post "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/styles/#{@jasmine_jumpsuit.id}/style_comments", params: {style_comment: {date: Date.new,
                                                                                                                                body: "Here is a new comment.",
                                                                                                                                style_id: @jasmine_jumpsuit.id}}
        
        json = JSON.parse(response.body)
        
        expect(response).to be_success
        expect(json["body"]).to eq("Here is a new comment.")
        expect(StyleComment.last.body).to eq("Here is a new comment.")
      end
    end

    context "invalid attributes" do
      it "returns an error message" do
        post "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/styles/#{@jasmine_jumpsuit.id}/style_comments", params: {style_comment: {date: Date.new,
                                                                                                                                style_id: @jasmine_jumpsuit.id}}
        
        expect(response.status).to eq(400)
      end
    end
  end

  describe "#destroy" do
    context "valid style comment" do
      it "destroys the style comment" do
        delete "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/styles/#{@jasmine_jumpsuit.id}/style_comments/#{@comment_1.id}"

        expect(response).to be_success
        expect(response.body).to eq("")

        style_comment = StyleComment.find_by(id: @comment_1.id)

        expect(style_comment).to be_nil
      end
    end

    context "invalid style comment" do
      it "returns an error message" do
        delete "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/styles/#{@jasmine_jumpsuit.id}/style_comments/#{@comment_3.id}"

        expect(response.status).to eq(404)
      end
    end
  end
end