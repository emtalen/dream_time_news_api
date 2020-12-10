# frozen_string_literal: true

RSpec.describe "POST /api/articles", type: :request do
  let(:visitor) { create(:user, role: "visitor") }
  let(:registered_user) { create(:user, role: "registered_user") }
  let(:registered_user_headers) { registered_user.create_new_auth_token }
  let(:journalist) { create(:user, role: "journalist") }
  let(:journalist_headers) { journalist.create_new_auth_token }

  describe "journalist can create an article" do
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
    it "is expected to return a success status" do
      expect(response).to have_http_status 201
    end

    it "is expected to return a success message" do
      expect(response_json)
      .to have_key("message")
      .and have_value("Your article was successfully created!")
    end
  end
end
