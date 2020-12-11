# frozen_string_literal: true

RSpec.describe "POST /api/articles", type: :request do
  let(:visitor) { create(:user, role: "visitor") }
  let(:visitor_headers) { { HTTP_ACCEPT: "application/json" } }
  let(:registered_user) { create(:user, role: "registered_user") }
  let(:registered_user_headers) { registered_user.create_new_auth_token }
  let(:journalist) { create(:user, role: "journalist") }
  let(:journalist_headers) { journalist.create_new_auth_token }

  describe "Journalist can create an article" do
    before do
      post "/api/articles",
        params: {
          article: {
            title: "Test title",
            sub_title: "Test subtitle",
            author: "Test author",
            content: "Test content!",
          },
        },
        headers: journalist_headers
    end
    it "is expected to return 201 status" do
      expect(response).to have_http_status 201
    end

    it "is expected to return a success message" do
      expect(response_json).to have_key("message").and have_value("Your article was successfully created!")
    end
  end

  describe "Registered user can not create an article" do
    before do
      post "/api/articles",
        params: {
          article: {
            title: "Test title",
            sub_title: "Test subtitle",
            author: "Test author",
            content: "Test content!",
          },
        },
        headers: registered_user_headers
    end

    it "is expected to return 401 status" do
      expect(response).to have_http_status 401
    end

    it "is expected to return an error message" do
      expect(response_json).to have_key("message").and have_value("You are not authorized to create an article.")
    end
  end

  describe "Visitor can not create an article" do
    before do
      post "/api/articles",
        params: {
          article: {
            title: "Test title",
            sub_title: "Test subtitle",
            author: "Test author",
            content: "Test content!",
          },
        },
        headers: visitor_headers
    end

    it "is expected to return 401 status" do
      expect(response).to have_http_status 401
    end

    it "is expected to return an error message" do
      expect(response_json["errors"]).to eq ["You need to sign in or sign up before continuing."]
    end
  end
end
