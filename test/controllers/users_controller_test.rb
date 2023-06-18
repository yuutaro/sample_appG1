require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    # edit_user_path(@user)にアクセス
    get edit_user_path(@user)
    # フラッシュメッセージが表示されることを確認
    assert_not flash.empty?
    # ログイン画面にリダイレクトされることを確認
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    # patch user_path(@user)にアクセス
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    # フラッシュメッセージが表示されることを確認
    assert_not flash.empty?
    # ログイン画面にリダイレクトされることを確認
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user) # @other_userでログイン
    get edit_user_path(@user) # @userの編集ページにアクセス
    assert flash.empty? # フラッシュメッセージが表示されないことを確認
    assert_redirected_to root_url # ルートURLにリダイレクトされることを確認
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user) # @other_userでログイン
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } } # @userを更新
    assert flash.empty? # フラッシュメッセージが表示されないことを確認
    assert_redirected_to root_url # ルートURLにリダイレクトされることを確認
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do 
      delete user_path(@user)
    end 
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
  
end
