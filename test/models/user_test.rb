require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user= User.create(name:"arishavess eds",email:"arish18@gmail.com",password:"karlkarl18",password_confirmation:"karlkarl18")
  end
  
  # test if the @user is valid
  test "user should be valid" do
    assert @user.valid?
  end

  # check if the name is present
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  # check if the email is present
  test "email should be present" do
    @user.email ="    "
    assert_not @user.valid?
  end

  # check if the name is too long
  test "should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  # check if the email is too long 
  test "email should not be too long" do
    @user.email = "a"*520 +"@gmail.com"
  end

   # check the format of the email
   test "email validations should accept valid addresses" do 
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  #check if the lowercase email equals to mixed case of email
  test "email should be lowercase" do
    mixed_email = "arIsH18@gmail.com"
    @user.email = mixed_email
    assert_equal mixed_email.downcase,@user.reload.email
  end
  
   # check if the user is user not check the remember me 
   test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticate?("")
  end


end
