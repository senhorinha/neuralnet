DoubleSpiral = setRefClass("DoubleSpiral",
  contains = "Dataset",
  methods = list(
    points = function() {
      spiral_one = Spiral$new(700, 0.1, FALSE, 'spiral_one')
      spiral_two = Spiral$new(700, 0.1, TRUE, 'spiral_two')
      one_points = spiral_one$points()
      two_points = spiral_two$points()
      rbind(one_points, two_points)
    }
  )
)
