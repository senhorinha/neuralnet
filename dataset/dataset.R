Dataset = setRefClass("Dataset",
    methods = list(
      point = function() {
        print('Must implement!')
      },

      buildFilePath = function (filename) {
        paste(getwd(), 'dataset', filename, sep = '/')
      }
    )
)
