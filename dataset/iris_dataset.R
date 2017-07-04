IrisDataset = setRefClass("IrisDataset",
    contains = "Dataset",
    methods = list(
      points = function() {
        matrix = unname(as.matrix(read_excel(paste(getwd(), 'dataset', 'iris.xlsx', sep = '/'))))
        rowsSize = dim(matrix)[1]
        columnsSize = 5
        dataPoints = matrix(0, rowsSize, columnsSize)

        for(matrixIndex in 1:rowsSize) {
          row = matrix[matrixIndex, ]
          clazz = row[columnsSize]  # Find class
          rowValues = row[seq(1, 4)]
          dataPoints[matrixIndex, ] = c(rowValues, clazz)
        }
        dataPoints
      }
    )
)
