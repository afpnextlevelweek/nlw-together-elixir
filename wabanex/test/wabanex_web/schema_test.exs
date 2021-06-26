defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "When a valid id is given, returns the user.", %{conn: conn} do
      params = %{email: "1@teste.com", name: "Teste1", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "1@teste.com",
            "name" => "Teste1"
          }
        }
      }

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "When all params are valid, creates the user.", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Teste0",
            email: "0@teste.com",
            password: "123456"
          }) {
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Teste0"}}} = response
    end
  end
end
