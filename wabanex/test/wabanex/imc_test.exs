defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "When the file exists, returns the data." do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:ok,
          %{
            "Alisson" => 25.48476454293629,
            "Diego" => 23.04002019946976,
            "Rafael" => 23.301094832264035
          }
        }

      assert response == expected_response
    end

    test "When the wrong filename is given, returns the data." do
      params = %{"filename" => "banana.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:error, "Error while opening the file"}

      assert response == expected_response
    end
  end
end
