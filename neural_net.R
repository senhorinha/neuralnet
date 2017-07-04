source('dependencies.R')

dataset = IrisDataset$new()
pointsWithClass = dataset$points()
classIndex = ncol(pointsWithClass)

onlyPoints = matrix(as.numeric(unlist(pointsWithClass[, -1 * classIndex])), nrow = nrow(pointsWithClass))
maxs = apply(onlyPoints, 2, max) 
mins = apply(onlyPoints, 2, min)
normalizedPoints = matrix(unlist(scale(onlyPoints, center = mins, scale = maxs - mins)), nrow = nrow(onlyPoints))

pointsWithClass[, 1 : classIndex - 1] = normalizedPoints

train = sample(nrow(pointsWithClass), nrow(pointsWithClass) * 0.5)
valid = seq(nrow(pointsWithClass))[-train]

neuralTrain = pointsWithClass[train,]
neuralValid = pointsWithClass[valid,]
avaiableClasses = unique(pointsWithClass[, classIndex])

for(clazz in avaiableClasses) {
  neuralTrain = cbind(neuralTrain, as.integer(neuralTrain[,classIndex] == clazz))
}

neuralTrain = neuralTrain[, -1 * classIndex]
neuralTrain = matrix(as.numeric(unlist(neuralTrain)),nrow=nrow(neuralTrain))

inputNames = sprintf("Input%d", 1:(classIndex - 1))
colnames(neuralTrain) = c(inputNames, avaiableClasses)

neuralNetInputLabel = paste(inputNames, collapse = ' + ')
neuralNetOutputLabel = paste(avaiableClasses, collapse = '+')
neuralNetFormula = as.formula(paste(c(neuralNetOutputLabel, neuralNetInputLabel), collapse = '~'))

# https://www.rdocumentation.org/packages/neuralnet/versions/1.33/topics/neuralnet
neuralNet = neuralnet(
  neuralNetFormula,
  neuralTrain, 
  hidden=c(3, 3, 3),
  threshold = 0.01, # a numeric value specifying the threshold for the partial derivatives of the error function as stopping criteria.
  stepmax = 1e+6, # the maximum steps for the training of the neural network. Reaching this maximum leads to a stop of the neural network's training process.
  rep = 1, # the number of repetitions for the neural network's training.
  startweights = NULL, # a vector containing starting values for the weights. The weights will not be randomly initialized.
  learningrate.limit = NULL, # a vector or a list containing the lowest and highest limit for the learning rate. Used only for RPROP and GRPROP.
  learningrate.factor = list(minus = 0.5, plus = 1.2), # a vector or a list containing the multiplication factors for the upper and lower learning rate. Used only for RPROP and GRPROP.
  learningrate=0.03, # a numeric value specifying the learning rate used by traditional backpropagation. Used only for traditional backpropagation.
  lifesign = "none", # a string specifying how much the function will print during the calculation of the neural network. 'none', 'minimal' or 'full'.
  lifesign.step = 1000, # an integer specifying the stepsize to print the minimal threshold in full lifesign mode.
  algorithm = "backprop", # a string containing the algorithm type to calculate the neural network. The following types are possible: 'backprop', 'rprop+', 'rprop-', 'sag', or 'slr'. 'backprop'
  err.fct = "ce", # a differentiable function that is used for the calculation of the error. Alternatively, the strings 'sse' and 'ce' which stand for the sum of squared errors and the cross-entropy can be used.
  act.fct = "logistic", # a differentiable function that is used for smoothing the result of the cross product of the covariate or neurons and the weights. Additionally the strings, 'logistic' and 'tanh' are possible for the logistic function and tangent hyperbolicus.
  linear.output = FALSE, # logical. If act.fct should not be applied to the output neurons set linear output to TRUE, otherwise to FALSE.
  exclude = NULL, # a vector or a matrix specifying the weights, that are excluded from the calculation. If given as a vector, the exact positions of the weights must be known. A matrix with n-rows and 3 columns will exclude n weights, where the first column stands for the layer, the second column for the input neuron and the third column for the output neuron of the weight.
  constant.weights = NULL, # a vector specifying the values of the weights that are excluded from the training process and treated as fix.
  likelihood = FALSE # logical. If the error function is equal to the negative log-likelihood function, the information criteria AIC and BIC will be calculated. Furthermore the usage of confidence.interval is meaningfull.
)

comp = compute(neuralNet, matrix(as.numeric(unlist(neuralValid[, -1 * classIndex])), nrow = nrow(neuralValid)))
pred.weights = comp$net.result
idx <- apply(pred.weights, 1, which.max)
pred <- avaiableClasses[idx]
print(table(pred, neuralValid[,classIndex]))

neuralNetResult = as.data.frame(t(neuralNet$result))

print(sprintf("Error: %f", neuralNetResult$error))
print(sprintf("Steps: %f", neuralNetResult$steps))
plot(neuralNet)