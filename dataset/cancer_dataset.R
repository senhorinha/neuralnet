CancerDataset = setRefClass("CancerDataset",
    contains = "Dataset",
    methods = list(
      points = function(classColumnNumber) {
        matrix = unname(as.matrix(read_excel(paste(getwd(), 'dataset', 'cancer.xls', sep = '/'))))
        rowsSize = dim(matrix)[1]
        columnsSize = 5
        dataPoints = matrix(0, rowsSize, columnsSize)

        for(matrixIndex in 1:rowsSize) {
          row = matrix[matrixIndex, ]
          clazz = which(row[seq(5, 8)] %in% 1)  # Find class
          if(length(clazz) == 0) {
            clazz = 0;
          }
          rowValues = row[seq(1, 4)]
          dataPoints[matrixIndex, ] = c(rowValues, clazz)
        }
        dataPoints
      }
    )
)
