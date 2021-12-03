# Run solve() for last modified file

mod_name =
  Path.wildcard("**/*.ex")
  |> Enum.map(fn x -> {x, File.stat!(x) |> Map.fetch!(:mtime)} end)
  |> Enum.max_by(fn {_filename, mtime} -> mtime end)
  |> elem(0)
  |> Code.require_file
  |> List.first
  |> elem(0)
  |> IO.inspect(label: "Puzzle")

Mix.Tasks.Run.run(["-e", "#{mod_name}.solve()"])
