defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "When all params are valid, returns the imc info.", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_response = %{
        "result" => %{
          "Alisson" => 25.48476454293629,
          "Diego" => 23.04002019946976,
          "Rafael" => 23.301094832264035
        }
      }

      assert response == expected_response
    end

    test "When there are invalid params, returns an error.", %{conn: conn} do
      params = %{"filename" => "banana.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_response = %{"result" => "Error while opening the file"}

      assert response == expected_response
    end
  end
end
