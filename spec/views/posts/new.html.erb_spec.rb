require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    assign(:post, Post.new(
      body: "MyText",
      user: nil
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "textarea[name=?]", "post[body]"

      assert_select "input[name=?]", "post[user_id]"
    end
  end
end
