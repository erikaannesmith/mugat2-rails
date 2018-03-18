require 'rails_helper'
require 'date'

describe "Designer Comments API" do
  before :each do
    Designer.destroy_all
    DesignerComment.destroy_all
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
    @comment_1 = DesignerComment.create(date: Date.new,
                                        body: "Here is my first comment!",
                                        designer_id: @novella_royalle.id)
    @comment_2 = DesignerComment.create(date: Date.new,
                                        body: "Here is my second comment!",
                                        designer_id: @novella_royalle.id)
    @comment_3 = DesignerComment.create(date: Date.new,
                                        body: "Here is my third comment!",
                                        designer_id: @planet_blue.id)
  end

  describe "#index" do
    it "returns all designer comments associated with a designer" do
      get "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/designer_comments"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq(2)
    end
  end

  describe "#create" do
    context "valid attributes" do
      it "creates a new instance of a designer comment" do
        post "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/designer_comments", params: {designer_comment: {date: Date.new,
                                                                                                       body: "Here is a new comment.",
                                                                                                       designer_id: @novella_royalle.id}}

        json = JSON.parse(response.body)

        expect(response).to be_success
        expect(json["body"]).to eq("Here is a new comment.")
        expect(@novella_royalle.designer_comments.count).to eq(3)
      end
    end

    context "invalid attributes" do
      it "returns an error message" do
        post "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/designer_comments", params: {designer_comment: {date: Date.new,
                                                                                                       designer_id: @novella_royalle.id}}

        expect(response.status).to eq(400)
        expect(@novella_royalle.designer_comments.count).to eq(2)
      end
    end
  end

  describe "#destroy" do
    context "valid designer comment" do
      it "destroys the designer comment" do
        delete "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/designer_comments/#{@comment_1.id}"

        expect(response).to be_success
        expect(response.body).to eq("")

        designer_comment = DesignerComment.find_by(id: @comment_1.id)

        expect(designer_comment).to be_nil
      end
    end

    context "invalid designer comment" do
      it "returns an error message" do
        delete "/api/v1/users/#{@user.id}/designers/#{@novella_royalle.id}/designer_comments/#{@comment_3.id}"

        expect(response.status).to eq(404)
      end
    end
  end
end