defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "When all params are valid, returns a valid changeset." do
      params = %{name: "Teste1", email: "1@teste.com", password: "123456"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        changes: %{name: "Teste1", email: "1@teste.com", password: "123456"},
        errors: []
      } = response
    end

    test "When there are invalid params, returns a invalid changeset." do
      params = %{name: "T", email: "1@teste.com"}

      response = User.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
