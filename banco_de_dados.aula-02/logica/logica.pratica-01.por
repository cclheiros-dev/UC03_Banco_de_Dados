programa {
  funcao inicio() {
  real pesoCaixa, tempCamara, pesoTotal
  inteiro quantCaixa, paleteCompleto, palheto, caixasSobrando

 paleteCompleto = 40

    escreva("qual a quantidade de caixas produzidas?\n")
leia(quantCaixa)
    escreva("qual o peso de cada caixa em kg?\n")
    leia(pesoCaixa)

    escreva("qual a temperatura da camara em °c?\n")
    leia(tempCamara)

pesoTotal = pesoCaixa * quantCaixa
    palheto = quantCaixa / paleteCompleto
    caixasSobrando = quantCaixa % paleteCompleto

    escreva("peso total: ", pesoTotal, " kg\n")
    escreva("paletes completos: ", palheto, "\n")
    escreva("caixas sobrando: ", caixasSobrando, "\n")

    se (tempCamara <= -18 e palheto >= 1) {
  escreva("carregamento liberado!")
    } senao {
    se (tempCamara > -18) {
    escreva("bloqueado: camara acima de -18 °c")
        } senao {
   escreva("bloqueado: nenhum palete completo")
  }
}
}
}
