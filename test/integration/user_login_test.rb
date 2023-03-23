require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  # test if the login is invalid
  test "login with invalid information" do
    # get the path kung ano itetest
    get login_path
    # what template
    assert_template "logins/new"
    # test the login and add no email and pass
    post login_path, params: {user: {
      email: "",
      password: ""
    }}
    # what template
    assert_template :new

    # check if not flash exist
    assert_not flash.empty?

  end

  # test user is valid login 
  test "login with valid information" do
    # get the path kung ano itetest
    get login_path
    # what template
    assert_template "logins/new"
    # test the login and add no email and pass
    post login_path, params: {user: {
      email: @user.email,
      password: "password"
    }}
    # what template
    assert_redirected_to microposts_path
    follow_redirect!
    # kung saan maredirect
    assert_template "microposts/index"

    # check the anchor 
    assert_select "a[href=?]",login_path,count: 0
    assert_select "a[href=?]",logout_path
  
  end

   test "login with remembering" do 
    log_in_as(@user,remember_me: '1')
    assert_not_empty cookies[:remember_token]
  end

  test "login without remembering" do
    # set cookie
    log_in_as(@user,remember_me:"1")
    # log in again and verify that the cookie is deleted
    log_in_as(@user,remember_me:"0")
    assert_empty cookies[:remember_token]
  end
end
