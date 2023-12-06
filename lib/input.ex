defmodule Input do
  defp read_file!(file_name, :sample), do: File.read!("inputs/sample/#{file_name}")
  defp read_file!(file_name, :sample_pt2), do: File.read!("inputs/sample_pt2/#{file_name}")
  defp read_file!(file_name, :solution), do: File.read!("inputs/solution/#{file_name}")

  def read!(day, type \\ :solution)

  def read!(day, type) do
    day = day |> to_string |> String.pad_leading(2, "0")
    read_file!("day#{day}.txt", type)
  end
end
