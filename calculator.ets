// Calculator.ets
@Entry
@Component
struct Calculator {
  @State displayText: string = '0'
  @State firstOperand: number = 0
  @State operator: string = ''
  @State waitingForSecondOperand: boolean = false

  build() {
    Column() {
      // 显示区域
      Text(this.displayText)
        .fontSize(50)
        .textAlign(TextAlign.End)
        .width('100%')
        .height(80)
        .margin({ bottom: 20 })

      // 第一行按钮
      Row() {
        Button('7')
          .onClick(() => this.inputDigit('7'))
          .width('25%')
          .height(80)
        Button('8')
          .onClick(() => this.inputDigit('8'))
          .width('25%')
          .height(80)
        Button('9')
          .onClick(() => this.inputDigit('9'))
          .width('25%')
          .height(80)
        Button('/')
          .onClick(() => this.handleOperator('/'))
          .width('25%')
          .height(80)
      }.width('100%').margin({ bottom: 10 })

      // 第二行按钮
      Row() {
        Button('4')
          .onClick(() => this.inputDigit('4'))
          .width('25%')
          .height(80)
        Button('5')
          .onClick(() => this.inputDigit('5'))
          .width('25%')
          .height(80)
        Button('6')
          .onClick(() => this.inputDigit('6'))
          .width('25%')
          .height(80)
        Button('*')
          .onClick(() => this.handleOperator('*'))
          .width('25%')
          .height(80)
      }.width('100%').margin({ bottom: 10 })

      // 第三行按钮
      Row() {
        Button('1')
          .onClick(() => this.inputDigit('1'))
          .width('25%')
          .height(80)
        Button('2')
          .onClick(() => this.inputDigit('2'))
          .width('25%')
          .height(80)
        Button('3')
          .onClick(() => this.inputDigit('3'))
          .width('25%')
          .height(80)
        Button('-')
          .onClick(() => this.handleOperator('-'))
          .width('25%')
          .height(80)
      }.width('100%').margin({ bottom: 10 })

      // 第四行按钮
      Row() {
        Button('0')
          .onClick(() => this.inputDigit('0'))
          .width('50%')
          .height(80)
        Button('.')
          .onClick(() => this.inputDecimal())
          .width('25%')
          .height(80)
        Button('+')
          .onClick(() => this.handleOperator('+'))
          .width('25%')
          .height(80)
      }.width('100%').margin({ bottom: 10 })

      // 第五行按钮
      Row() {
        Button('C')
          .onClick(() => this.clearAll())
          .width('50%')
          .height(80)
        Button('=')
          .onClick(() => this.handleEqual())
          .width('50%')
          .height(80)
      }.width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(10)
  }

  // 输入数字
  inputDigit(digit: string) {
    if (this.waitingForSecondOperand) {
      this.displayText = digit
      this.waitingForSecondOperand = false
    } else {
      this.displayText = this.displayText === '0' ? digit : this.displayText + digit
    }
  }

  // 输入小数点
  inputDecimal() {
    if (this.waitingForSecondOperand) {
      this.displayText = '0.'
      this.waitingForSecondOperand = false
      return
    }

    if (this.displayText.indexOf('.') === -1) {
      this.displayText += '.'
    }
  }

  // 处理操作符
  handleOperator(nextOperator: string) {
    const inputValue = parseFloat(this.displayText)

    if (this.operator && !this.waitingForSecondOperand) {
      const result = this.calculate(this.firstOperand, inputValue, this.operator)
      this.displayText = String(result)
      this.firstOperand = result
    } else {
      this.firstOperand = inputValue
    }

    this.waitingForSecondOperand = true
    this.operator = nextOperator
  }

  // 计算
  calculate(firstOperand: number, secondOperand: number, operator: string): number {
    switch (operator) {
      case '+':
        return firstOperand + secondOperand
      case '-':
        return firstOperand - secondOperand
      case '*':
        return firstOperand * secondOperand
      case '/':
        return firstOperand / secondOperand
      default:
        return secondOperand
    }
  }

  // 处理等号
  handleEqual() {
    if (!this.operator) {
      return
    }

    const inputValue = parseFloat(this.displayText)
    const result = this.calculate(this.firstOperand, inputValue, this.operator)
    
    this.displayText = String(result)
    this.firstOperand = result
    this.waitingForSecondOperand = true
    this.operator = ''
  }

  // 清除所有
  clearAll() {
    this.displayText = '0'
    this.firstOperand = 0
    this.operator = ''
    this.waitingForSecondOperand = false
  }
}
