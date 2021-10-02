require "test_helper"

class Api::ReceivableDocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @receivable_document = receivable_documents(:one)
  end

  test "should get index" do
    get api_receivable_documents_url
    assert_response :success
  end

  test "should get new" do
    get new_api_receivable_document_url
    assert_response :success
  end

  test "should create receivable_document" do
    assert_difference('ReceivableDocument.count') do
      post api_receivable_documents_url, params: { receivable_document: {  } }
    end

    assert_redirected_to receivable_document_url(ReceivableDocument.last)
  end

  test "should show receivable_document" do
    get api_receivable_document_url(@receivable_document)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_receivable_document_url(@receivable_document)
    assert_response :success
  end

  test "should update receivable_document" do
    patch api_receivable_document_url(@receivable_document), params: { receivable_document: {  } }
    assert_redirected_to receivable_document_url(@receivable_document)
  end

  test "should destroy receivable_document" do
    assert_difference('ReceivableDocument.count', -1) do
      delete api_receivable_document_url(@receivable_document)
    end

    assert_redirected_to api_receivable_documents_url
  end
end
