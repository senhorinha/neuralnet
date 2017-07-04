Spiral = setRefClass("Spiral",
  contains = "Dataset",
  fields = list(length = 'numeric', growthSpeed = 'numeric', inverseGrowth = 'logical', identifier = 'character'),
  methods = list(
     initialize = function(length, growthSpeed, inverseGrowth = FALSE, identifier = paste(c('id', sample(1:100, 1)), collapse = " ")) {
      .self$length = length
      .self$growthSpeed = growthSpeed
      .self$inverseGrowth = inverseGrowth
      .self$identifier = identifier
     },

    points = function() {
      spiralPoints = matrix(0, length, 2)

      for (index in 1:length) {
          angle = growthSpeed * index;
          x = (1 + angle) * cos(angle);
          y = (1 + angle) * sin(angle);
          spiralPoints[index, ] = c(x, y)
      }
      if (inverseGrowth) {
          spiralPoints = spiralPoints * -1
      }

      cbind(spiralPoints, matrix(identifier, length, 1))
    }
  )
)
