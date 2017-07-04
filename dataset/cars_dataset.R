CarsDataset = setRefClass("CarsDataset",
    contains = "Dataset",
    methods = list(
      points = function(classColumnNumber) {
        matrix = as.matrix(read_excel(paste(getwd(), 'dataset', 'cars.xlsx', sep = '/')))
        rowsSize = dim(matrix)[1]
        columnsSize = dim(matrix)[2]
        dataPoints = matrix(0, rowsSize, columnsSize)

        for(matrixIndex in 1:rowsSize) {
          row = matrix[matrixIndex, ]
          clazz = trim(row[1])
          rowValues = as.numeric(row[seq(2, columnsSize)])
          dataPoints[matrixIndex, ] = c(rowValues, clazz)
        }
        dataPoints
      },

      trim = function (x) gsub("^\\s+|\\s+$", "", x)
    )
)
