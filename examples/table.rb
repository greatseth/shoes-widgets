require "../table"

CSV = <<-CSV
id,name,description
1,seth,great
2,joe,dude
3,bob,no buts
CSV

Shoes.app do
  t = table :background => white, :stroke => black, :zebra => green, :margin => 10 do
    CSV.split("\n").each_with_index do |line,i|
      method = 0 == i ? :header : :row
      send method, *line.split(",")
    end
  end
  
  t.column_widths[0]  = 50
end
