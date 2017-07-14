defmodule VinculiApi.Web.MetadataControllerTest do
  use VinculiApi.Web.ConnCase, async: true

  test "get node labels" do
    response = build_conn()
    |> get(metadata_path(build_conn(), :node_labels))
    |> json_response(200)

    expected = ["Continent", "Country", "Degree", "Domain", "Institution",
                "Language", "Person", "Profession", "Publication", "School",
                "Town", "Translation", "Year"]

    assert response == expected
  end
end