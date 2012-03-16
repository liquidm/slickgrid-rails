# native javascript sorter. used by default if no sorter is specified
NativeSorter = (field, dir, a, b) ->
  x = a[field]
  y = b[field]
  return 0 if x == y
  return dir * if x < y then -1 else 1

# simple sorter factory to read sorter function from column defintion while
# retaining the current closures sort column and sort direction
class SorterFactory
  constructor: (args) ->
    @sortCol = args.sortCol
    @sortField = args.sortCol.field
    @sortDir = if args.sortAsc then 1 else -1
    @sortMethod = if @sortCol.sorter? then @sortCol.sorter else NativeSorter

    return (a, b) =>
      return @sortMethod(@sortField, @sortDir, a, b)

# merge sorter functions into global slickgrid namespace
$.extend(true, window, {
  "Slick": {
    "Sorters": {
      "Sorter": SorterFactory
      "Native": NativeSorter
    }
  }
})
