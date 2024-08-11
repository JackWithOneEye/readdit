defmodule WithElixir do
  def readdit do
    start = System.monotonic_time(:microsecond)

    {lines, chars} =
      System.argv()
      |> OptionParser.parse(strict: [input: :string])
      |> case do
        {[input: input], _, _} ->
          input
          |> File.stream!(:line)
          |> Stream.map(&String.trim/1)
          |> Enum.reduce({0, 0}, fn line, {lines, chars} ->
            {lines + 1, chars + String.length(line)}
          end)

        _ ->
          raise "input file argument not given"
      end

    dur = System.monotonic_time(:microsecond) - start

    IO.puts(
      "The input file contains #{lines} lines of text and #{chars} characters. The execution of this script took #{dur / 1000} ms"
    )
  end
end

WithElixir.readdit()
