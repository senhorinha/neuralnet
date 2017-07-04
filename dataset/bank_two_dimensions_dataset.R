BankTwoDimensionsDataset = setRefClass("BankTwoDimensionsDataset",
    contains = "Dataset",
    methods = list(
      points = function(classColumnNumber) {
        matrix = as.matrix(read_excel(paste(getwd(), 'dataset', 'bank.xlsx', sep = '/')))
        rowsSize = dim(matrix)[1]
        columnsSize = dim(matrix)[2]
        dataPoints = matrix(0, rowsSize, 3)

        for(matrixIndex in 1:rowsSize) {
          row = matrix[matrixIndex, ]
          clazz = if(row[2] == 1) 'paid' else 'pending'
          rowValues = as.numeric(row[c(4, 7)])
          dataPoints[matrixIndex, ] = c(rowValues, clazz)
        }
        dataPoints
      },

      trim = function (x) gsub("^\\s+|\\s+$", "", x)
    )
)
