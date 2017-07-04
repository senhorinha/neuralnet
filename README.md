# Implementação de Redes Neurais

**Thiago Senhorinha Rose (12100774)**

## Pré-requisitos

Versão do **R 3.2+**

Esse trabalho foi desenvolvido utilizando a linguagem de programação R e utiliza as bibliotecas ```readxl``` para leitura de arquivos xlsx, ```hashmap``` para utilizar hashmap e ```neuralnet``` para as redes neurais. Instale os pacotes no R com o seguinte comando:

```r
install.packages(c("readxl", "hashmap", "neuralnet"), dependencies=TRUE)
```

## Como executar?

1. Primeirmanete é preciso entrar no modo de execução de scripts R na pasta raiz do projeto (/neuralnet)
2. Depois execute o comando
```R
source('neural_net.R')
```

# Normalização

Para validar o impacto da normalização dos dados de entrada no treinamento da rede neural, primeiramente foi testado a convergência com os seguintes parâmetros de configuração da rede

```r
neuralNet = neuralnet(
  neuralNetFormula,
  neuralTrain, 
  hidden=c(15)
)
```
e utilizando o dataset da Iris mas sem a normalização. Notou-se que a rede neural não conseguiu convergir. Posteriormente, foi utilizada a mesma configuração da rede neural e percebeu-se que ela rapidamente convergiu. Com isso, ficou validada a importância da normalização na velocidade de convergência.

A normalização escolhida foi min-max no intervalo de [0, 1]

# Configuração da Rede

## Neurônios e camadas internas

Não há uma regra fixa quanto ao número de camadas e neurônios a serem utilizados, embora existam várias regras mais ou menos aceitas. Geralmente, utilizar apenas uma camada é o suficiente para a maioria das aplicações. Já no que diz respeito ao número de neurônios, as heuristicas definem que ele deve estar entre o tamanho da camada de entrada e a camada de saída deve ser 2/3 do tamanho da camada de entrada. Como são apenas heurísticas, não é definitivo que segui-las irá trazer a melhor solução, por isso, é necessário testar com diversos parâmetros diferentes. 

| Neurônio nas Camadas 	| Erro médio de 30 execuções 	|
|----------------------	|----------------------------	|
| 1 	| 11.80669059 	|
| 2 	| 1.986444496 	|
| 4 	| 0.7840962151 	|
| 5 	| 0.6267159935 	|
| 10 	| 0.6036824877 	|
| 2,2 	| 0.5924483326 	|
| 3, 2 	| 0.2254971209 	|
| 4,2 	| Não converge 	|
| 3,3 	| 0.201641414 	|
| 3,4 	| Não converge 	|
| 3, 3, 3 	| 0.1020252158 	|
| 3, 3, 2 	| 0.540030957 	|
| 3,2,2 	| 0.1503522047 	|

Através dos testes feitos descobrimos que uma rede com 3 camadas de 3 neurônios em cada camada é a arquitetura da rede com menor erro para o problema da Iris.

## Influência da taxa de aprendizado

### Backpropagation

Percebeu-se que assim como aponta a literatura, a taxa de aprendizado não pode ser nem muito baixa a ponto de tornar o aprendizado muito lento como também não deve ser muito alta pois torna os pesos e a função objetiva divergentes, portanto, não há aprendizado.  Conclui-se que uma taxa de aprendizado intermediária é a escolha certa.

| Taxa de aprendizado 	| Média de interações de 30 execuções 	| Erro médio de 30 execuções 	|
|---------------------	|-------------------------------------	|----------------------------	|
| 0.003 	| 90990 	| 1.731988486 	|
| 0.03 	| 7561 	| 0.4117099858 	|
| 0.3 	| 12720 	| 1.049465829 	|
| 3 	| 7.75 	| 35.15447795 	|
| 30 	| 2.5 	| 45.78078832 	|
