defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds the report" do
      file_name = "report_test.csv"

      response = ReportsGenerator.build(file_name)

      expected = %{
        products: %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pizza" => 2
        },
        users: %{
          "1" => 48,
          "10" => 36,
          "2" => 45,
          "3" => 31,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert response == expected
    end
  end

  describe "fetch_higher_cost/2" do
    test "when the option is ':users', should return the user who spent the most" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost(:users)

      expected = {:ok, {"5", 49}}

      assert response == expected
    end

    test "when the option is ':products', should return the most sold product" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost(:products)

      expected = {:ok, {"esfirra", 3}}

      assert response == expected
    end

    test "should return an error when is given an invalid option" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost(:sales)

      expected = {:error, :invalid_option}

      assert response == expected
    end
  end
end
