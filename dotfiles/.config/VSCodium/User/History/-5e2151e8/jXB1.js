const numberInput = document.getElementById("number");
const percentInput = document.getElementById("percent");
const resultInput = document.getElementById("result");
const calculateButton = document.getElementById("calculate");

calculateButton.addEventListener("click", function() {
  const number = Number(numberInput.value);
  const percent = Number(percentInput.value);
  const result = number * (percent / 100);
  resultInput.value = result.toFixed(2);
});

const numberInput = document.getElementById("number");
const percentInput = document.getElementById("percent");
const resultInput = document.getElementById("result");
const calculateButton = document.getElementById("calculate");
const xNumberInput = document.getElementById("x-number");
const xResultInput = document.getElementById("x-result");
const xCalculateButton = document.getElementById("x-calculate");

calculateButton.addEventListener("click", function() {
  const number = Number(numberInput.value);
  const percent = Number(percentInput.value);
  const result = number * (percent / 100);
  resultInput.value = result.toFixed(2);
});

xCalculateButton.addEventListener("click", function() {
  const xNumber = Number(xNumberInput.value);
  const percent = Number(percentInput.value);
  const result = (percent / 100) * xNumber;
  xResultInput.value = result.toFixed(2);
});
