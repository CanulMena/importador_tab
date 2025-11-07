require "test_helper"

class PedidosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pedidos_index_url
    assert_response :success
  end

  test "should get import" do
    get pedidos_import_url
    assert_response :success
  end
end
