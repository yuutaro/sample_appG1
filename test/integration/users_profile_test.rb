require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper                                       # full_titleヘルパーを使用するためにインクルード

  def setup
    @user = users(:michael)
  end

  test "profile display" do                                       # プロフィール画面の表示テスト
    get user_path(@user)                                          # プロフィール画面にアクセス
    assert_template 'users/show'                                  # users/showテンプレートが描画されているか
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
end
