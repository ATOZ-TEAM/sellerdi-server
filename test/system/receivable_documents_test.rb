require "application_system_test_case"

class ReceivableDocumentsTest < ApplicationSystemTestCase
  setup do
    @receivable_document = receivable_documents(:one)
  end

  test "visiting the index" do
    visit receivable_documents_url
    assert_selector "h1", text: "Receivable Documents"
  end

  test "creating a Receivable document" do
    visit receivable_documents_url
    click_on "New Receivable Document"

    click_on "Create Receivable document"

    assert_text "Receivable document was successfully created"
    click_on "Back"
  end

  test "updating a Receivable document" do
    visit receivable_documents_url
    click_on "Edit", match: :first

    click_on "Update Receivable document"

    assert_text "Receivable document was successfully updated"
    click_on "Back"
  end

  test "destroying a Receivable document" do
    visit receivable_documents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Receivable document was successfully destroyed"
  end
end
