require 'test_helper'

class DivisionsControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get divisions_controller_new_url
    assert_response :success
  end

  test "should get create" do
    get divisions_controller_create_url
    assert_response :success
  end

  test "should get show" do
    get divisions_controller_show_url
    assert_response :success
  end

  test "should get edit" do
    get divisions_controller_edit_url
    assert_response :success
  end

  test "should get update" do
    get divisions_controller_update_url
    assert_response :success
  end

  test "should get index" do
    get divisions_controller_index_url
    assert_response :success
  end

  test "should get destroy" do
    get divisions_controller_destroy_url
    assert_response :success
  end

end
