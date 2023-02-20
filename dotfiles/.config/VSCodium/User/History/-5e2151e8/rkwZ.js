var result = document.getElementById("result");

function calculate(value) {
  result.value += value;
}

function clearResult() {
  result.value = "";
}

function getResult() {
  result.value = eval(result.value);
}
