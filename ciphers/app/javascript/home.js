// Handle input type change
const inputTextHTML = `<label for="input_text">Input text:</label>
<textarea required id="input_text" rows="5" cols="60" name="input_text" ></textarea>`;
const inputFileHTML = `<label for="input_file">Input file:</label>
<input required type="file" id="input_file" name="input_file">`;

const inputType = document.getElementById("input_type");

inputType.addEventListener("change", (e) => {
  // Modifiy input field to match the selected type
  const inputField = document.getElementById("input_field");
  if (e.target.value === "text") {
    inputField.innerHTML = inputTextHTML;
  } else if (e.target.value === "file") {
    inputField.innerHTML = inputFileHTML;
  }
});

// Handle output type change
let decoder = new TextDecoder("ascii");

const textAreaOutput = document.getElementById("ciphertext-output");
const textAreaOutputBytes = document.getElementById("ciphertext-output-bytes");

const textAreaOutputBytesValue = textAreaOutputBytes.value;

const convertedBytes = decoder.decode(
  new Uint8Array(
    textAreaOutputBytesValue
      .trim()
      .replace(/[\[\]\ ]/g, "")
      .split(",")
      .map(Number)
  )
);

textAreaOutput.value = convertedBytes;

// Add event listener to plaintext button
const plaintextButton = document.getElementById("plaintext");
plaintextButton.addEventListener("click", () => {
  textAreaOutput.value = convertedBytes;
});

// Add event listener to base64 button
const base64Button = document.getElementById("base64");
base64Button.addEventListener("click", () => {
  textAreaOutput.value = btoa(convertedBytes);
});
